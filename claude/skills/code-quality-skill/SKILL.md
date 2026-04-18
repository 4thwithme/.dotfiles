---
name: code-quality-skill
description: Run comprehensive code quality checks and automatically fix linting, formatting, and TypeScript errors. Use after writing or modifying code to ensure it meets project standards. Use PROACTIVELY after code changes for linting, type checks, and formatting validation.
---

# Code Quality Skill

Run comprehensive code quality checks and automatically fix issues in TypeScript/NestJS projects.

## Workflow

Execute quality checks and fixes in this exact order:

### 1. Auto-fix linting

```bash
npm run lint:fix
```

Automatically fixes ESLint violations where possible.

### 2. Format code

```bash
npm run format
```

Applies Prettier formatting to all files.

### 3. Check types

```bash
npm run type-check
```

Identifies TypeScript compilation errors.

### 4. Verify all checks pass

```bash
npm run code-quality-check
```

Runs full validation: lint + format + type-check. Must all pass.

### 5. Fix remaining issues with AI

If errors remain after steps 1-4:
1. Analyze error output from step 4
2. Manually fix issues that auto-fixers couldn't resolve
3. Re-run step 4 to verify
4. Repeat until all checks pass

## Common Issues

### ESLint Errors

**No console logs**
- Replace `console.log()` with `Logger` from `@nestjs/common`

**No relative imports**
- Use path aliases: `@modules/`, `@utils/`, `@dto/`, etc.

**Explicit return types required**
- Add return types to all functions: `(): Promise<void>`

**Import order**
- Groups: builtin → external → internal → type
- Newline required after imports

### TypeScript Errors

**Type safety**
- Enable strict mode checks
- Use `@ts-expect-error` with explanation only when unavoidable

**Missing properties**
- Ensure all required interface properties are implemented

## After Running Checks

If issues remain after auto-fixes:
1. Review error output carefully
2. Fix remaining issues manually
3. Re-run verification
4. Ensure all checks pass before committing
