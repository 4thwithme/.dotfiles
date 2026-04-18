---
name: PR base branch rule
description: PRs must target the branch they were cut from, not main
type: feedback
---

Always set PR base to the branch this branch was cut from — NOT main.

**Why:** PRs are stacked (chained). Each branch is cut from the previous task's branch. Setting base to main would incorrectly include all upstream commits in the diff.

**How to apply:** Before `gh pr create`, run `git log origin/main..HEAD --oneline` to confirm how many commits are ahead. The base branch = the branch you ran `git checkout -b` from. Pass `--base <previous-branch-name>` to `gh pr create`.
