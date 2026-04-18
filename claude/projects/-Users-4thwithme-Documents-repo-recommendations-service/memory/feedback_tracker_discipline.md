---
name: Tracker discipline enforcement
description: ai-monkey skill must enforce progress tracker updates after every step — never batch or skip
type: feedback
---

Progress tracker updates in ai-monkey must be enforced mechanically, not relied on as a "general rule."

**Why:** During RECO-666, the orchestrator completed all 14 steps correctly but left Steps 6-14 unchecked in the tracker, didn't log any subagents, and pasted no evidence. The tracker was useless for session recovery.

**How to apply:** The SKILL.md now has `>>> TRACKER UPDATE <<<` blocks after every step with exact content to write, plus a TRACKER GATE rule requiring reading the tracker before starting each new step. Follow these literally — they are orders, not suggestions.
