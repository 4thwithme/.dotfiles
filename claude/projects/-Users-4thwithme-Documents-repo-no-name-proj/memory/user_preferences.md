---
name: User development preferences
description: User's preferred tools, patterns, and working style for this project
type: user
---

- Prefers PostgreSQL with read/write replicas
- Prefers Knex.js over ORMs (TypeORM, Prisma, Drizzle) — consistency with recommendations-service
- Prefers Redis with read/write separation for caching and sessions
- Prefers Arctic over Passport.js for OAuth (lightweight, no bloat)
- Chooses HS256 for JWT (single backend)
- Prefers server-side sessions + JWT hybrid over pure stateless JWT
- Lives in CEST timezone (UTC+2)
- Communication style: brief, direct, uses shorthand ("ep" = yep)
- Has an existing recommendations-service codebase that serves as the pattern reference
