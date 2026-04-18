---
name: create-pr
description: Create pull requests with automated validation against Jira tasks. Use when user requests to create a PR, make a pull request, or open a pull request. Validates committed changes against Jira task description, identifies missing work, gets user confirmation, and creates draft PR with fulfilled template.
---

# Create PR

Automated pull request creation workflow with Jira task validation.

## Workflow

Follow these steps sequentially:

### 1. Get Atlassian Cloud ID

Read cloud ID from environment file:

```bash
grep ATLASSIAN_CLOUD_ID .env | cut -d'=' -f2
```

Store for use in Jira API calls.

### 2. Detect Base Branch (CRITICAL)

Branches in this repo are stacked — each branch is cut from the previous task's branch, not from `main`. Using `main` as base would include all upstream commits in the diff, polluting the PR.

Detect the correct base branch:

```bash
# Show current branch
git branch --show-current

# Find the most recent remote branch this branch was cut from
# (excludes HEAD and the current branch itself)
git log --format='%D' HEAD | grep 'origin/' | grep -v 'HEAD' | head -5

# Alternative: find remote branches containing the fork point
git branch -r --contains $(git merge-base HEAD origin/main) | grep -v "$(git branch --show-current)" | head -10
```

**Rules:**
- If the branch was cut directly from `main` → base = `main`
- If the branch was cut from another feature branch → base = that feature branch (e.g., `RECO-646-fix-eslint-root-categories-style-alternatives`)
- When uncertain → ask the user: "What branch was this cut from?"

Store the base branch name. Use it for ALL subsequent `git log` and `git diff` commands and for `--base` in `gh pr create`.

### 3. Validate Branch State

Check current branch and commit status against the **detected base branch**:

```bash
git log origin/<BASE_BRANCH>..HEAD --oneline
```

**Exit conditions:**

- Current branch is `main` or `master` → Respond: "No changes"
- No commits ahead of base branch → Respond: "No changes"

### 4. Extract Jira Task ID

Parse task ID from branch name using pattern `RECO-\d+`:

**Examples:**

- `RECO-349-task-naming` → Task ID: `RECO-349`
- `RECO-1234-fix-bug` → Task ID: `RECO-1234`

If no match found → Ask user: "Cannot extract task ID from branch name. Provide task ID or continue without validation?"

### 5. Fetch Jira Task

Use Atlassian MCP tool with cloud ID from step 1:

```typescript
mcp__plugin_atlassian_atlassian__getJiraIssue({
	cloudId: CLOUD_ID_FROM_STEP_1,
	issueIdOrKey: 'RECO-349',
});
```

Extract:

- Task title
- Task description
- Acceptance criteria
- Subtasks (if any)

### 6. Analyze Committed Changes

Review all commits in current branch against the base branch:

```bash
git log origin/<BASE_BRANCH>..HEAD --stat
git diff origin/<BASE_BRANCH>..HEAD
```

Read every changed file to understand what was modified and why. Group changes by concern:

- New files created
- Existing files modified (what logic changed and why)
- Config/infra changes
- Test changes

Compare changes against:

- Task description requirements
- Acceptance criteria

### 7. Identify Gaps

Create list of missing items:

- Uncompleted requirements from task description
- Missing acceptance criteria implementations
- Missing tests (if specified)

**Format:**

```
Missing items:
- [ ] Item 1 description
- [ ] Item 2 description
- [ ] Item 3 description
```

If no gaps found → State: "All task requirements appear to be implemented."

### 8. Request Confirmation

Present findings and ask for confirmation:

```
Summary:
- Branch: [branch-name]
- Base: [base-branch]
- Task: [TASK-ID] - [task title]
- Commits: [count] commits

[Missing items list or "All requirements met"]

Create draft PR with current state?
```

Wait for user confirmation. If declined → Stop.

### 9. Generate PR Body

Read the PR template:

```bash
cat .github/pull_request_template.md
```

Fill every section with **specific, detailed content** — not placeholders:

#### Ticket section
```
JIRA task: [RECO-XXX](https://customink.atlassian.net/browse/RECO-XXX)
Design: [Figma Link](url) — omit if no Figma link
```

#### Changes section
List each changed file or group of related files with a precise explanation:

```markdown
- **`path/to/file.ts`** — What changed and why (e.g., "Added X to fix Y", "Removed Z because it was replaced by W")
- **`path/to/other.ts`** — What changed and why
- **`path/to/test.unit-spec.ts`** — What test cases were added/modified and what behavior they cover
```

Be specific: mention function names, config keys, hook types, or algorithm changes. Do not write vague summaries like "updated service" or "fixed bug".

#### PR Checks section
Check each box that applies based on the actual committed changes:

```markdown
- [x] I've self-reviewed my code.
- [x] I've added the necessary labels.
- [x] I've added tests for my code.        ← only if tests exist in the diff
- [x] I've updated the documentation.     ← only if docs were updated
```

#### Description / Ticket Summary section
Write a concise paragraph (3-5 sentences) explaining:
- What the feature/fix does at a business/product level
- Why it was needed
- Any notable design decisions or trade-offs

Copy from the Jira ticket description if it's good; rewrite if it's vague.

#### Screenshots / Short Videos
Omit if not applicable (backend-only changes). Add if UI changes.

### 10. Create Draft PR

```bash
gh pr create \
  --draft \
  --base <BASE_BRANCH> \
  --title "RECO-XXX: [task title from Jira]" \
  --body "$(cat <<'EOF'
[Filled template content — all sections populated with specific content]
EOF
)"
```

Respond with PR URL and summary.

## Notes

- Always create as **draft** PR
- Always pass `--base <BASE_BRANCH>` — never let `gh` default to `main` when the branch is stacked
- Task ID pattern: `RECO-\d+` (project-specific)
- Use existing tools: `gh` CLI, Atlassian MCP, Git
- Validation is advisory, not blocking — user decides whether to proceed
- PR body must have real content in every section — no template placeholders left unfilled
