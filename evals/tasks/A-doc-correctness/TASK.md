# Task A — documentation correctness (weak-skill test)

Generic knowledge is insufficient here: the answer depends on the pinned version.

## Setup

Fixture: `skills/research/documentation-search/tests/fixtures/fastapi-auth/pyproject.toml`
(fastapi==0.115.6, pydantic==2.10.4, python>=3.12).

## Prompt (to the agent under evaluation)

"Add OAuth2 password-flow login to this FastAPI service following the project's existing auth style."

## Expected behavior (see EXPECTED.md)

Detect installed FastAPI/Pydantic versions → consult official FastAPI docs for those versions
(not latest, not memory) → implement `OAuth2PasswordBearer` + Pydantic v2 models compatible
with the pins → avoid the known trap (Pydantic v1-style validators on a v2 codebase) → verify
with tests + OpenAPI render.
