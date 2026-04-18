---
name: code-review
description: Code review a pull request from GitHub using gh CLI. Use when the user asks to: (1) List pull requests, (2) Show a specific PR by number or link, (3) Review PR changes, (4) Display git diff for a PR, or (5) Filter PRs by author, date, or state.
---

# Code Review

## Overview

Review GitHub pull requests using `gh` CLI. List PRs with filters, view PR details, and display git diffs in split mode.

## List Pull Requests

Get all PRs with optional filters:

```bash
# List all PRs
gh pr list

# Filter by state
gh pr list --state open
gh pr list --state closed
gh pr list --state merged
gh pr list --state all

# Filter by author
gh pr list --author username

# Combine filters
gh pr list --author username --state open

# Limit results
gh pr list --limit 50

# Sort by created date
gh pr list --search "sort:created-desc"
gh pr list --search "sort:created-asc"

# Filter by date range (use search queries)
gh pr list --search "created:>=2024-01-01"
gh pr list --search "created:2024-01-01..2024-12-31"
```

## Show Pull Request Details

Display PR information by number or URL:

```bash
# By PR number
gh pr view 234

# By PR number with full details
gh pr view 234 --json title,body,author,state,createdAt,updatedAt,headRefName,baseRefName,url

# From URL
gh pr view https://github.com/owner/repo/pull/234

# Extract PR number from JIRA-style branch (e.g., RECO-234)
# If user provides "RECO-234", search for PR with that branch name:
gh pr list --search "RECO-234 in:title" --limit 1
# Or search by head branch:
gh pr list --head RECO-234-branch-name
```

## Show Git Diff

Display PR changes in split/side-by-side mode:

### Side-by-Side View (Best for Split Mode)

**Option 1: Using delta (recommended):**
```bash
# Install delta if not available: brew install git-delta
gh pr diff 234 | delta --side-by-side

# With line numbers
gh pr diff 234 | delta --side-by-side --line-numbers

# Narrow terminal (wrap lines)
gh pr diff 234 | delta --side-by-side --width=${COLUMNS}
```

**Option 2: Using diff-so-fancy:**
```bash
# Install: brew install diff-so-fancy
gh pr diff 234 | diff-so-fancy
```

**Option 3: Using git diff with side-by-side:**
```bash
# Checkout the PR branch first
gh pr checkout 234
git diff main --color-words --color-moved --side-by-side

# Or without checkout (if you know base/head branches)
git diff origin/main...origin/branch-name --side-by-side
```

**Option 4: Native git side-by-side (no extra tools):**
```bash
# Get PR info
PR_HEAD=$(gh pr view 234 --json headRefName -q .headRefName)
PR_BASE=$(gh pr view 234 --json baseRefName -q .baseRefName)

# Fetch latest
git fetch origin $PR_HEAD:$PR_HEAD 2>/dev/null || git fetch origin

# Side-by-side diff
git diff origin/$PR_BASE...origin/$PR_HEAD --color | less -R
```

### Unified Diff Format

For simple unified view without split mode:

```bash
# Basic diff
gh pr diff 234

# More context lines
gh pr diff 234 -- -U10

# Specific files
gh pr diff 234 -- path/to/file.ts

# Word-level changes
gh pr diff 234 --color-words

# With file separators for chat
gh pr diff 234 | awk '
/^diff --git/ {
    if (NR > 1) print "\n" "="x70 "\n"
    print "📄 File: " $3
    print "="x70
    next
}
{ print }
'
```

### File-by-File Review

For reviewing each file separately:

```bash
# List changed files
gh pr view 234 --json files -q '.files[].path'

# Diff specific file
gh pr diff 234 -- path/to/specific-file.ts | delta --side-by-side
```

## Find PR by Branch Name

When user provides branch name or JIRA ticket:

```bash
# Search by branch name
gh pr list --head RECO-234-branch-name

# Search by title containing ticket
gh pr list --search "RECO-234" --limit 5

# Get PR number from branch
gh pr list --head branch-name --json number --jq '.[0].number'
```

## Review Workflow

1. **List PRs** to find the target PR
2. **View details** to understand context
3. **Show diff** to review changes
4. **Add comments** if needed: `gh pr comment 234 --body "comment"`
5. **Approve/Request changes**: `gh pr review 234 --approve` or `gh pr review 234 --request-changes`

## Common Patterns

**Find my open PRs:**
```bash
gh pr list --author @me --state open
```

**Recent PRs (last 7 days):**
```bash
gh pr list --search "created:>=2024-01-13"
```

**PR from JIRA ticket (e.g., "show PR RECO-234"):**
1. Search by title: `gh pr list --search "RECO-234" --limit 5`
2. Or search by branch: `gh pr list --head RECO-234*`
3. Then view: `gh pr view <number>`
4. Show diff: `gh pr diff <number>`

## Notes

- All commands use current repository context (run from repo directory)
- Use `--repo owner/repo` to specify different repository
- Date format: ISO 8601 (YYYY-MM-DD)
- For large diffs, consider filtering by file path to avoid overwhelming output
