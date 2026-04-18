---
name: Product Finder V1
description: Use case driven product assistant (Shopping Assistant) - A/B test feature being built for Custom Ink header
type: project
---

Building "Product Finder V1 — Use Case Driven Product Assistant" as an A/B test.

**Why:** Users know their use case (onboarding, trade shows, gifting) but not the product. Current header only supports direct-to-product navigation. Competitors (4imprint, Vistaprint) have static use-case paths — CI wants dynamic/personalized.

**How to apply:** When asked about this feature, refer to the full technical context below. Help generate copy, tooltips, UI text, and demo content on demand.

---

## Entry Points
- Button in header near Search: label "Shopping Assistant"
- Rotating gradient border (conic-gradient blue→purple) — NOT a chatbot bubble, no AI branding, no stars/sparkles
- Opens a modal/popup chat interface

## Use Cases (8 hard-coded tags)
1. **Onboarding** — new hire welcome kits, mix of tech + apparel
2. **Trade Shows** — high-utility, high-visibility promo items
3. **Events** — fundraisers, meetups, community gatherings
4. **Gifting** — client appreciation, premium leave-behinds
5. **Uniforming** — corporate/school staff identity
6. **Spirit Wear** — school/team pride apparel
7. **Team & Club Gear** — greek life, youth groups, sports clubs
8. **Reselling** — brand-building product lines

Each tag has:
- **Tooltip "Pro Tip"** shown on hover (curatorial buying guidance)
- **Blurb** shown in AI response bubble after selection

## UI Components (ci-header-footer repo, Stencil.js web component)
- Component: `ci-ask-ai` at `/src/components/ci-ask-ai/ci-ask-ai.tsx`
- Styles: `/src/components/ci-ask-ai/ci-ask-ai.scss`
- Chat history in `localStorage` key `ci-ask-ai-history`
- Free text input: 120 char max, Enter to send, ArrowUp/Down for history
- Example queries shown above input area
- "Clear" button to wipe history
- Confidence badge on product cards (expands on hover)

## Backend (recommendations-service)
- API: `GET /api/v1/neural-search?q=...&limit=12`
- API: `GET /api/v1/neural-search/use-case/:useCase?limit=12`
- Service: `NeuralSearchService` → `OpensearchNeuralService`
- Model: `all-distilroberta-v1` (128-token effective limit, 768-dim embeddings)
- Index: HNSW + FAISS kNN vector index in OpenSearch
- Hybrid pipeline: 10% keyword (BM25) / 90% vector, min-max normalization

## Query Intelligence (built into OpensearchNeuralService)
- Brand detection (Nike, Gildan, etc.)
- Color detection → swaps product image to matching colorway
- Size detection (XL, large, etc.)
- Price range parsing ("from $120 to $200", "under $50", "around $30")
- Price level detection (budget/mid/premium)
- Gender detection (women's → product_type filter)
- Query synonyms (tshirt → t-shirt, dri-fit normalization, etc.)
- Confidence score: `min(round((score/maxScore)² × 100), 100)`

## Use Case → Category Mapping
Each use case maps to category+query pairs in `NEURAL_SEARCH_TAG_CATEGORY_NAMES` constant.
Results are round-robin interleaved across categories for diversity.

## Success Metrics
- Primary: Continued Interaction Rate (click into use case / chat / helper question)
- Engagement: Guided Finder Interaction Rate, Recommendation Card CTR
- Lab Load continuation rate

## Constraints
- NO LLM in hot path (no GPT latency/cost)
- NOT conversational — product finder, not chatbot
- No personalization in V1
- No AI branding (no stars/sparkles)
- Must not compete with / confuse Search

## PM/Author
- Lissa Eckert (Product Manager / Author of spec doc)
