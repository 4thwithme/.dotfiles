---
name: ZH Copilot project vision
description: Core project vision - AI bot for C&C Generals Zero Hour that operates as copilot/autopilot via screen capture and input emulation
type: project
---

**ZH Copilot** — AI bot for C&C Generals Zero Hour.

Two deployment modes:
1. **Copilot** — suggests actions to human player
2. **Autopilot** — full control via screen capture + keyboard/mouse emulation

Training pipeline: replay imitation learning → self-play vs built-in AI → self-play vs self.
Training uses headless game engine directly (C++ with pybind11 to Python/PyTorch).
Deployment uses screen capture + input emulation (fully external, no game modification).

Target: beat good-to-top players (~70%+ win rate). All 3 factions. Phased: 1v1 → team → FFA. All official maps.

Hardware: Mac M4 (ML dev/training), Mac Intel 2019 (headless game engine).
Source: EA official open-source repo (GPL v3).

**Why:** User wants a competitive RTS AI that can assist or replace human play without modifying the game client.
**How to apply:** All architecture decisions should maintain clean separation between training (engine-direct) and deployment (screen capture) interfaces.
