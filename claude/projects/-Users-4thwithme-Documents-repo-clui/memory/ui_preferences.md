---
name: UI Preferences
description: User's UI/UX preferences learned during clui development — styling, behavior, communication
type: feedback
---

- All borders must use `borderStyle="round"` (rounded corners). No exceptions except WorktreePrompt.
- Text inside bordered boxes must NOT sit on the border line — use height/padding to ensure content is inside.
- Buttons should be 33% or 50% width, height=3, text centered inside bordered boxes.
- Session tiles: bordered cards with name + date, left-aligned text.
- No duplicate keystroke capture — only one component should handle text input at a time.
- Sidebar default width: 20% of terminal, max 40%.
- No status bar under input — status info goes in the InfoBar at top of center column.
- Context bar always visible above input (even when empty).
- Input grows dynamically: min 3 lines, max 50% terminal height.
- Selected text: white background, black text (inverted).

**Why:** User is very particular about visual consistency and text positioning. Gets frustrated when text overlaps borders.

**How to apply:** Always verify height props ensure content sits inside borders. Match existing button/tile patterns exactly when adding new UI elements.

## Implementation Model Preference

Use `sonnet` model for implementation agents (not opus or haiku).

**Why:** User explicitly requested this for the Rust rewrite task.
