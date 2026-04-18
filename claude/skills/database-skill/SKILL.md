---
name: database-skill
description: Comprehensive MySQL database management with Knex.js including schema design, migrations, models, DTOs, validation, query optimization, and read/write replica management. Use when working with database schemas, creating tables, writing migrations, building models, optimizing queries, or any database-related work. CRITICAL SAFETY RULE - NEVER execute DROP, DELETE, or TRUNCATE operations directly via database connection - only create migrations that contain these operations.
---

# Database Skill

Complete MySQL database management with Knex.js for NestJS applications following project patterns.

## When to Use

Trigger for ALL database-related work:
- Creating/modifying tables
- Writing migrations
- Building models with CRUD operations
- Creating DTOs with validation
- Optimizing queries
- Database schema design
- Connection management
- Read/write replica pattern

## Critical Safety Rules

**NEVER execute these directly via connection:**
- ❌ DROP TABLE
- ❌ DELETE FROM
- ❌ TRUNCATE
- ❌ DROP DATABASE
- ❌ Any destructive operation

**ONLY via migrations:**
- ✅ Create migrations containing DROP/DELETE/TRUNCATE
- ✅ Execute migrations with `npm run migrate`

**Always allowed:**
- ✅ SELECT queries (read data)
- ✅ Read schemas and structures
- ✅ INSERT/UPDATE via models in transactions

## Database Structure

### Table Naming Convention

Table names stored in constants:

```typescript
// src/constants/db.constant.ts
export const TABLE_NAME_STYLES = 'styles';
export const TABLE_NAME_STYLES_HASH = 'styles_hash';
```

### Standard Schema Pattern

All tables include:
- `_id` UUID primary key
- `created_at` timestamp (default now)
- `updated_at` timestamp (default now)
- `deleted_at` timestamp nullable (soft delete)
- Appropriate indexes
- Unique constraints with soft delete predicate

## Migration Workflow

### 1. Create Migration

```bash
npm run migrate:make table_name_or_description
```

Creates file: `src/migrations/{timestamp}_{description}.ts`

### 2. Migration Pattern

```typescript
import { randomUUID } from 'node:crypto';
import { Logger } from '@nestjs/common';
import { TABLE_NAME_YOUR_TABLE } from '@constants/db.constant';
import type { Knex } from 'knex';

const logger = new Logger('migration_file_name.ts');

export async function up(knex: Knex): Promise<void> {
  await knex.transaction(async (trx) => {
    await trx.schema.createTable(TABLE_NAME_YOUR_TABLE, (table) => {
      // Primary key
      table.uuid('_id').primary();

      // Business fields
      table.bigint('entity_id').notNullable();
      table.string('name', 255).notNullable();
      table.text('description').nullable();
      table.integer('count').notNullable().defaultTo(0);

      // Timestamps
      table.timestamp('created_at').defaultTo(trx.fn.now());
      table.timestamp('updated_at').defaultTo(trx.fn.now());
      table.timestamp('deleted_at').nullable();

      // Indexes
      table.index(['entity_id', 'deleted_at']);
      table.index(['name', 'deleted_at']);

      // Unique constraints with soft delete predicate
      table.unique(['entity_id'], {
        predicate: trx.whereNull('deleted_at')
      });
    });

    logger.log('Table created successfully');
  });
}

export async function down(knex: Knex): Promise<void> {
  await knex.transaction(async (trx) => {
    await trx.schema.dropTableIfExists(TABLE_NAME_YOUR_TABLE);
  });
}
```

### 3. Run Migrations

```bash
# Run all pending
npm run migrate

# Run one up
npm run migrate:up

# Run one down
npm run migrate:down

# Rollback last batch
npm run migrate:rollback

# Production
npm run migrate:prod
```

### 4. Migration with Data Seeding

```typescript
export async function up(knex: Knex): Promise<void> {
  await knex.transaction(async (trx) => {
    // Create table
    await trx.schema.createTable(TABLE_NAME, (table) => {
      // schema
    });

    // Seed data in batches
    const data = [...]; // Your data
    const batchSize = 100;
    const batches = [];

    for (let i = 0; i < data.length; i += batchSize) {
      batches.push(data.slice(i, i + batchSize));
    }

    for (const batch of batches) {
      const insertData = batch.map((item) => ({
        _id: randomUUID(),
        // map fields
      }));

      await trx(TABLE_NAME).insert(insertData);
    }

    logger.log(`Inserted ${data.length} records`);
  });
}
```

## Model Pattern

### File Structure

```
src/modules/db/{entity}/
├── models/
│   └── {entity}.model.ts
├── dto/
│   ├── {entity}.base.dto.ts
│   ├── {entity}.create.dto.ts
│   └── {entity}.update.dto.ts
├── types/
│   ├── {entity}.base.interface.ts
│   ├── {entity}.create.interface.ts
│   └── {entity}.update.interface.ts
└── {entity}.module.ts
```

### Model Implementation

```typescript
import { randomUUID } from 'node:crypto';
import { Injectable, Logger } from '@nestjs/common';
import { InjectConnection } from 'nest-knexjs';
import { Knex } from 'knex';
import { instanceToPlain, plainToInstance } from 'class-transformer';
import { validate, ValidationError } from 'class-validator';

import { BaseEntityDto } from './dto/entity.base.dto';
import { CreateEntityDto } from './dto/entity.create.dto';
import { UpdateEntityDto } from './dto/entity.update.dto';
import { IEntityBase } from './types/entity.base.interface';
import { IEntityCreate } from './types/entity.create.interface';
import { IEntityUpdate } from './types/entity.update.interface';

import {
  KNEX_READ_CONNECTION,
  KNEX_WRITE_CONNECTION,
  TABLE_NAME_ENTITY,
} from '@constants/db.constant';

@Injectable()
export class EntityModel {
  private readonly logger = new Logger(EntityModel.name);
  private readonly tableName = TABLE_NAME_ENTITY;

  constructor(
    @InjectConnection(KNEX_READ_CONNECTION) private readonly knexRead: Knex,
    @InjectConnection(KNEX_WRITE_CONNECTION) private readonly knexWrite: Knex,
  ) {}

  async create({ data }: { data: IEntityCreate }): Promise<IEntityBase> {
    const _id = randomUUID();

    const entityData: IEntityCreate & { _id: string } = {
      ...data,
      _id,
    };

    const dto = plainToInstance(CreateEntityDto, entityData);
    const errors = await validate(dto);

    if (errors.length > 0) {
      this.logger.error(
        `Validation failed: ${this.formatValidationErrors({ errors })}`
      );
      throw new Error(`Validation failed: ${this.formatValidationErrors({ errors })}`);
    }

    try {
      const res = await this.knexWrite.transaction(async (trx) => {
        await trx(this.tableName).insert(entityData);

        return await trx<BaseEntityDto>(this.tableName)
          .where('_id', _id)
          .whereNull('deleted_at')
          .first();
      });

      if (!res) {
        throw new Error(`Failed to insert entity with ID ${_id}`);
      }

      this.logger.debug(`Inserted entity with ID ${_id}`);
      return instanceToPlain<BaseEntityDto>(res) as IEntityBase;
    } catch (error) {
      this.logger.error(`Failed to create entity: ${(error as Error).message}`);
      throw error;
    }
  }

  async findById({ _id }: { _id: string }): Promise<IEntityBase | null> {
    try {
      const result = await this.knexRead<BaseEntityDto>(this.tableName)
        .where({ _id })
        .whereNull('deleted_at')
        .first();

      if (!result) {
        this.logger.warn(`No entity found for ID ${_id}`);
        return null;
      }

      this.logger.debug(`Found entity for ID ${_id}`);
      return instanceToPlain<BaseEntityDto>(result) as IEntityBase;
    } catch (error) {
      this.logger.error(`Failed to find entity: ${(error as Error).message}`);
      throw error;
    }
  }

  async findMany({
    limit = 10,
    offset = 0,
  }: {
    limit?: number;
    offset?: number;
  }): Promise<IEntityBase[]> {
    try {
      const results = await this.knexRead<BaseEntityDto>(this.tableName)
        .whereNull('deleted_at')
        .limit(limit)
        .offset(offset)
        .orderBy('created_at', 'desc');

      this.logger.debug(`Found ${results.length} entities`);
      return results.map((r) => instanceToPlain<BaseEntityDto>(r) as IEntityBase);
    } catch (error) {
      this.logger.error(`Failed to find entities: ${(error as Error).message}`);
      throw error;
    }
  }

  async update({
    _id,
    data,
  }: {
    _id: string;
    data: Partial<IEntityUpdate>;
  }): Promise<IEntityBase | null> {
    const dto = plainToInstance(UpdateEntityDto, data);
    const errors = await validate(dto, { skipMissingProperties: true });

    if (errors.length > 0) {
      this.logger.error(
        `Validation failed: ${this.formatValidationErrors({ errors })}`
      );
      throw new Error(`Validation failed: ${this.formatValidationErrors({ errors })}`);
    }

    try {
      const res = await this.knexWrite.transaction(async (trx) => {
        await trx(this.tableName)
          .where({ _id })
          .whereNull('deleted_at')
          .update({ ...data, updated_at: trx.fn.now() });

        return await trx<IEntityBase>(this.tableName)
          .where({ _id })
          .whereNull('deleted_at')
          .first();
      });

      if (!res) {
        this.logger.warn(`No entity found for ID ${_id}`);
        return null;
      }

      this.logger.debug(`Updated entity for ID ${_id}`);
      return instanceToPlain<BaseEntityDto>(res) as IEntityBase;
    } catch (error) {
      this.logger.error(`Failed to update entity: ${(error as Error).message}`);
      throw error;
    }
  }

  async softDelete({ _id }: { _id: string }): Promise<void> {
    try {
      await this.knexWrite(this.tableName)
        .where({ _id })
        .whereNull('deleted_at')
        .update({
          deleted_at: this.knexWrite.fn.now(),
          updated_at: this.knexWrite.fn.now(),
        });

      this.logger.debug(`Soft deleted entity for ID ${_id}`);
    } catch (error) {
      this.logger.error(`Failed to soft delete entity: ${(error as Error).message}`);
      throw error;
    }
  }

  private formatValidationErrors({ errors }: { errors: ValidationError[] }): string {
    return errors
      .map((error) =>
        `${error.property}: ${Object.values(error.constraints ?? {}).join(', ')}`
      )
      .join('; ');
  }
}
```

## DTO Pattern

### Base DTO

```typescript
import { Transform } from 'class-transformer';
import {
  IsUUID,
  IsString,
  IsNotEmpty,
  IsOptional,
  IsDateString,
  IsNumber,
  MaxLength,
  MinLength,
} from 'class-validator';

import { IEntityBase } from '../types/entity.base.interface';

export class BaseEntityDto {
  @IsUUID(4)
  _id: IEntityBase['_id'];

  @IsNumber()
  @IsNotEmpty()
  entity_id: IEntityBase['entity_id'];

  @IsString()
  @IsNotEmpty()
  @MaxLength(255)
  name: IEntityBase['name'];

  @IsString()
  @IsOptional()
  @MaxLength(1000)
  description: IEntityBase['description'];

  @IsOptional()
  @Transform(({ value }: { value: string | number | null }) =>
    value ? new Date(value) : null
  )
  @IsDateString()
  created_at: IEntityBase['created_at'];

  @IsOptional()
  @Transform(({ value }: { value: string | number | null }) =>
    value ? new Date(value) : null
  )
  @IsDateString()
  updated_at: IEntityBase['updated_at'];

  @IsOptional()
  @Transform(({ value }: { value: string | number | null }) =>
    value ? new Date(value) : null
  )
  @IsDateString()
  deleted_at: IEntityBase['deleted_at'];
}
```

### Create DTO

```typescript
import { OmitType } from '@nestjs/swagger';
import { BaseEntityDto } from './entity.base.dto';

export class CreateEntityDto extends OmitType(BaseEntityDto, [
  '_id',
  'created_at',
  'updated_at',
  'deleted_at',
] as const) {}
```

### Update DTO

```typescript
import { PartialType, OmitType } from '@nestjs/swagger';
import { BaseEntityDto } from './entity.base.dto';

export class UpdateEntityDto extends PartialType(
  OmitType(BaseEntityDto, [
    '_id',
    'created_at',
    'updated_at',
    'deleted_at',
  ] as const)
) {}
```

## Interface Pattern

### Base Interface

```typescript
export interface IEntityBase {
  _id: string;
  entity_id: number;
  name: string;
  description: string | null;
  created_at: Date;
  updated_at: Date;
  deleted_at: Date | null;
}
```

### Create Interface

```typescript
import { IEntityBase } from './entity.base.interface';

export type IEntityCreate = Omit<
  IEntityBase,
  '_id' | 'created_at' | 'updated_at' | 'deleted_at'
>;
```

### Update Interface

```typescript
import { IEntityBase } from './entity.base.interface';

export type IEntityUpdate = Partial<
  Omit<IEntityBase, '_id' | 'created_at' | 'updated_at' | 'deleted_at'>
>;
```

## Query Optimization

### Use Indexes

```typescript
// In migration
table.index(['field1', 'field2', 'deleted_at']);
table.index(['foreign_key', 'status', 'deleted_at']);
```

### Select Specific Fields

```typescript
// ❌ Bad - selects all fields
const data = await this.knexRead('table').where({ id });

// ✅ Good - only needed fields
const data = await this.knexRead('table')
  .select('id', 'name', 'email')
  .where({ id });
```

### Use Pagination

```typescript
async findPaginated({
  limit = 10,
  offset = 0,
}: {
  limit?: number;
  offset?: number;
}): Promise<IEntityBase[]> {
  return this.knexRead<BaseEntityDto>(this.tableName)
    .whereNull('deleted_at')
    .limit(limit)
    .offset(offset)
    .orderBy('created_at', 'desc');
}
```

### Efficient Joins

```typescript
const data = await this.knexRead('users as u')
  .join('orders as o', 'u.id', 'o.user_id')
  .select('u.id', 'u.name', 'o.total')
  .where('u.deleted_at', null)
  .where('o.deleted_at', null);
```

### Use Transactions for Multiple Writes

```typescript
async createWithRelations({ data }: { data: Data }): Promise<Result> {
  return this.knexWrite.transaction(async (trx) => {
    const entity = await trx('entities').insert(data).returning('*');

    await trx('relations').insert({
      entity_id: entity[0].id,
      related_data: data.related,
    });

    return entity[0];
  });
}
```

### Batch Operations

```typescript
async createBatch({ items }: { items: IEntityCreate[] }): Promise<void> {
  const batchSize = 100;

  for (let i = 0; i < items.length; i += batchSize) {
    const batch = items.slice(i, i + batchSize);

    await this.knexWrite.transaction(async (trx) => {
      const insertData = batch.map((item) => ({
        _id: randomUUID(),
        ...item,
      }));

      await trx(this.tableName).insert(insertData);
    });
  }

  this.logger.log(`Inserted ${items.length} records in batches`);
}
```

## Common Query Patterns

### Find with Conditions

```typescript
async findByConditions({
  status,
  categoryId,
}: {
  status: string;
  categoryId?: number;
}): Promise<IEntityBase[]> {
  const query = this.knexRead<BaseEntityDto>(this.tableName)
    .where({ status })
    .whereNull('deleted_at');

  if (categoryId) {
    query.where({ category_id: categoryId });
  }

  return query;
}
```

### Count Records

```typescript
async count(): Promise<number> {
  const result = await this.knexRead(this.tableName)
    .whereNull('deleted_at')
    .count('* as count')
    .first();

  return result ? Number(result.count) : 0;
}
```

### Check Existence

```typescript
async exists({ entityId }: { entityId: number }): Promise<boolean> {
  const result = await this.knexRead(this.tableName)
    .where({ entity_id: entityId })
    .whereNull('deleted_at')
    .first();

  return !!result;
}
```

### Aggregate Queries

```typescript
async getStatistics(): Promise<Statistics> {
  const result = await this.knexRead(this.tableName)
    .whereNull('deleted_at')
    .select(
      this.knexRead.raw('COUNT(*) as total'),
      this.knexRead.raw('AVG(count) as average'),
      this.knexRead.raw('MAX(count) as maximum')
    )
    .first();

  return {
    total: Number(result.total),
    average: Number(result.average),
    maximum: Number(result.maximum),
  };
}
```

## Read/Write Connection Pattern

**Critical:** Always use correct connection for operation type.

```typescript
// ✅ Read operations - use knexRead
async getData(): Promise<Data[]> {
  return this.knexRead('table')
    .whereNull('deleted_at')
    .select('*');
}

// ✅ Write operations - use knexWrite
async createData(data: CreateDto): Promise<Data> {
  return this.knexWrite.transaction(async (trx) => {
    const [result] = await trx('table').insert(data).returning('*');
    return result;
  });
}

// ✅ Update operations - use knexWrite
async updateData(id: string, data: UpdateDto): Promise<Data> {
  return this.knexWrite.transaction(async (trx) => {
    await trx('table').where({ _id: id }).update(data);
    return trx('table').where({ _id: id }).first();
  });
}
```

## Validation Decorators

Common class-validator decorators:

```typescript
// String validation
@IsString()
@IsNotEmpty()
@MinLength(3)
@MaxLength(255)
@Matches(/^[a-zA-Z0-9-]+$/)

// Number validation
@IsNumber()
@IsInt()
@Min(0)
@Max(100)
@IsPositive()

// Boolean validation
@IsBoolean()

// Date validation
@IsDate()
@IsDateString()

// UUID validation
@IsUUID(4)

// Optional fields
@IsOptional()

// Array validation
@IsArray()
@ArrayMinSize(1)
@ArrayMaxSize(10)

// Nested object validation
@ValidateNested()
@Type(() => NestedDto)

// Enum validation
@IsEnum(StatusEnum)

// Custom validation
@Validate(CustomValidator)
```

## Module Registration

```typescript
import { Module } from '@nestjs/common';
import { EntityModel } from './models/entity.model';

@Module({
  providers: [EntityModel],
  exports: [EntityModel],
})
export class EntityModule {}
```

## Success Checklist

Before considering database work complete:

- ✅ Migration created with `npm run migrate:make`
- ✅ Migration follows pattern (transaction, logger, up/down)
- ✅ Table has _id, created_at, updated_at, deleted_at
- ✅ Appropriate indexes added
- ✅ Unique constraints use soft delete predicate
- ✅ Table name constant in @constants/db.constant
- ✅ Model implements CRUD operations
- ✅ Model uses knexRead/knexWrite correctly
- ✅ DTOs created (Base, Create, Update)
- ✅ Interfaces created (Base, Create, Update)
- ✅ Validation decorators on all DTO fields
- ✅ DTO validation in model methods
- ✅ Transactions for all write operations
- ✅ Soft delete pattern (whereNull('deleted_at'))
- ✅ Logger used throughout
- ✅ Error handling in all methods
- ✅ Module exports model
- ✅ Migration tested with npm run migrate
- ✅ NO destructive operations executed directly
