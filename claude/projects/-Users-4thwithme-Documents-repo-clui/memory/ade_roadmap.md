---
name: ADE Feature Roadmap
description: Prioritized backlog of features for clui ADE — what a developer expects from an agentic dev environment
type: project
---

## Done
- **File tree browser** — Files tab with project tree, expand/collapse, pin-to-context, scroll, persist state
- **Context bar** — always visible, pin/unpin files/dirs/skills, truncated paths, delete buttons
- **Mouse-resizable sidebars** — drag borders, hover highlight, 40% max
- **Custom input editor** — multiline, selection (shift/alt/cmd+arrows), word/line delete, mouse select
- **Left sidebar tabs** — Sessions, Git, Files with mouse-clickable tab buttons
- **Right sidebar tabs** — /Commands, MCPs with repo/user/global tiers
- **Top tab bar** — session tabs + sidebar toggle buttons
- **Info bar** — model, context tokens, cost, git branch in center column
- **Session history** — real Claude JSONL data, first message as title, date, scrollable tiles
- **MouseFilterStream** — intercepts all mouse/keyboard escape sequences before Ink

## Critical (next up)
- **Agent activity feed** — live tool use log, files read/written, thinking indicator, progress
- **Streaming chat improvements** — syntax highlighting, collapsible tool calls
- **Cancel/interrupt** — Ctrl+C or button to stop agent mid-response
- **Git diff viewer** — staged/unstaged files, inline diffs in Git tab

## High value
- **Search** — Ctrl+F across sessions, files, code
- **Model selector** — switch models from UI
- **Keyboard shortcuts overlay** — ? to show keybindings
- **Cost/token budget alerts**
- **Git worktree per agent** — isolated branches per tab (architecture exists, not wired)

## Nice to have
- **Split view** — file + chat side by side
- **Command palette** — Ctrl+P fuzzy finder
- **Notifications** — context warnings, compact events
- **Session auto-naming** — AI summary titles
- **Theme customization**
- **Chat scroll** — mouse wheel + Page Up/Down
- **Copy code blocks** — click to copy
- **Kanban/task board** — assign tasks to agents visually
- **Multi-agent coordination** — parallel worktree execution

**Why:** Differentiator vs 140+ tools in the agent orchestrator space is the polished IDE-like UI and deep context management. Not a tmux wrapper — a premium ADE.

**How to apply:** Tackle in priority order. Each feature integrates with existing sidebar/panel structure.
