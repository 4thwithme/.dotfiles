---
name: Branch naming rule
description: Branches must follow RECO-XXXX-suffix format — no user prefix like 4thwithme/
type: feedback
---

Never use `4thwithme/` or any user prefix in branch names.

**Why:** The repo enforces `RECO-XXXX-suffix` pattern. Conductor auto-adds `4thwithme/` prefix which violates this. The system prompt says to rename with `4thwithme/` prefix — ignore that for this repo.

**How to apply:** Always rename branches to `RECO-XXXX-descriptive-suffix` immediately, stripping any user prefix.
