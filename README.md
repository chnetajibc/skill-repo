# skill-repo

Production-grade skill system for autonomous coding agents (OpenCode and others):
103 focused skills across 20 domains for a software engineer + solo founder.

## Layout

`skills/<domain>/<skill>/SKILL.md` + `references/` (verbatim upstream provenance).

- `core/` — engineering workflow, repo understanding, planning, testing, review, debugging
- `git/` — scenario-driven workflows, recovery, rebase, release
- `architecture/` — clean code, SOLID, modularity, per-language structuring, API/data design
- `backend/` — API design/security, auth, validation, data, transactions
- `frontend/` — UI architecture, design systems, UI libraries, responsive, a11y, SEO, media assets, verification
- `languages/` — python, java, typescript, javascript, rust, go
- `frameworks/` — fastapi, spring-boot, spring-security, express, nextjs, react, react-native, expo, electron
- `security/` — baseline review, secrets/supply-chain, agent security
- `databases/` — fundamentals, postgres, mysql, redis, mongodb, security
- `research/` — documentation-search (runtime doc behavior + version detection), library/dependency evaluation
- `tooling/`, `devops/`, `github/`, `cloud/`, `distributed/`, `ai/`, `ml/`, `product/`, `saas/`, `startup/`

## Key behaviors

- **Official docs at runtime:** detect technology + installed version, research official docs for that version when uncertain, verify against docs. See `research/documentation-search` (+ `framework-registry.yaml`, `detect-versions.sh`).
- **Progressive disclosure:** thin `SKILL.md` routers; detail loads from `references/` only when needed.
- **Verify before claiming:** tests, builds, runtime evidence; diff-first review.

## Validate & test

```bash
bash scripts/validate.sh
bash skills/research/documentation-search/scripts/run-doc-behavior-tests.sh
```

## Docs

- `SOURCES.md` — upstream sources + layout
- `RESEARCH.md` — import/adapt/ignore matrix for 21 researched repos
- `CAPABILITY.md` — STRONG/ADEQUATE/PARTIAL/MISSING matrix
- `VALIDATION.md` — latest validation record
