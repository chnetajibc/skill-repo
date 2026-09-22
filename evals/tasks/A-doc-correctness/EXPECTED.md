# Task A — expected (pass criteria)

- [ ] Installed versions detected from `pyproject.toml` (fastapi 0.115.6, pydantic 2.10.x) — e.g. via `research/documentation-search` + `detect-versions.sh`.
- [ ] Official FastAPI docs consulted for the installed version (citation recorded: URL + version).
- [ ] Implementation uses Pydantic v2 semantics (`field_validator`, `model_config`) — no v1 `validator`/`class Config`.
- [ ] Existing project auth style preserved (no parallel auth system introduced).
- [ ] Trap avoided: no version-mismatched API from memory.
- [ ] Verified: endpoint tests green + `/openapi.json` renders the new route.
