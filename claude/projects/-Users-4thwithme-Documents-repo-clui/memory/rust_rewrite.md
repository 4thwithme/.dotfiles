---
name: Rust Rewrite Decision
description: Decision to rewrite clui from Ink/React to Rust/Ratatui — context and rationale
type: project
---

## Decision
Rewrite clui TUI from TypeScript/Ink/React to Rust/Ratatui. Keep existing TS version as prototype reference.

## Why
- Ink has no per-widget click handlers — all mouse positioning is manual coordinate math, constantly broken
- yoga WASM crashes on position="absolute" (ConfirmDialog)
- useInput is global — every component receives every keypress, causing conflicts
- Mouse event interception requires hacky stdin.emit patching / Transform streams
- Performance: Ink re-renders entire screen on any state change

## What Ratatui gives us
- Native mouse support with per-widget click areas (crossterm events)
- No WASM, no yoga — pure Rust layout
- Focus/input routing built into the framework
- Single binary, instant startup
- 10x faster rendering

## Scope
~20-25 hours with Claude Code. Port all features from docs/FEATURES.md.

## Architecture for Rust version
- ratatui + crossterm for TUI
- tokio for async (IPC, file watching, git)
- serde for JSONL parsing (sessions)
- git2 (libgit2) for git operations
- syntect for syntax highlighting
- Keep IPC protocol compatible with existing TS workers (or rewrite workers too)

**How to apply:** Start fresh in the same repo. Reference docs/FEATURES.md and screenshots for feature parity. Port incrementally — layout first, then panels, then mouse, then viewers.
