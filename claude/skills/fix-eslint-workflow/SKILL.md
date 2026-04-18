---
name: fix-eslint-workflow
description: Full workflow for fixing ESLint issues in this NestJS/TypeScript repo. Use when a Jira ticket (RECO-XXX) describes ESLint rule violations to fix, especially: object destructuring with explicitly named params in function signatures, import path aliases, explicit return types, or any ESLint/TypeScript code quality fix that requires updating dependent files, imports, and tests. Triggers on: "fix eslint issues for RECO-XXX", "fix eslint rules in file X", "run eslint checks and fix", "enforce named params rule".
---

# Fix ESLint Workflow

End-to-end workflow: Jira ticket → branch → eslint audit → fix violations → fix dependents → fix tests → verify.

## Workflow

### 1. Check Jira ticket

Fetch the ticket to understand which files and ESLint rules are in scope:

```bash
grep ATLASSIAN_CLOUD_ID .env | cut -d'=' -f2
```

Use `getJiraIssue` with the cloud ID and ticket key. Identify:

- Which files need fixing
- Which ESLint rule is being enforced

### 2. Create branch from current branch

```bash
git checkout -b RECO-XXX-descriptive-name
```

Branch from current branch (NOT main). Branch name: `RECO-XXX-kebab-case-summary`.

### 3. Run ESLint on target files

```bash
npm run lint -- --max-warnings=0 path/to/file.ts
```

Capture the full error/warning list before making any changes.

### 4. Fix ESLint violations

Plan your fixes before coding:

1. Identify the ESLint violation(s) in the specified file(s)
2. Use Grep to find ALL callers and imports of affected functions
3. Apply the fix using named object params pattern (not shortcuts)
4. Update ALL test files — mock expectations AND assertions
5. Run `npm run test:coverage` and `npm run code-quality-check` — do not stop until both pass
6. Show a summary of all files changed

Apply fixes in this priority order:

#### a. Auto-fix first

```bash
npm run lint:fix
```

#### b. Fix remaining manually

See [references/eslint-patterns.md](references/eslint-patterns.md) for common patterns specific to this repo.

**Most common manual fixes:**

**Named object params (most common RECO fix)**

```typescript
// ❌ Positional params
function myFn(id: string, name: string): void {}

// ✅ Object with named params
function myFn({ id, name }: { id: string; name: string }): void {}
```

**Path aliases (no relative imports)**

```typescript
// ❌
import { Foo } from '../../modules/foo/foo.service';
// ✅
import { Foo } from '@modules/foo/foo.service';
```

**Explicit return types**

```typescript
// ❌
async function getData() {
	return data;
}
// ✅
async function getData(): Promise<Data> {
	return data;
}
```

### 5. Fix ALL callers of changed functions (CRITICAL)

**This step is mandatory.** After changing any function/method signature, you MUST find and update every call site across the entire project — not just the file you edited.

Find all callers:

```bash
grep -r "functionName" src/ test/ --include="*.ts" -l
```

Or use the Grep tool to search for the function name.

Update **every** call site to use the new object param syntax:

```typescript
// ❌ Old call
validate(configRecord);
service.myFn(id, name);

// ✅ New named call
validate({ envConfig: configRecord });
service.myFn({ id, name });
```

**WARNING: Do NOT use rest-spread `{ ...param }` as a shortcut.** It avoids updating callers but changes the semantic (creates a copy) and produces confusing code. Always use explicit named params: `{ envConfig }`, `{ styleId, colorId }`, etc.

Check these locations in order:

1. Same module's controller/service
2. Other modules importing this service
3. CLI commands in `src/modules/cli/`
4. Scripts in `src/scripts/`
5. Test files (`src/unit-tests/`, `test/`)
6. RFC/documentation files (revert accidental changes to unrelated `validate` from `class-validator`)

### 6. Fix tests

Unit tests: `src/unit-tests/*.unit-spec.ts`
E2E tests: `test/*.e2e-spec.ts`

Update mock calls AND assertions to match new signatures:

```typescript
// ❌
service.myFn(id, name);
expect(service.myFn).toHaveBeenCalledWith(id, name);

// ✅
service.myFn({ id, name });
expect(service.myFn).toHaveBeenCalledWith({ id: id, name: name });
```

Run full coverage to confirm — do not stop until all checks pass:

```bash
npm run test:coverage
```

### 7. Verify ESLint on all changed files

```bash
npm run lint
npm run type-check
```

All checks must pass before done.

## Common Mistakes

| Mistake                                       | Fix                                           |
| --------------------------------------------- | --------------------------------------------- |
| Forgetting to update call sites               | Grep for all usages after changing signatures |
| Missing test updates                          | Run `npm run test:unit` after fixing code     |
| Using relative imports                        | Use `@modules/`, `@utils/`, `@dto/` etc.      |
| Breaking return types                         | Add explicit `: Promise<T>` or `: void`       |
| Branching from main instead of current branch | `git checkout -b` from current branch         |

## Resources

- **[references/eslint-patterns.md](references/eslint-patterns.md)**: Repo-specific ESLint rule patterns and fix examples
