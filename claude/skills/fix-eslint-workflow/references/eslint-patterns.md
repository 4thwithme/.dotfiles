# ESLint Patterns - recommendations-service

## Project Config

- ESLint v9+ flat config (`eslint.config.mjs`)
- TypeScript strict mode + `noUncheckedIndexedAccess`, `exactOptionalPropertyTypes`
- Prettier integrated

IMPORTANT: read eslint config file before working with code to understand what is required

## Rule: Named Object Params

**Rule trigger:** Functions receiving multiple params should use a single named object param.

```typescript
// ❌ Fails
export function buildQuery(
	styleId: string,
	limit: number,
	offset: number,
): Knex.QueryBuilder {}

// ✅ Passes
export function buildQuery({
	styleId,
	limit,
	offset,
}: {
	styleId: string;
	limit: number;
	offset: number;
}): Knex.QueryBuilder {}
```

**In class methods:**

```typescript
// ❌
async findByStyleId(styleId: string, colorId: number): Promise<StyleColor | undefined> {}

// ✅
async findByStyleId({
  styleId,
  colorId,
}: {
  styleId: string;
  colorId: number;
}): Promise<StyleColor | undefined> {}
```

**Single param — no change needed:**

```typescript
// ✅ Single param stays as-is
async findById(id: string): Promise<Style | undefined> {}
```

## Rule: No Relative Imports

Path aliases defined in `tsconfig.json`:

| Alias             | Maps to              |
| ----------------- | -------------------- |
| `@config/*`       | `src/configs/*`      |
| `@constants/*`    | `src/constants/*`    |
| `@modules/*`      | `src/modules/*`      |
| `@utils/*`        | `src/utils/*`        |
| `@middlewares/*`  | `src/middlewares/*`  |
| `@interfaces/*`   | `src/interfaces/*`   |
| `@decorators/*`   | `src/decorators/*`   |
| `@dto/*`          | `src/dto/*`          |
| `@guards/*`       | `src/guards/*`       |
| `@interceptors/*` | `src/interceptors/*` |

```typescript
// ❌
import { StylesService } from '../../db/styles/styles.service';
// ✅
import { StylesService } from '@modules/db/styles/styles.service';
```

**Exception:** Test files (`*.spec.ts`) allow relative imports.

## Rule: Explicit Return Types

```typescript
// ❌
async getRecommendations(styleId: string) {
  return this.service.find(styleId);
}

// ✅
async getRecommendations(styleId: string): Promise<Recommendation[]> {
  return this.service.find(styleId);
}
```

## Rule: No console

```typescript
// ❌
console.log('fetching', styleId);

// ✅
private readonly logger = new Logger(ClassName.name);
this.logger.log(`fetching ${styleId}`);
```

## Rule: Import Order

Groups with blank lines between:

1. Node built-ins (`path`, `fs`)
2. External packages (`@nestjs/common`, `knex`)
3. Internal aliases (`@modules/`, `@utils/`)
4. Type imports (`import type { ... }`)

```typescript
import { Injectable } from '@nestjs/common';
import { Knex } from 'knex';

import { StylesService } from '@modules/db/styles/styles.service';
import { getEnv } from '@utils/get-env-variable.util';

import type { Style } from '@interfaces/style.interface';
```

## Fixing Call Sites After Signature Change

When you change a function from positional to named object params, find all call sites:

```bash
# Find usages
grep -rn "methodName(" src/ test/
```

Update pattern:

```typescript
// ❌ Old
const result = await service.findByStyleId(styleId, colorId);
// ✅ New
const result = await service.findByStyleId({ styleId, colorId });
```

## Test File Updates

When service method signatures change, update test mocks:

```typescript
// ❌
mockService.findByStyleId.mockResolvedValue(data);
const result = await controller.get(styleId, colorId);

// ✅
mockService.findByStyleId.mockResolvedValue(data);
const result = await controller.get({ styleId, colorId });
```

Jest mock setup also needs updating if the implementation changed:

```typescript
// In describe block
const mockFindByStyleId = jest.fn();
mockStylesService = { findByStyleId: mockFindByStyleId };

// In test
mockFindByStyleId.mockResolvedValueOnce([mockStyle]);
await service.findByStyleId({ styleId: 'abc' });
expect(mockFindByStyleId).toHaveBeenCalledWith({ styleId: 'abc' });
```
