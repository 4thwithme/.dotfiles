---
name: verify
description: Pre-PR verification — runs the full quality suite (lint, type-check, unit tests, e2e tests) and confirms all checks pass before declaring work complete. Use before creating a PR or claiming a task is done.
---

Run the full verification suite in order. Stop at the first failure and fix it before continuing.

## Steps

1. **Code quality** (fast — run first):
   ```bash
   npm run code-quality-check
   ```
   Fix any lint, format, or type-check errors before proceeding.

2. **Unit tests**:
   ```bash
   npm run test:unit
   ```
   All tests must pass. If coverage fails, fix the gaps.

3. **E2E tests**:
   ```bash
   npm run test:e2e
   ```
   E2E tests auto-reset the test DB. All must pass.

## Rules

- Do NOT claim work is complete or create a PR until all three steps pass.
- If any step fails, fix the issue, then re-run that step (not the full suite) to confirm the fix.
- Report results: "All checks pass: lint ✓, unit ✓, e2e ✓" or list what failed.
- Coverage threshold is 95% across branches/functions/lines/statements — failing coverage is a failing check.
