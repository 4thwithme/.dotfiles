---
name: test-skill
description: Create comprehensive test suites with unit, integration, and e2e tests. Use this skill when we need to create, fix, or extend unit tests (*unit-spec.ts) or e2e tests (*e2e-spec.ts) for your NestJS application. Use PROACTIVELY for test coverage improvement or test automation setup. Use  commands: "npm run test:unit", "npm run test:e2e", "npm run test:unit:coverage", "npm test:e2e:coverage, "npm run test", "npm run test:coverage"
---

# Test Skill

Write comprehensive unit and e2e tests for NestJS TypeScript applications following project standards.

## When to Use

Trigger this skill when:
- User asks to write tests ("write tests", "add tests", "cover with tests")
- User asks to fix failing tests ("fix tests", "tests are failing")
- User asks to improve coverage ("improve coverage", "increase test coverage")
- Coverage falls below 95% threshold (branches, functions, lines, statements)
- After writing new features that need test coverage

## Test Structure

### Unit Tests
- Location: `/src/unit-tests/`
- Naming: `*.unit-spec.ts`
- Command: `npm run test:unit`
- Coverage: `npm run test:unit:coverage`
- Excludes: `/modules/db/` patterns

### E2E Tests
- Location: `/test/`
- Naming: `*.e2e-spec.ts`
- Command: `npm run test:e2e`
- Coverage: `npm run test:e2e:coverage`
- Collects coverage from: `*.(controller|service).ts`

### Coverage Requirements

All metrics must meet **95% minimum**:
- Branches: 95%
- Functions: 95%
- Lines: 95%
- Statements: 95%

## Workflow

### 1. Analyze What Needs Testing

Identify untested code:
```bash
npm run test:unit:coverage
npm run test:e2e:coverage
```

Review coverage reports to find:
- Uncovered functions
- Untested branches
- Missing test files

### 2. Determine Test Type

**Unit Test** when:
- Testing services, utilities, decorators, guards
- No HTTP requests needed
- Isolated logic testing
- Mock all dependencies

**E2E Test** when:
- Testing controllers/API endpoints
- Integration with database required
- Full request/response cycle
- Real HTTP calls

### 3. Write Tests Following Patterns

#### Unit Test Pattern

```typescript
import { Test, TestingModule } from '@nestjs/testing';
import { Logger } from '@nestjs/common';

describe('ServiceName', () => {
  let service: ServiceName;
  let loggerLogSpy: jest.SpyInstance;

  const mockDependency = {
    method: jest.fn(),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        ServiceName,
        { provide: DependencyName, useValue: mockDependency },
      ],
    }).compile();

    service = module.get<ServiceName>(ServiceName);
    loggerLogSpy = jest.spyOn(Logger.prototype, 'log').mockImplementation();
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  describe('methodName', () => {
    it('should return expected result', async () => {
      mockDependency.method.mockResolvedValue('result');

      const result = await service.methodName();

      expect(result).toBe('result');
      expect(mockDependency.method).toHaveBeenCalledWith(expect.any(Object));
    });

    it('should handle errors', async () => {
      mockDependency.method.mockRejectedValue(new Error('error'));

      await expect(service.methodName()).rejects.toThrow('error');
    });
  });
});
```

#### E2E Test Pattern

```typescript
import { INestApplication } from '@nestjs/common';
import { Test, TestingModule } from '@nestjs/testing';
import * as request from 'supertest';

import { AppModule } from '../src/app.module';

describe('ControllerName (e2e)', () => {
  let app: INestApplication;

  beforeAll(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    await app.init();
  });

  afterAll(async () => {
    await app.close();
  });

  describe('GET /endpoint', () => {
    it('should return 200 with data', () => {
      return request(app.getHttpServer())
        .get('/endpoint')
        .expect(200)
        .expect((res) => {
          expect(res.body).toHaveProperty('data');
        });
    });

    it('should return 400 for invalid input', () => {
      return request(app.getHttpServer())
        .get('/endpoint?invalid=true')
        .expect(400);
    });
  });
});
```

### 4. Run Tests and Verify Coverage

```bash
# Run all tests with coverage
npm run test:coverage

# Or run separately
npm run test:unit:coverage
npm run test:e2e:coverage
```

Check output for:
- All tests passing
- Coverage ≥95% for all metrics
- No skipped tests

### 5. Fix Failures and Iterate

If tests fail:
1. Read error messages carefully
2. Check mock configurations
3. Verify imports and dependencies
4. Fix issues in test or source code
5. Re-run tests

If coverage < 95%:
1. Identify uncovered code in reports
2. Add missing test cases
3. Test edge cases and error paths
4. Re-run coverage check

## Common Patterns

### Mocking Dependencies

```typescript
// Mock with jest.fn()
const mockService = {
  getData: jest.fn().mockResolvedValue(data),
};

// Mock NestJS providers
providers: [
  ServiceName,
  { provide: INJECTION_TOKEN, useValue: mockService },
]

// Mock Logger
const loggerSpy = jest.spyOn(Logger.prototype, 'log').mockImplementation();
```

### Testing Async Methods

```typescript
// Promise resolution
it('should resolve with data', async () => {
  mockService.getData.mockResolvedValue(data);
  await expect(service.method()).resolves.toEqual(data);
});

// Promise rejection
it('should reject with error', async () => {
  mockService.getData.mockRejectedValue(new Error('failed'));
  await expect(service.method()).rejects.toThrow('failed');
});
```

### Testing HTTP Endpoints

```typescript
// GET request
return request(app.getHttpServer())
  .get('/api/endpoint')
  .query({ param: 'value' })
  .expect(200)
  .expect('Content-Type', /json/);

// POST request
return request(app.getHttpServer())
  .post('/api/endpoint')
  .send({ data: 'value' })
  .expect(201);
```

### Database Testing (E2E)

E2E tests use `.env.test` with test database that auto-resets before each run.

```typescript
beforeAll(async () => {
  // Database reset happens automatically
  const moduleFixture: TestingModule = await Test.createTestingModule({
    imports: [AppModule],
  }).compile();

  app = moduleFixture.createNestApplication();
  await app.init();
});
```

## Verification Commands

```bash
# Full test suite
npm run test                    # All tests (lint + format + type-check + unit + e2e)
npm run test:coverage           # All tests with coverage

# Unit tests only
npm run test:unit               # Run unit tests
npm run test:unit:coverage      # Unit tests with coverage

# E2E tests only
npm run test:e2e                # Run e2e tests
npm run test:e2e:coverage       # E2E tests with coverage
```

## Success Criteria

Tests are complete when:
- ✅ All tests pass
- ✅ Coverage ≥95% (branches, functions, lines, statements)
- ✅ No console errors or warnings
- ✅ Tests follow project patterns
- ✅ Proper mocking of dependencies
- ✅ Both happy path and error cases covered
