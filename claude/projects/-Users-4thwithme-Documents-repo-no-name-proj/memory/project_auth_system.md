---
name: Auth system design decisions
description: Key auth architecture decisions for the no-name-proj B2B multi-tenant app
type: project
---

Multi-tenant B2B app with OAuth auth (GitHub + Google via Arctic library).

Key decisions:
- **Database**: PostgreSQL with read/write replicas via Knex.js (nest-knexjs), NOT an ORM
- **Cache/Sessions**: Redis with read/write separation via ioredis, Keyv, Redlock — pattern replicated from ../recommendations-service/
- **Auth flow**: Arctic OAuth with PKCE → temporary auth code in Redis → POST /auth/token exchange → JWT (HS256, 1hr access + 30d refresh in Redis)
- **Session**: Server-side in Redis, validated on every request. Refresh token theft detection via tombstone keys.
- **Roles**: Derived from company_members table (not stored on users). Admin 1:1 with company (DB-enforced partial unique index). Members can belong to multiple companies.
- **Account linking**: Prompt user when email conflict detected (not auto-link)
- **Invitations**: Admin invites by email only. Role restricted to 'member'. 72hr expiry, single-use tokens.

**Why:** Patterns replicate ../recommendations-service/ for consistency across the team's projects.

**How to apply:** All new modules follow the same Knex model/service/DTO pattern. Redis operations use the cache module's read/write separation.
