---
name: nestjs-skill
description: Use this skill when working with NestJS applications, implementing design patterns, optimizing performance, handling complex TypeScript configurations, debugging async operations, or architecting scalable Node.js solutions. Examples:<example>Context:User is implementing a new service in their NestJS application. user:'I need to create a service that handles user authentication with JWT tokens and integrates with our MySQL database using the read/write pattern' assistant:'I'll use the nestjs-skill skill to design this authentication service following NestJS best practices and the established database patterns.' <commentary>Since this involves NestJS architecture, database patterns, and service design, use the nestjs-skill skill to provide comprehensive guidance.</commentary></example> <example>Context:User encounters performance issues in their NestJS application. user:'My API endpoints are responding slowly and I'm seeing memory leaks in production' assistant:'Let me engage the nestjs-skill skill to analyze the performance issues and provide optimization strategies.' <commentary>Performance optimization and debugging in NestJS requires specialized expertise, so use the nestjs-skill skill.</commentary></example> <example>Context:User is working on complex TypeScript patterns. user:'I'm trying to implement a generic repository pattern with advanced TypeScript types for my NestJS modules' assistant:'I'll use the nestjs-skill skill to help design this generic repository pattern with proper TypeScript typing.' <commentary>This involves advanced TypeScript patterns and NestJS architecture, perfect for the nestjs-skill skill.</commentary></example>
---

# NestJS Skill

Comprehensive guide for developing, debugging, and optimizing NestJS TypeScript applications following project-specific patterns.

## When to Use

Trigger this skill for ALL code changes in this NestJS repository:
- Creating components (modules, services, controllers, guards, pipes, decorators, interceptors)
- Updating existing logic
- Implementing new features
- Database operations
- Performance optimization
- Architecture decisions
- Debugging NestJS-specific issues

## Critical Project Patterns

**ALWAYS reference CLAUDE.md for complete patterns.** Key requirements:

### Code Style
- **NO COMMENTS** in code (except ESLint disable)
- **NO EXPLANATIONS** in code
- **INSPECT existing files** before creating new ones
- Match exact patterns from similar files

### Database Pattern (CRITICAL)

```typescript
constructor(
  @InjectConnection(KNEX_READ_CONNECTION) private readonly knexRead: Knex,
  @InjectConnection(KNEX_WRITE_CONNECTION) private readonly knexWrite: Knex,
) {}
```

- Use `knexRead` for SELECT queries
- Use `knexWrite` for INSERT/UPDATE/DELETE

### Import Aliases (Required)

```typescript
import { SomeService } from '@modules/some/some.service';
import { someUtil } from '@utils/some.util';
import { SomeDto } from '@dto/some/some.dto';
import { SOME_CONSTANT } from '@constants/some.constant';
```

**NEVER use relative imports** - ESLint will fail.

### LogExecution Decorator (CRITICAL)

**ALWAYS wrap important methods and 3rd party requests:**

```typescript
@LogExecution()
async fetchFromThirdParty(params: Params): Promise<Result> {
  // 3rd party API call
}

@LogExecution({
  paramFormatter: (params) => ({ id: params.id }),
  responseFormatter: () => '',
})
async complexOperation(params: ComplexParams): Promise<LargeData> {
  // operation
}
```

Use for:
- All 3rd party API requests
- Important business logic
- Database operations that may be slow
- Methods handling sensitive data

### Logging

```typescript
import { Logger } from '@nestjs/common';

export class MyService {
  private readonly logger = new Logger(MyService.name);

  someMethod(): void {
    this.logger.log('Message');
    this.logger.error('Error', trace);
  }
}
```

## Workflow for Code Changes

### 1. Inspect Existing Patterns

**BEFORE creating any file**, inspect similar existing files:

```bash
# For services
ls -la src/modules/*/services/*.service.ts

# For controllers
ls -la src/modules/rest/*/*.controller.ts

# For DTOs
ls -la src/dto/

# For models
ls -la src/modules/db/*/models/*.model.ts
```

Read 2-3 similar files to understand patterns.

### 2. Create Component Following Pattern

#### Creating a Service

```typescript
import { Injectable, Logger } from '@nestjs/common';
import { InjectConnection } from 'nest-knexjs';
import { Knex } from 'knex';

import { KNEX_READ_CONNECTION, KNEX_WRITE_CONNECTION } from '@constants/common.constant';
import { LogExecution } from '@decorators/log-execution.decorator';

@Injectable()
export class MyService {
  private readonly logger = new Logger(MyService.name);

  constructor(
    @InjectConnection(KNEX_READ_CONNECTION) private readonly knexRead: Knex,
    @InjectConnection(KNEX_WRITE_CONNECTION) private readonly knexWrite: Knex,
  ) {}

  @LogExecution()
  async getData(id: string): Promise<Data> {
    return this.knexRead('table')
      .where({ id })
      .first();
  }

  @LogExecution()
  async createData(data: CreateDto): Promise<void> {
    await this.knexWrite('table').insert(data);
  }
}
```

#### Creating a Controller

```typescript
import { Controller, Get, Post, Body, Param, HttpStatus } from '@nestjs/common';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';

import { MyService } from './my.service';
import { CreateDto, ResponseDto } from '@dto/my/my.dto';

@ApiTags('My Module')
@Controller('my-endpoint')
export class MyController {
  constructor(private readonly myService: MyService) {}

  @Get(':id')
  @ApiOperation({ summary: 'Get data by ID' })
  @ApiResponse({ status: HttpStatus.OK, description: 'Success' })
  async getData(@Param('id') id: string): Promise<ResponseDto> {
    return this.myService.getData(id);
  }

  @Post()
  @ApiOperation({ summary: 'Create new data' })
  @ApiResponse({ status: HttpStatus.CREATED, description: 'Created' })
  async createData(@Body() data: CreateDto): Promise<void> {
    return this.myService.createData(data);
  }
}
```

#### Creating a Module

```typescript
import { Module } from '@nestjs/common';

import { MyController } from './my.controller';
import { MyService } from './my.service';
import { OtherModule } from '@modules/other/other.module';

@Module({
  imports: [OtherModule],
  controllers: [MyController],
  providers: [MyService],
  exports: [MyService],
})
export class MyModule {}
```

#### Creating a Guard

```typescript
import { Injectable, CanActivate, ExecutionContext, UnauthorizedException } from '@nestjs/common';
import { Observable } from 'rxjs';

@Injectable()
export class MyGuard implements CanActivate {
  canActivate(
    context: ExecutionContext,
  ): boolean | Promise<boolean> | Observable<boolean> {
    const request = context.switchToHttp().getRequest();

    if (!request.headers['authorization']) {
      throw new UnauthorizedException('Missing authorization header');
    }

    return true;
  }
}
```

#### Creating a Decorator

```typescript
import { SetMetadata } from '@nestjs/common';

export const METADATA_KEY = 'metadata_key';

export const MyDecorator = (value: string): MethodDecorator =>
  SetMetadata(METADATA_KEY, value);
```

#### Creating a Pipe

```typescript
import { PipeTransform, Injectable, BadRequestException } from '@nestjs/common';

@Injectable()
export class MyPipe implements PipeTransform {
  transform(value: unknown): unknown {
    if (!this.isValid(value)) {
      throw new BadRequestException('Validation failed');
    }
    return value;
  }

  private isValid(value: unknown): boolean {
    return true;
  }
}
```

### 3. Create DTOs

Location: `/src/dto/{feature}/`

```typescript
import { IsString, IsNotEmpty, IsOptional, IsNumber } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateDto {
  @ApiProperty({ description: 'Name of the item' })
  @IsString()
  @IsNotEmpty()
  name: string;

  @ApiPropertyOptional({ description: 'Optional description' })
  @IsString()
  @IsOptional()
  description?: string;

  @ApiProperty({ description: 'Price in cents' })
  @IsNumber()
  price: number;
}

export class ResponseDto {
  @ApiProperty()
  id: string;

  @ApiProperty()
  name: string;

  @ApiProperty()
  createdAt: Date;
}
```

### 4. Orchestrate Other Skills

After writing code:

**Always use code-quality-skill:**
```
After creating/updating code, automatically run:
- npm run lint:fix
- npm run format
- npm run type-check
- Fix any remaining issues
```

**Always use test-skill:**
```
After creating new components, write tests:
- Unit tests in /src/unit-tests/
- E2E tests in /test/
- Ensure 95% coverage
```

**For debugging, use debug-agent:**
```
When encountering errors, test failures, or unexpected behavior
```

**For database work, use database-agent:**
```
When designing schemas, writing migrations, or optimizing queries
```

## Common Patterns

### Dependency Injection

```typescript
// Inject services
constructor(
  private readonly myService: MyService,
  private readonly otherService: OtherService,
) {}

// Inject with token
constructor(
  @Inject('CONFIG_OPTIONS') private readonly config: ConfigOptions,
) {}

// Inject Knex
constructor(
  @InjectConnection(KNEX_READ_CONNECTION) private readonly knexRead: Knex,
  @InjectConnection(KNEX_WRITE_CONNECTION) private readonly knexWrite: Knex,
) {}
```

### Async Operations

```typescript
@LogExecution()
async fetchData(): Promise<Data[]> {
  const [users, orders] = await Promise.all([
    this.knexRead('users').select('*'),
    this.knexRead('orders').select('*'),
  ]);

  return this.combineData(users, orders);
}
```

### Error Handling

```typescript
import { HttpException, HttpStatus } from '@nestjs/common';

@LogExecution()
async getData(id: string): Promise<Data> {
  const data = await this.knexRead('table').where({ id }).first();

  if (!data) {
    throw new HttpException('Data not found', HttpStatus.NOT_FOUND);
  }

  return data;
}
```

### Environment Variables

```typescript
import { EnvConfigService } from '@modules/env-config/env-config.service';
import { SOME_VAR } from '@constants/env-variables.constant';

constructor(private readonly configService: EnvConfigService) {}

someMethod(): void {
  const value = this.configService.get<string>({ key: SOME_VAR });
  const numValue = this.configService.get<number>({
    key: SOME_VAR,
    converter: Number
  });
}
```

### Caching

```typescript
import { CacheService } from '@modules/cache/cache.service';
import { Namespaces } from '@interfaces/cache.interface';

constructor(private readonly cacheService: CacheService) {}

@LogExecution()
async getWithCache(key: string): Promise<Data> {
  const cached = await this.cacheService.get<Data>({
    namespace: Namespaces.MY_NAMESPACE,
    key,
  });

  if (cached) return cached;

  const data = await this.fetchData(key);

  await this.cacheService.set({
    namespace: Namespaces.MY_NAMESPACE,
    key,
    value: data,
    ttl: 3600,
  });

  return data;
}
```

## Performance Optimization

### Database Query Optimization

```typescript
// Use select to limit fields
const data = await this.knexRead('table')
  .select('id', 'name', 'email')
  .where({ active: true });

// Use pagination
const data = await this.knexRead('table')
  .limit(limit)
  .offset(offset);

// Use joins efficiently
const data = await this.knexRead('users as u')
  .join('orders as o', 'u.id', 'o.user_id')
  .select('u.*', 'o.total');
```

### Async Optimization

```typescript
// Parallel execution
const [data1, data2, data3] = await Promise.all([
  this.service1.getData(),
  this.service2.getData(),
  this.service3.getData(),
]);

// Sequential when dependencies exist
const user = await this.getUser(id);
const orders = await this.getOrders(user.id);
```

### Memory Management

```typescript
// Stream large datasets
async *streamData(): AsyncGenerator<Data> {
  const stream = this.knexRead('table').stream();

  for await (const row of stream) {
    yield this.transform(row);
  }
}
```

## TypeScript Best Practices

### Strict Types

```typescript
// Explicit return types
async getData(id: string): Promise<Data | null> {
  return this.knexRead('table').where({ id }).first();
}

// Generic types
async getMany<T>(ids: string[]): Promise<T[]> {
  return this.knexRead('table').whereIn('id', ids);
}

// Union types
type Status = 'active' | 'inactive' | 'pending';

async getByStatus(status: Status): Promise<Data[]> {
  return this.knexRead('table').where({ status });
}
```

### Interface vs Type

```typescript
// Use interface for objects
interface User {
  id: string;
  name: string;
  email: string;
}

// Use type for unions/intersections
type UserStatus = 'active' | 'inactive';
type UserWithStatus = User & { status: UserStatus };
```

## Debugging Tips

### Common Issues

**Circular Dependency:**
```typescript
// Use forwardRef
@Module({
  imports: [forwardRef(() => OtherModule)],
})
```

**Injection Token Not Found:**
```typescript
// Ensure provider is in module
@Module({
  providers: [MyService],
  exports: [MyService],
})
```

**Database Connection Issues:**
```typescript
// Check KNEX_READ_CONNECTION and KNEX_WRITE_CONNECTION
// Verify connection in module imports
```

## File Organization

```
src/modules/{feature}/
├── {feature}.module.ts
├── {feature}.controller.ts
├── {feature}.service.ts
├── dto/                    # Feature-specific DTOs (if not in /src/dto/)
├── guards/                 # Feature-specific guards
└── decorators/             # Feature-specific decorators

src/dto/{feature}/
├── create-{feature}.dto.ts
├── update-{feature}.dto.ts
└── response-{feature}.dto.ts

src/unit-tests/
└── {feature}.service.unit-spec.ts

test/
└── {feature}.e2e-spec.ts
```

## Success Checklist

Before considering code complete:

- ✅ Inspected existing similar files for patterns
- ✅ NO COMMENTS or EXPLANATIONS in code
- ✅ Used path aliases (no relative imports)
- ✅ Database read/write pattern followed
- ✅ @LogExecution on important methods
- ✅ Logger from @nestjs/common used
- ✅ Explicit return types on all methods
- ✅ DTOs with validation decorators
- ✅ Swagger decorators on controllers
- ✅ Ran code-quality-skill (lint, format, type-check pass)
- ✅ Ran test-skill (tests written, 95% coverage)
- ✅ All imports use aliases
- ✅ Environment variables use EnvConfigService
