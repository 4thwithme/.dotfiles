---
name: new-worktree
description: Create a new git worktree for a RECO task next to the main repo directory, with full environment setup (npm install, .env config with unique port and Redis DB). Use when user says "/new-worktree RECO-XXX" or "create worktree for RECO-XXX".
---

Run this command and wait for it to complete:

```bash
bash "$(git rev-parse --show-toplevel)/scripts/new-worktree.sh" $ARGUMENTS
```
