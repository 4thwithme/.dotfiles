---
name: diagram-skill
description: Create ASCII art sequence diagrams and UML diagrams using text-based drawing. Use when visualizing system architecture, data flows, class relationships, API interactions, database schemas, or any technical process. Outputs pure ASCII text diagrams that render in any text viewer. Supports sequence diagrams, class diagrams, entity-relationship diagrams, and flowcharts.
---

# Diagram Skill

Create technical diagrams using ASCII art for documentation and visualization.

## When to Use

Trigger when:
- Visualizing feature flows or business logic
- Documenting API interactions
- Showing database relationships
- Illustrating class hierarchies
- Mapping system architecture
- Explaining request/response cycles
- Documenting data flows

## Diagram Types

### Sequence Diagrams (ASCII Art)

Show interactions between components over time using boxes, lines, and arrows.

**Pattern:**

```
┌─────────┐           ┌────────────┐         ┌─────────┐         ┌──────────┐
│ Client  │           │ Controller │         │ Service │         │ Database │
└────┬────┘           └─────┬──────┘         └────┬────┘         └────┬─────┘
     │                      │                     │                   │
     │ POST /api/endpoint   │                     │                   │
     │─────────────────────>│                     │                   │
     │                      │                     │                   │
     │                      │  processData(dto)   │                   │
     │                      │────────────────────>│                   │
     │                      │                     │                   │
     │                      │                     │  INSERT INTO      │
     │                      │                     │──────────────────>│
     │                      │                     │                   │
     │                      │                     │      Result       │
     │                      │                     │<──────────────────│
     │                      │                     │                   │
     │                      │   ProcessedData     │                   │
     │                      │<────────────────────│                   │
     │                      │                     │                   │
     │    201 Created       │                     │                   │
     │<─────────────────────│                     │                   │
     │                      │                     │                   │
```

**Elements:**
- `┌─┐ └─┘` - Component boxes
- `─────>` - Request arrow (solid)
- `<─────` - Response arrow (dashed can use `- - ->`)
- `│` - Vertical lifeline
- Text labels for messages

**Example: NestJS API Flow**

```
┌─────────┐   ┌──────────────────────┐   ┌──────────────────────┐   ┌──────────────┐   ┌────────────┐   ┌─────────────────┐
│ Client  │   │ RelatedProductsCtrl  │   │ RelatedProductsSvc   │   │ CacheService │   │ Knex(Read) │   │ AlgoliaService  │
└────┬────┘   └──────────┬───────────┘   └──────────┬───────────┘   └──────┬───────┘   └─────┬──────┘   └────────┬────────┘
     │                   │                           │                      │                 │                   │
     │ GET /related-     │                           │                      │                 │                   │
     │ products/:styleId │                           │                      │                 │                   │
     │──────────────────>│                           │                      │                 │                   │
     │                   │                           │                      │                 │                   │
     │                   │ getRelatedProducts()      │                      │                 │                   │
     │                   │──────────────────────────>│                      │                 │                   │
     │                   │                           │                      │                 │                   │
     │                   │                           │  get(namespace, key) │                 │                   │
     │                   │                           │─────────────────────>│                 │                   │
     │                   │                           │                      │                 │                   │
     │                   │                           │    null (cache miss) │                 │                   │
     │                   │                           │<─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─│                 │                   │
     │                   │                           │                      │                 │                   │
     │                   │                           │  SELECT * FROM styles WHERE...         │                   │
     │                   │                           │────────────────────────────────────────>│                   │
     │                   │                           │                      │                 │                   │
     │                   │                           │           StyleData  │                 │                   │
     │                   │                           │<─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─│                   │
     │                   │                           │                      │                 │                   │
     │                   │                           │  searchSimilar(styleData)              │                   │
     │                   │                           │────────────────────────────────────────────────────────────>│
     │                   │                           │                      │                 │                   │
     │                   │                           │                      │                 │  RelatedProducts[]│
     │                   │                           │<─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─│
     │                   │                           │                      │                 │                   │
     │                   │                           │  set(namespace, key, data, ttl)        │                   │
     │                   │                           │─────────────────────>│                 │                   │
     │                   │                           │                      │                 │                   │
     │                   │                           │          OK          │                 │                   │
     │                   │                           │<─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─│                 │                   │
     │                   │                           │                      │                 │                   │
     │                   │   RelatedProductsDto      │                      │                 │                   │
     │                   │<─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │                      │                 │                   │
     │                   │                           │                      │                 │                   │
     │  200 OK + JSON    │                           │                      │                 │                   │
     │<─ ─ ─ ─ ─ ─ ─ ─ ─ │                           │                      │                 │                   │
     │                   │                           │                      │                 │                   │
```

### Class Diagrams (ASCII Art)

Show class structure and relationships.

**Pattern:**

```
┌──────────────────────────┐
│    BaseEntityDto         │
├──────────────────────────┤
│ + _id: string            │
│ + created_at: Date       │
│ + updated_at: Date       │
│ + deleted_at: Date|null  │
└──────────┬───────────────┘
           │
           │ extends
           ├─────────────────────┐
           │                     │
┌──────────▼───────────┐  ┌──────▼────────────────┐
│  CreateEntityDto     │  │  UpdateEntityDto      │
├──────────────────────┤  ├───────────────────────┤
│ + name: string       │  │ + name?: string       │
│ + entity_id: number  │  │ + entity_id?: number  │
│ + validate(): bool   │  └───────────────────────┘
└──────────────────────┘

┌─────────────────────────────────────┐
│         EntityModel                 │
├─────────────────────────────────────┤
│ - knexRead: Knex                    │
│ - knexWrite: Knex                   │
│ - logger: Logger                    │
├─────────────────────────────────────┤
│ + create(data): Promise<IEntity>    │
│ + findById(id): Promise<IEntity>    │
│ + update(id, data): Promise<IEntity>│
│ + softDelete(id): Promise<void>     │
└─────────────────────────────────────┘
           │
           │ uses
           ├──────────────┬──────────────┐
           │              │              │
           ▼              ▼              ▼
   CreateEntityDto  UpdateEntityDto  BaseEntityDto
```

**Elements:**
- `┌─┐ └─┘ ├ ┤ ┬ ┴ ┼` - Box drawing
- `│` - Vertical separator
- `─` - Horizontal separator
- `▼ ▲` - Arrows for relationships
- `+` public, `-` private, `#` protected

### Entity-Relationship Diagrams (ASCII Art)

Show database table relationships.

**Pattern:**

```
┌─────────────────────────────────────┐
│            styles                   │
├─────────────────────────────────────┤
│ PK  _id (UUID)                      │
│ UK  style_id (BIGINT)               │
│ FK  primary_category_id (BIGINT)    │
│ FK  root_category_id (BIGINT)       │
│     purchases_count (BIGINT)        │
│     created_at (TIMESTAMP)          │
│     updated_at (TIMESTAMP)          │
│     deleted_at (TIMESTAMP)          │
└─────────────┬───────────────────────┘
              │ 1
              │
              │ has
              │
              │ *
    ┌─────────┴──────────┬──────────────────┐
    │                    │                  │
    ▼                    ▼                  ▼
┌─────────────────┐  ┌──────────────────┐  ┌─────────────────────┐
│  style_colors   │  │  styles_hash     │  │ condensed_features  │
├─────────────────┤  ├──────────────────┤  ├─────────────────────┤
│ PK _id          │  │ PK _id           │  │ PK _id              │
│ FK style_id     │  │ FK style_id      │  │ FK style_id         │
│    color_id     │  │ UK hash          │  │    condensed_json   │
│    color_rgb    │  │    algorithm     │  │    created_at       │
│    color_name   │  │    created_at    │  └─────────────────────┘
│    created_at   │  └──────────────────┘
└─────────────────┘

Legend:
  PK = Primary Key
  FK = Foreign Key
  UK = Unique Key
  1  = One
  *  = Many
```

### Flowchart (ASCII Art)

Show decision flows and processes.

**Pattern:**

```
                    ┌────────────────────┐
                    │  Start: API Request│
                    └─────────┬──────────┘
                              │
                              ▼
                    ┌────────────────────┐
                    │  Valid Input?      │
                    └─────┬──────────┬───┘
                          │          │
                     Yes  │          │  No
                          │          │
                          ▼          ▼
                ┌──────────────┐  ┌──────────────────┐
                │ Check Cache  │  │ Return 400 Error │
                └──────┬───────┘  └────────┬─────────┘
                       │                   │
                       │                   │
                ┌──────▼─────────┐         │
                │  Cache Hit?    │         │
                └────┬────────┬──┘         │
                     │        │            │
                 Yes │        │ No         │
                     │        │            │
                     ▼        ▼            │
          ┌─────────────┐  ┌────────────┐ │
          │Return Cached│  │Query DB    │ │
          └──────┬──────┘  └─────┬──────┘ │
                 │                │        │
                 │                ▼        │
                 │         ┌────────────┐  │
                 │         │Process Data│  │
                 │         └─────┬──────┘  │
                 │               │         │
                 │               ▼         │
                 │         ┌────────────┐  │
                 │         │Save Cache  │  │
                 │         └─────┬──────┘  │
                 │               │         │
                 └───────┬───────┘         │
                         │                 │
                         ▼                 │
                   ┌───────────┐           │
                   │Return Data│           │
                   └─────┬─────┘           │
                         │                 │
                         └─────────┬───────┘
                                   │
                                   ▼
                            ┌────────────┐
                            │    End     │
                            └────────────┘
```

**Elements:**
- `┌─┐ └─┘` - Process boxes
- `◇` - Decision diamonds (or use box format)
- `─────>` - Flow arrows
- Labels on arrows

## Best Practices

### Clear Component Names

Use full, descriptive names in boxes:
```
┌────────────────────────┐
│ RelatedProductsController │
└────────────────────────┘
```

### Show Activation/Deactivation

Use indentation or annotations:
```
Controller
  │ [ACTIVE]
  │──> Service
  │      [ACTIVE]
  │      └──> Database
  │            [ACTIVE]
  │            Result
  │      <────
  │      [INACTIVE]
  │ <────
  │ [INACTIVE]
```

### Add Notes

Use text annotations:
```
     │  get(key)        │
     │─────────────────>│
     │                  │  // Checks Redis cache
     │     null         │  // with 1-hour TTL
     │<─ ─ ─ ─ ─ ─ ─ ─ ─│
```

### Error Paths

Show alternative flows clearly:
```
    ┌──────────────┐
    │ Validate DTO │
    └──────┬───────┘
           │
    ┌──────▼─────────┐
    │  Valid?        │
    └──┬────────────┬┘
       │ Yes        │ No
       │            │
       ▼            ▼
   [Success]    [400 Error]
    Path         Path
```

### Parallel Operations

Show side-by-side:
```
Service
  │
  ├─────────────────┬─────────────────┬─────────────────┐
  │                 │                 │                 │
  ▼                 ▼                 ▼                 ▼
┌────────┐     ┌────────┐     ┌────────┐     ┌────────┐
│ Fetch  │     │ Fetch  │     │ Fetch  │     │ Fetch  │
│ Users  │     │ Orders │     │Products│     │ Stats  │
└───┬────┘     └───┬────┘     └───┬────┘     └───┬────┘
    │              │              │              │
    └──────────────┴──────────────┴──────────────┘
                   │
                   ▼
            Combine Results
```

## Common NestJS Patterns

### CRUD Operation with Guards

```
┌─────────┐  ┌──────────┐  ┌────────────┐  ┌────────────────┐  ┌─────────┐  ┌───────┐  ┌──────────┐
│ Client  │  │AuthGuard │  │ Controller │  │ValidationPipe  │  │ Service │  │ Model │  │ Knex(W)  │
└────┬────┘  └────┬─────┘  └─────┬──────┘  └───────┬────────┘  └────┬────┘  └───┬───┘  └────┬─────┘
     │            │               │                 │                 │           │           │
     │ POST /api  │               │                 │                 │           │           │
     │───────────>│               │                 │                 │           │           │
     │            │               │                 │                 │           │           │
     │            │ Verify JWT    │                 │                 │           │           │
     │            │───────────────>│                 │                 │           │           │
     │            │               │                 │                 │           │           │
     │            │    Authorized │                 │                 │           │           │
     │            │<───────────────│                 │                 │           │           │
     │            │               │                 │                 │           │           │
     │            │               │  Validate DTO   │                 │           │           │
     │            │               │────────────────>│                 │           │           │
     │            │               │                 │                 │           │           │
     │            │               │    Valid DTO    │                 │           │           │
     │            │               │<────────────────│                 │           │           │
     │            │               │                 │                 │           │           │
     │            │               │      create(dto)│                 │           │           │
     │            │               │────────────────────────────────────>           │           │
     │            │               │                 │                 │           │           │
     │            │               │                 │                 │create(data)           │
     │            │               │                 │                 │──────────>│           │
     │            │               │                 │                 │           │           │
     │            │               │                 │                 │           │INSERT INTO│
     │            │               │                 │                 │           │──────────>│
     │            │               │                 │                 │           │           │
     │            │               │                 │                 │           │  Result   │
     │            │               │                 │                 │           │<──────────│
     │            │               │                 │                 │           │           │
     │            │               │                 │                 │   Entity  │           │
     │            │               │                 │                 │<──────────│           │
     │            │               │                 │                 │           │           │
     │            │               │                 │      EntityDto  │           │           │
     │            │               │<────────────────────────────────────           │           │
     │            │               │                 │                 │           │           │
     │ 201 Created│               │                 │                 │           │           │
     │<───────────────────────────│                 │                 │           │           │
     │            │               │                 │                 │           │           │
```

### Database Read/Write Pattern

```
API Request
    │
    ▼
┌───────────────┐
│ Determine Op  │
└───────┬───────┘
        │
        │
    ┌───▼────┐
    │  Type? │
    └───┬────┘
        │
  ┌─────┴─────┐
  │           │
Read          Write
  │           │
  ▼           ▼
┌──────────┐ ┌──────────┐
│Knex Read │ │Knex Write│
│Connection│ │Connection│
└────┬─────┘ └────┬─────┘
     │            │
     │            ▼
     │      ┌────────────┐
     │      │Transaction │
     │      └────┬───────┘
     │           │
     └─────┬─────┘
           │
           ▼
      ┌─────────┐
      │Response │
      └─────────┘
```

### Caching Strategy

```
┌─────────┐   ┌─────────┐   ┌──────────┐   ┌──────────┐
│ Client  │   │ Service │   │  Cache   │   │ Database │
└────┬────┘   └────┬────┘   └────┬─────┘   └────┬─────┘
     │             │              │              │
     │ getData(id) │              │              │
     │────────────>│              │              │
     │             │              │              │
     │             │ get(key)     │              │
     │             │─────────────>│              │
     │             │              │              │
     │             │   Hit/Miss?  │              │
     │             │              │              │
     │             ├──────────────┤              │
     │             │              │              │
     │         If Hit:            │              │
     │             │ Data         │              │
     │             │<─────────────│              │
     │             │              │              │
     │      Data   │              │              │
     │<────────────│              │              │
     │             │              │              │
     │         If Miss:           │              │
     │             │              │              │
     │             │        Query database       │
     │             │───────────────────────────> │
     │             │              │              │
     │             │              │    Data      │
     │             │<─────────────────────────── │
     │             │              │              │
     │             │ set(key,data)│              │
     │             │─────────────>│              │
     │             │              │              │
     │             │      OK      │              │
     │             │<─────────────│              │
     │             │              │              │
     │      Data   │              │              │
     │<────────────│              │              │
     │             │              │              │
```

## Output Format

Output diagrams as code blocks:

```
[ASCII art diagram here]
```

No special rendering needed - pure text displays everywhere.

## Success Checklist

Good ASCII diagram:
- ✅ Clear component boxes with full names
- ✅ Logical flow (top-to-bottom or left-to-right)
- ✅ Aligned lines and arrows
- ✅ Labels on all arrows/connections
- ✅ Consistent spacing and formatting
- ✅ Error paths shown (if applicable)
- ✅ Notes for complex operations
- ✅ Readable in any text editor/viewer
- ✅ Uses box-drawing characters properly
