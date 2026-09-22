# skill-repo

Production-grade skill system for autonomous coding agents (OpenCode and others):
103 operational skills across 20 domains for a software engineer + solo founder.

## Layout

`skills/<domain>/<skill>/SKILL.md` — each skill is self-contained knowledge:
activation, inspection, decision rules, procedure, failure modes, verification, escalation.
Deeper detail lives in per-skill `references/`; shared research via the central registry.

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
- **Progressive disclosure:** operational `SKILL.md` routers (activation → inspection → decisions → procedure → verification); detail in `references/` only when needed.
- **Verify before claiming:** tests, builds, runtime evidence; diff-first review.

## Validate & test

```bash
bash scripts/validate.sh                                  # structure, links, registry, depth, perms
bash skills/research/documentation-search/scripts/run-doc-behavior-tests.sh  # TEST 1-8
bash evals/run-task-evals.sh                              # agent-task evals A-E structure
```

CI (`.github/workflows/validate.yml`) runs all three on push/PR.

## Docs

- `CAPABILITY.md` — STRONG/ADEQUATE/PARTIAL/MISSING matrix (honest, no inflation)

## Limitations (by design)

- UI verification is probe-based (functional/layout/responsive/a11y) — pixel-comparison visual regression is NOT implemented.
- Kubernetes, Nginx, Terraform, Linux, PyTorch/Transformers/ONNX/Triton: registry pointers + version detection only, no dedicated skills.
- GCP/Azure deliberately thinner than AWS; same procedure shape, provider docs resolve specifics.
- No live browser automation or MCP integrations in this repo — that is the MCP layer, not the skills layer.
