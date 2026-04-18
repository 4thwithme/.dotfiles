---
name: documentation-skill
description: Comprehensive technical documentation creation and maintenance in the docs/ directory. Use when asked to describe features, explain business logic, document tools, or create technical specifications. Automatically creates markdown documentation with code examples, ASCII sequence diagrams (using diagram-skill), architecture diagrams, and comprehensive explanations. Triggers on requests like "document this feature", "explain how X works", "create docs for", or when new features/logic need documentation.
---

# Documentation Skill

Create and maintain comprehensive technical documentation in `/docs/` with code examples and ASCII art diagrams.

## When to Use

Trigger when:
- User asks to document features or logic
- New features need documentation
- Existing docs need updates
- Explaining system architecture
- Describing API endpoints
- Documenting database schemas
- Tool/utility documentation needed
- Business logic needs explanation

## Documentation Location

All documentation lives in:
```
docs/
├── features/           # Feature documentation
├── architecture/       # System architecture
├── api/               # API documentation
├── database/          # Database schemas
├── tools/             # CLI tools & utilities
└── guides/            # How-to guides
```

## Documentation Structure

### Standard Template

Every documentation file should include:

1. **Title & Overview**
2. **Use Cases**
3. **Architecture** (with diagrams)
4. **Data Flow** (with ASCII sequence diagrams for features/business logic)
5. **Code Examples**
6. **API Reference** (if applicable)
7. **Configuration** (if applicable)
8. **Testing**
9. **Troubleshooting**

## Workflow

### 1. Understand What to Document

Analyze:
- Feature/module code
- Related services
- Database models
- API endpoints
- Configuration

### 2. Determine Documentation Type

**Feature Documentation:**
- Location: `docs/features/{feature-name}.md`
- **MUST include ASCII sequence diagram** showing flow
- Includes use cases, architecture, examples

**Architecture Documentation:**
- Location: `docs/architecture/{component}.md`
- System design, patterns, decisions
- Class diagrams, ER diagrams

**API Documentation:**
- Location: `docs/api/{endpoint}.md`
- Endpoint details, request/response examples
- Sequence diagrams for complex flows

**Database Documentation:**
- Location: `docs/database/{table}.md`
- Schema, relationships, indexes
- ER diagrams

### 3. Use diagram-skill for Diagrams

For **every feature or business logic** documentation:

**REQUIRED: ASCII Sequence Diagram**
- Shows complete request/response flow
- Includes all components (Controller, Service, Model, DB, Cache, 3rd party APIs)
- Shows error paths
- Uses diagram-skill to generate ASCII art

**Optional: Additional Diagrams**
- Class diagrams for complex relationships
- ER diagrams for database docs
- Flowcharts for decision trees

### 4. Write Documentation

Follow template pattern below.

### 5. Save to Appropriate Directory

Create file in correct location under `/docs/`.

## Template: Feature Documentation

```markdown
# Feature Name

## Overview

Brief description of what this feature does and why it exists.

## Use Cases

- **Use Case 1**: Description
- **Use Case 2**: Description
- **Use Case 3**: Description

## Architecture

### Components

- **Controller**: `FeatureController` - Handles HTTP requests
- **Service**: `FeatureService` - Business logic
- **Model**: `FeatureModel` - Database operations
- **DTO**: `FeatureCreateDto`, `FeatureDto` - Data validation

### Dependencies

- `CacheService` - Redis caching
- `AlgoliaService` - Search functionality
- `MmsService` - External API integration

## Data Flow

### Happy Path

[Use diagram-skill to create ASCII sequence diagram]

\`\`\`
┌─────────┐   ┌─────────────────┐   ┌─────────────────┐   ┌──────────────┐   ┌────────────┐   ┌─────────────────┐
│ Client  │   │FeatureController│   │ FeatureService  │   │ CacheService │   │ Knex(Read) │   │ ExternalAPI     │
└────┬────┘   └────────┬────────┘   └────────┬────────┘   └──────┬───────┘   └─────┬──────┘   └────────┬────────┘
     │                 │                      │                   │                 │                   │
     │ POST /api/      │                      │                   │                 │                   │
     │ feature         │                      │                   │                 │                   │
     │────────────────>│                      │                   │                 │                   │
     │                 │                      │                   │                 │                   │
     │                 │  processFeature(dto) │                   │                 │                   │
     │                 │─────────────────────>│                   │                 │                   │
     │                 │                      │                   │                 │                   │
     │                 │                      │  get(namespace,   │                 │                   │
     │                 │                      │      key)         │                 │                   │
     │                 │                      │──────────────────>│                 │                   │
     │                 │                      │                   │                 │                   │
     │                 │                      │  null (cache miss)│                 │                   │
     │                 │                      │<─ ─ ─ ─ ─ ─ ─ ─ ─ │                 │                   │
     │                 │                      │                   │                 │                   │
     │                 │                      │  SELECT * FROM table                │                   │
     │                 │                      │──────────────────────────────────────>                   │
     │                 │                      │                   │                 │                   │
     │                 │                      │          Data     │                 │                   │
     │                 │                      │<─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │                   │
     │                 │                      │                   │                 │                   │
     │                 │                      │  fetchAdditional(data)              │                   │
     │                 │                      │─────────────────────────────────────────────────────────>│
     │                 │                      │                   │                 │                   │
     │                 │                      │                   │                 │  AdditionalData   │
     │                 │                      │<─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │
     │                 │                      │                   │                 │                   │
     │                 │                      │  set(namespace, key, result)        │                   │
     │                 │                      │──────────────────>│                 │                   │
     │                 │                      │                   │                 │                   │
     │                 │                      │       OK          │                 │                   │
     │                 │                      │<─ ─ ─ ─ ─ ─ ─ ─ ─ │                 │                   │
     │                 │                      │                   │                 │                   │
     │                 │     FeatureDto       │                   │                 │                   │
     │                 │<─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─│                   │                 │                   │
     │                 │                      │                   │                 │                   │
     │   200 OK        │                      │                   │                 │                   │
     │<─ ─ ─ ─ ─ ─ ─ ─ │                      │                   │                 │                   │
     │                 │                      │                   │                 │                   │
\`\`\`

### Error Handling

[Use diagram-skill for flowchart]

\`\`\`
                    ┌────────────────────┐
                    │  Start: Request    │
                    └─────────┬──────────┘
                              │
                              ▼
                    ┌────────────────────┐
                    │  Valid DTO?        │
                    └─────┬──────────┬───┘
                          │          │
                     Yes  │          │  No
                          │          │
                          ▼          ▼
                ┌──────────────┐  ┌──────────────────┐
                │ Process Data │  │ Return 400 Error │
                └──────┬───────┘  └────────┬─────────┘
                       │                   │
                       │                   │
                ┌──────▼─────────┐         │
                │  Query Success?│         │
                └────┬────────┬──┘         │
                     │        │            │
                 Yes │        │ No         │
                     │        │            │
                     ▼        ▼            │
          ┌─────────────┐  ┌────────────┐ │
          │Return 200 OK│  │Log to      │ │
          └──────┬──────┘  │Rollbar     │ │
                 │         └─────┬──────┘ │
                 │               │        │
                 │               ▼        │
                 │         ┌────────────┐ │
                 │         │Return 500  │ │
                 │         └─────┬──────┘ │
                 │               │        │
                 └───────┬───────┴────────┘
                         │
                         ▼
                   ┌───────────┐
                   │    End    │
                   └───────────┘
\`\`\`

## Code Examples

### Basic Usage

\`\`\`typescript
// Example 1: Create new feature
const dto: CreateFeatureDto = {
  name: 'Example',
  value: 123,
};

const result = await featureService.create(dto);
console.log(result); // { id: 'uuid', name: 'Example', ... }
\`\`\`

### With Caching

\`\`\`typescript
// Example 2: Using cache
const cached = await featureService.getWithCache(id);
\`\`\`

### Error Handling

\`\`\`typescript
// Example 3: Handling errors
try {
  await featureService.create(dto);
} catch (error) {
  if (error instanceof ValidationError) {
    // Handle validation
  } else if (error instanceof NotFoundError) {
    // Handle not found
  }
}
\`\`\`

## API Reference

### POST /api/feature

Create new feature.

**Request:**

\`\`\`typescript
{
  "name": "string",
  "value": number,
  "options": {
    "flag": boolean
  }
}
\`\`\`

**Response:**

\`\`\`typescript
{
  "id": "uuid",
  "name": "string",
  "value": number,
  "created_at": "2025-01-18T10:00:00Z"
}
\`\`\`

**Status Codes:**
- `201` - Created successfully
- `400` - Validation error
- `500` - Server error

### GET /api/feature/:id

Retrieve feature by ID.

**Parameters:**
- `id` (path) - Feature UUID

**Response:**

\`\`\`typescript
{
  "id": "uuid",
  "name": "string",
  "value": number,
  "created_at": "2025-01-18T10:00:00Z",
  "updated_at": "2025-01-18T12:00:00Z"
}
\`\`\`

**Status Codes:**
- `200` - Success
- `404` - Not found

## Configuration

### Environment Variables

\`\`\`bash
# Required environment variables
FEATURE_CACHE_TTL=3600  # Cache duration in seconds
FEATURE_API_KEY=xxx     # External API key
\`\`\`

### Module Configuration

\`\`\`typescript
@Module({
  imports: [
    CacheModule,
    ExternalApiModule,
  ],
  controllers: [FeatureController],
  providers: [FeatureService],
  exports: [FeatureService],
})
export class FeatureModule {}
\`\`\`

## Database Schema

### Table: features

\`\`\`sql
CREATE TABLE features (
  _id UUID PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  value INTEGER NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  deleted_at TIMESTAMP NULL,
  INDEX idx_name_deleted (name, deleted_at),
  UNIQUE KEY uk_name (name) WHERE deleted_at IS NULL
);
\`\`\`

[Use diagram-skill for ER diagram]

\`\`\`
┌─────────────────────────────────────┐
│            features                 │
├─────────────────────────────────────┤
│ PK  _id (UUID)                      │
│ UK  name (VARCHAR)                  │
│     value (INTEGER)                 │
│     created_at (TIMESTAMP)          │
│     updated_at (TIMESTAMP)          │
│     deleted_at (TIMESTAMP)          │
└─────────────┬───────────────────────┘
              │ 1
              │
              │ has
              │
              │ *
              ▼
┌──────────────────────────┐
│  feature_relations       │
├──────────────────────────┤
│ PK _id                   │
│ FK feature_id            │
│    relation_type         │
│    created_at            │
└──────────────────────────┘

Legend:
  PK = Primary Key
  FK = Foreign Key
  UK = Unique Key
  1  = One
  *  = Many
\`\`\`

## Testing

### Unit Tests

Located: `src/unit-tests/feature.service.unit-spec.ts`

\`\`\`typescript
describe('FeatureService', () => {
  it('should create feature', async () => {
    const dto = { name: 'test', value: 123 };
    const result = await service.create(dto);
    expect(result.name).toBe('test');
  });
});
\`\`\`

### E2E Tests

Located: `test/feature.e2e-spec.ts`

\`\`\`typescript
describe('Feature (e2e)', () => {
  it('POST /api/feature', () => {
    return request(app.getHttpServer())
      .post('/api/feature')
      .send({ name: 'test', value: 123 })
      .expect(201);
  });
});
\`\`\`

## Performance Considerations

- **Caching**: All reads cached for 1 hour
- **Database**: Uses read replica for SELECT queries
- **Batch Operations**: Processes in batches of 100
- **Indexes**: Optimized for name lookups

## Troubleshooting

### Common Issues

**Issue: Cache miss on every request**
- **Cause**: Cache key not constructed correctly
- **Solution**: Verify namespace and key format

**Issue: Slow queries**
- **Cause**: Missing index on frequently queried column
- **Solution**: Add index in migration

**Issue: Validation errors**
- **Cause**: DTO validation rules not met
- **Solution**: Check class-validator decorators

## Related Documentation

- [Database Schema](../database/features.md)
- [Caching Strategy](../architecture/caching.md)
- [API Guidelines](../guides/api-guidelines.md)
```

## Template: API Documentation

```markdown
# API Endpoint Name

## Overview

Brief description of endpoint purpose.

## Endpoint

```
METHOD /api/path/:param
```

## Request

### Path Parameters

- `param` (type) - Description

### Query Parameters

- `filter` (string, optional) - Description
- `limit` (number, optional) - Default: 10

### Request Body

\`\`\`typescript
{
  "field1": "string",
  "field2": number,
  "nested": {
    "field3": boolean
  }
}
\`\`\`

### Headers

```
Authorization: Bearer <token>
Content-Type: application/json
```

## Response

### Success Response

**Status:** 200 OK

\`\`\`typescript
{
  "data": {
    "id": "uuid",
    "field1": "value"
  },
  "metadata": {
    "total": number,
    "page": number
  }
}
\`\`\`

### Error Responses

**400 Bad Request**

\`\`\`typescript
{
  "statusCode": 400,
  "message": "Validation failed",
  "errors": ["field1 must be a string"]
}
\`\`\`

**404 Not Found**

\`\`\`typescript
{
  "statusCode": 404,
  "message": "Resource not found"
}
\`\`\`

## Data Flow

[Use diagram-skill for ASCII sequence diagram]

\`\`\`
┌─────────┐   ┌────────────┐   ┌─────────┐   ┌──────────┐
│ Client  │   │ Controller │   │ Service │   │ Database │
└────┬────┘   └─────┬──────┘   └────┬────┘   └────┬─────┘
     │              │               │             │
     │ METHOD /path │               │             │
     │─────────────>│               │             │
     │              │               │             │
     │              │  method(dto)  │             │
     │              │──────────────>│             │
     │              │               │             │
     │              │               │  Query      │
     │              │               │────────────>│
     │              │               │             │
     │              │               │   Result    │
     │              │               │<────────────│
     │              │               │             │
     │              │     Data      │             │
     │              │<──────────────│             │
     │              │               │             │
     │   Response   │               │             │
     │<─────────────│               │             │
     │              │               │             │
\`\`\`

## Code Example

\`\`\`typescript
// Client-side request
const response = await fetch('/api/path/123', {
  method: 'GET',
  headers: {
    'Authorization': 'Bearer token',
  },
});

const data = await response.json();
\`\`\`

## Implementation

\`\`\`typescript
// Controller
@Get(':id')
@ApiOperation({ summary: 'Get by ID' })
async getById(@Param('id') id: string): Promise<ResponseDto> {
  return this.service.findById(id);
}

// Service
async findById(id: string): Promise<ResponseDto> {
  const result = await this.model.findById({ _id: id });
  if (!result) {
    throw new NotFoundException('Not found');
  }
  return result;
}
\`\`\`
```

## Template: Database Documentation

```markdown
# Table Name

## Overview

Description of table purpose and data it stores.

## Schema

\`\`\`sql
CREATE TABLE table_name (
  _id UUID PRIMARY KEY,
  entity_id BIGINT NOT NULL,
  name VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  deleted_at TIMESTAMP NULL,

  INDEX idx_entity_deleted (entity_id, deleted_at),
  UNIQUE KEY uk_entity (entity_id) WHERE deleted_at IS NULL
);
\`\`\`

## Entity-Relationship Diagram

[Use diagram-skill for ASCII ER diagram]

\`\`\`
┌─────────────────────────────────────┐
│            table_name               │
├─────────────────────────────────────┤
│ PK  _id (UUID)                      │
│ UK  entity_id (BIGINT)              │
│     name (VARCHAR)                  │
│     created_at (TIMESTAMP)          │
│     updated_at (TIMESTAMP)          │
│     deleted_at (TIMESTAMP)          │
└─────────────┬───────────────────────┘
              │ 1
              │
              │ has
              │
              │ *
              ▼
┌──────────────────────────┐
│  related_table           │
├──────────────────────────┤
│ PK _id                   │
│ FK table_name_id         │
│    value                 │
└──────────────────────────┘

Legend:
  PK = Primary Key
  FK = Foreign Key
  UK = Unique Key
  1  = One
  *  = Many
\`\`\`

## Fields

| Field | Type | Nullable | Description |
|-------|------|----------|-------------|
| `_id` | UUID | No | Primary key |
| `entity_id` | BIGINT | No | Business entity ID |
| `name` | VARCHAR(255) | No | Entity name |
| `created_at` | TIMESTAMP | No | Creation timestamp |
| `updated_at` | TIMESTAMP | No | Last update timestamp |
| `deleted_at` | TIMESTAMP | Yes | Soft delete timestamp |

## Indexes

- `PRIMARY KEY (_id)` - Primary key
- `INDEX idx_entity_deleted (entity_id, deleted_at)` - Entity lookups
- `UNIQUE KEY uk_entity (entity_id)` - Entity uniqueness (soft delete aware)

## Relationships

- **One-to-Many**: `table_name` → `related_table`
- **Many-to-One**: `table_name` → `categories`

## Model

Located: `src/modules/db/table-name/models/table-name.model.ts`

\`\`\`typescript
@Injectable()
export class TableNameModel {
  constructor(
    @InjectConnection(KNEX_READ_CONNECTION) private readonly knexRead: Knex,
    @InjectConnection(KNEX_WRITE_CONNECTION) private readonly knexWrite: Knex,
  ) {}

  async create({ data }: { data: ICreate }): Promise<IBase> {
    // Implementation
  }
}
\`\`\`

## Queries

### Find by Entity ID

\`\`\`typescript
const result = await knexRead('table_name')
  .where({ entity_id: id })
  .whereNull('deleted_at')
  .first();
\`\`\`

### Batch Insert

\`\`\`typescript
await knexWrite.transaction(async (trx) => {
  for (const batch of batches) {
    await trx('table_name').insert(batch);
  }
});
\`\`\`

## Migration

Located: `src/migrations/{timestamp}_create_table_name.ts`

\`\`\`typescript
export async function up(knex: Knex): Promise<void> {
  await knex.transaction(async (trx) => {
    await trx.schema.createTable(TABLE_NAME, (table) => {
      // Schema definition
    });
  });
}
\`\`\`
```

## Orchestration

This skill orchestrates:

1. **diagram-skill** - For all ASCII diagrams (sequence, class, ER, flowchart)
2. **Code inspection** - Read actual implementation
3. **File creation** - Write docs to `/docs/` directory
4. **Code examples** - Extract from actual codebase

## Success Checklist

Good documentation includes:
- ✅ Clear overview and use cases
- ✅ **ASCII sequence diagram for features/business logic** (REQUIRED)
- ✅ Architecture explanation
- ✅ Multiple code examples
- ✅ API reference with request/response
- ✅ Configuration details
- ✅ Testing section
- ✅ Troubleshooting guide
- ✅ Related documentation links
- ✅ Saved in appropriate `/docs/` subdirectory
- ✅ Follows markdown best practices
- ✅ All diagrams use ASCII art (via diagram-skill)
