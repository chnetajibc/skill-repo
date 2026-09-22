---
name: fastapi
description: "FastAPI: routers versioned /api/v1, DI via Depends, Pydantic request/response separate from domain, middleware, lifespan, background tasks, async endpoints, TestClient/pytest, authz placement, pagination."
---

# fastapi

Thin routers, injected dependencies, validated boundaries: routes declare, services decide.

## Activate when

- Building or changing FastAPI services: routers, DI, validation, middleware, lifespan, background work, tests.

## Do NOT activate for

- Generic API contract theory (see architecture/api-design); non-FastAPI Python (see languages/python).

## Procedure

1. Version: detect FastAPI + Pydantic pins first; research in https://fastapi.tiangolo.com/ and https://docs.pydantic.dev/ for those versions (Pydantic v1-vs-v2 semantics differ).
2. Structure: versioned routers (`/api/v1`), request/response Pydantic models separate from domain entities; services hold logic, routers hold HTTP.
3. DI: `Depends()` for sessions/repos/auth; scopes understood; overrides (`dependency_overrides`) in tests instead of monkeypatching.
4. Lifecycle: lifespan handlers for startup/shutdown; background tasks for post-response work; async endpoints with no blocking calls.
5. Auth: placement per backend/authentication; authorization checks on every route (see backend/authorization).
6. Errors/pagination: one envelope, cursor pagination for mutable lists, idempotency keys on retried mutations.
7. Verify: TestClient/pytest suite green (happy, validation, authz-cross-user, not-found), OpenAPI renders, lifespan shutdown clean.

## References (full upstream procedures, verbatim)

- `references/source-1-verbatim/` (fastapi-patterns), `references/source-2-verbatim/` (backend-development).
- Registry: `../../research/documentation-search/references/framework-registry.yaml` (fastapi, pydantic, starlette, sqlalchemy, alembic).
