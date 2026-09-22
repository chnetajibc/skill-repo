# Research matrix (2026-09-23)

How the 21 source repos were classified and what was taken from each. Rule: prefer official/vendor and battle-tested workflows; never bulk-copy catalogues; adapt concepts into our own focused skills, keep verbatim upstream under `references/` for provenance.

## Legend

- IMPORT: copied upstream skill dir verbatim into a new leaf's `references/` (SKILL.md here is our own concise router).
- ADAPT: fused upstream bodies into an existing leaf earlier; or rewrote leaf with upstream-informed procedures.
- IGNORE: deliberately not taken, with reason.

| # | Repo | Type | Activity (local clone) | Relevant skills taken | Overlap with local | Decision |
|---|---|---|---|---|---|---|
| 1 | anthropics/skills | Official examples | Active (Managed-Agents update) | mcp-builder, skill-creator | None (new ai/*) | IMPORT refs into ai/mcp-engineering, ai/skill-design; IGNORE creative/productivity skills (off-scope) |
| 2 | openai/codex (samples) | Product samples | Monorepo subdir, uneven | review-agent (already fused into core/code-review) | core/code-review | IGNORE (already fused); doctrine reused in ai/skill-design |
| 3 | openai/skills | Community grab-bag, DEPRECATED (points to openai/plugins) | Stale README, thin curation | security-threat-model, security-best-practices refs, gh-fix-ci, gh-address-comments, vercel-deploy | Partial (security, devops) | IMPORT refs for devops/github-actions, github/pr-workflow, cloud/aws-foundations, security/secure-baseline; IGNORE ownership-map (niche deps), rest (uneven) |
| 4 | wshobson/agents | Agent-plugin collection, tested (Makefile, tools/tests) | Active 2026-09-13 | cicd-automation, cloud-infrastructure, api-scaffolding, observability | tooling/ci-cd, cloud (new) | IMPORT refs for devops/github-actions, cloud/aws-foundations; IGNORE bulk plugins (duplication, uneven depth) |
| 5 | obra/superpowers | Methodology (spec→plan→TDD→debug) | Active v6.4.1, per-skill tests | test-driven-development, systematic-debugging, writing-plans, git-worktrees | core/testing, core/debugging, core/planning, git/* | IMPORT refs into core/testing, core/debugging; ADAPT planning ideas; IGNORE harness-specific rituals |
| 6 | VoltAgent/awesome-agent-skills | Awesome-list catalogue (links only) | Active, no code | Vendor pointers (Stripe/Sentry/Trail-of-Bits) | None directly | IGNORE bulk; resolve vendor-original links only if needed later (link-rot risk) |
| 7 | ComposioHQ/awesome-claude-skills | Vendor-specific (Composio MCP) + 800 app-automations | Stale-ish 2026-07-24; proprietary LICENSE.txt on doc-skills | webapp-testing checklist, changelog-generator | core/testing, git/git-release | IGNORE bulk (vendor lock-in, automation spam, license risk); no import taken |
| 8 | travisvn/awesome-claude-skills | Awesome-list catalogue | Stale 2026-04-28, README-only | frontend-design anti-slop, mcp-builder pointer | frontend/*, ai/mcp-engineering | IGNORE as source (follow links to anthropics originals instead) |
| 9 | OWASP/secure-agent-playbook | Security playbook (OWASP-grounded) | Excellent docs, consistent SKILL→play structure | api-security-review, code-review-security, web-security-review, secrets-scan, sca-audit, mcp-server-review, prompt-injection-test, llm-risk-assess, agent-security-audit | backend/api-security et al (fused earlier) | IMPORT refs for security/secure-baseline, security/secrets-supply-chain, security/agent-security; scanner skills gated on tool availability |
| 10 | getsentry/skills | Production collection, dogfooded | Good README; security-review 312 lines | security-review discipline, gha-security-review, django-access-review | backend/*security*, core/code-review | IMPORT gha ref into secrets-supply-chain; CAUTION: promised go/rust/java guides are MISSING upstream — do not claim coverage from Sentry |
| 11 | nextlevelbuilder/ui-ux-pro-max | Data-driven UI kit + CLI | Active, 720L README | ui-ux-pro-max lookup DB + scripts | frontend/* | ADAPT as reference data (already under design-systems/responsive-design); not imported wholesale (bloat) |
| 12 | mblode/agent-skills | Product/UI + repo-ops, TS-centric | Active, evals+refs | codebase-architecture (fused), ui-verification, scaffold-nextjs, multi-tenant-architecture, pr-creator | core/repository-understanding, frontend/*, frameworks/nextjs, github/* | IMPORT refs for frontend/ui-verification, frameworks/nextjs, github/pr-workflow, saas/*; IGNORE eli5/chat-history/seo (thin/off-scope) |
| 13 | addyosmani/agent-skills | Curated workflow pack, evals | Active 2026-09-20 | git-workflow, code-review, debugging, TDD, docs, api-design, frontend-ui | core/*, git/*, architecture/*, frontend/* | ADAPT (fused earlier); canonical over kk-agent fork |
| 14 | hueyexe/frontend-agent-skills | Frontend design-system pack | Slow 2026-08-02, consistently ~300L | accessibility, design-systems, forms, interaction | frontend/* | IMPORT/ADAPT fused earlier; strongest a11y/design-systems |
| 15 | Junaid-PK/frontend-design-skill | Single SaaS-clarity skill | Single-shot | frontend-design checklist | frontend/* (weaker than hueyexe) | ADAPT checklist only; not standalone |
| 16 | Xialiang98/design-visual-frontend | Visual-composition skill | Single-shot | viewport matrix + review gates | frontend/responsive-design | ADAPT fused earlier |
| 17 | kk-agent/skill.md | Stale fork of addyosmani | Stale 2026-06-10 | Same names as addyosmani, older | 100% duplicate | IGNORE entirely; prefer addyosmani canonical |
| 18 | khasky/awesome-agent-skills | Audit micro-skill library | Very active 2026-09-22 | code-review, commit-plan/history-rebuild/salvage, code-standards, error-standards, architecture-audit | core/*, git/*, architecture/* | IMPORT selective (review rigor, history surgery); FLAG thin stubs (test-writing 71L, api-design 78L, database-audit 100L) — supplemented, not relied on |
| 19 | bjornjee/skills | Personal patterns plugin | Active 2026-09-17 | git-workflow, golang-patterns/testing, python/fastapi-patterns, typescript-patterns, react-native-patterns, api-design, distributed-systems, github-ops, strict reviewers | languages/*, frameworks/*, git/* | IMPORT (highest signal/repo); distributed-systems → distributed/foundations |
| 20 | rubencr14/agent-skills | Small generalist pack | Stale 2026-03-24 | backend-development (FastAPI+DDD narrative), web-testing | frameworks/fastapi, core/testing | ADAPT (fused earlier); IGNORE thin frontend-design/cybersecurity |
| 21 | magnus919/agent-skills | Mega methodology monorepo | Very active 2026-09-21 | software-architecture, systematic-debugging, research-methodology, postgres, docker-compose, ml-engineering, product-*, multi-tenant-saas | architecture/*, core/*, research/*, new domains | IMPORT refs for databases, devops, ml, product, saas, startup; IGNORE long tail (actuarial, occultism, etc.) |

## Deliberately NOT imported

- kk-agent (stale duplicate of addyosmani).
- Composio 800 app-automations + proprietary doc-skills (lock-in, license risk, zero engineering value).
- VoltAgent/travisvn catalogues wholesale (link-rot, mixed quality; vendor-originals only).
- wshobson bulk plugins (94; duplication + uneven depth; skill-level picks only).
- nextlevelbuilder wholesale (token-heavy data bundle; referenced, not inlined).
- mblode off-topic (eli5, chat-history, ghostwriter, seo, save-md).
- openai-skills ownership-map (niche `networkx` dep), deprecated repo status (verify against openai/plugins before further use).
- Stale-anonymous "best of YouTube/Reddit/X" claims from the earlier ChatGPT brief: treated as practitioner opinion, never as API authority; official docs rule per research/documentation-search.
