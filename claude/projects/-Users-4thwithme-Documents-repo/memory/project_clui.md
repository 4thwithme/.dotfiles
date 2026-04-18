---
name: clui project
description: TUI wrapper around Claude Code — multi-session tabs, skills sidebar, context management tools. Design complete, implementation not started.
type: project
---

**clui** — a TypeScript + Ink (React) TUI wrapper around Claude Code SDK.

**Location:** `/Users/4thwithme/Documents/repo/clui/`
**Spec:** `clui/docs/superpowers/specs/2026-04-03-clui-design.md`

**Key decisions made:**
- Shell + Workers architecture (process isolation per tab)
- Three-column layout: session history | chat + tabs | skills sidebar
- SQLite for persistence (sessions, messages, pins, snapshots, settings)
- IPC via Unix Domain Sockets
- 3-tier skills: Repo > User > Global (greyed out if overridden)
- Context bar above input shows all active items (pins, skills, commands) — one-shot and sticky
- Status bar below input, user-configurable fields
- Worktrees optional per tab, cleanup prompt on close

**Status as of 2026-04-03:** Design spec complete. Next step: invoke writing-plans skill to create implementation plan (6 phases).

**Why:** User wants a more user-friendly multi-agent dev environment with better UI around Claude Code.

**How to apply:** When user says "continue with clui", read the spec and invoke writing-plans skill.
