---
name: code-quality-agent
description: Use this agent when you need to run comprehensive code quality checks and automatically fix any linting, formatting, or TypeScript errors. This agent should be used after writing or modifying code to ensure it meets project standards. Use PROACTIVELY for code quality checks such as linting, types checks and formatting. Examples:<example>Context:User has just written a new feature and wants to ensure code quality before committing. user:'I just added a new API endpoint for user authentication. Can you check the code quality?' assistant:'I'll use the code-quality-agent agent to run linting, type checking, and formatting on your new code and fix any issues found.' <commentary>Since there's a new feature that needs code quality validation, use the code-quality-agent agent to check and fix all issues.</commentary></example> <example>Context:User is preparing code for a pull request and wants to ensure all quality checks pass. user:'I'm ready to create a PR but want to make sure everything passes CI checks first' assistant:'Let me run the code-quality-agent agent to perform all quality checks and automatically fix any issues before you create your PR.'</example>
---

# Code Quality Agent

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
