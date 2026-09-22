# Capability matrix (2026-09-23)

Honest classification per capability. STRONG = dedicated operational skill with procedure + verification.
ADEQUATE = covered well enough for autonomous work. PARTIAL = present but thin or scattered.
MISSING = absent. Scale statements, not aspirations.
Coverage is exercised by `evals/tasks` (A-E) and `research/documentation-search` behavior tests.

## Engineering

| Capability | Level | Where |
|---|---|---|
| repository understanding | STRONG | core/repository-understanding |
| architecture | STRONG | architecture/* (10) + software-architecture refs |
| modularity | STRONG | architecture/modularity + language-modularity |
| language-specific structure | STRONG | architecture/language-modularity + languages/* |
| framework-specific structure | STRONG | frameworks/* (10) |
| code generation | ADEQUATE | core/implementation + framework skills |
| refactoring | STRONG | core/refactoring |
| debugging | STRONG | core/debugging (+ obra refs) |
| testing | STRONG | core/testing (+ obra TDD, ui-verification) |
| TDD | ADEQUATE | core/testing (red-green mandated; no per-language TDD drills) |
| code review | STRONG | core/code-review + github/pr-workflow |
| dependency research | STRONG | core/dependency-research + research/dependency-evaluation |
| documentation research | STRONG | research/documentation-search (+ registry, detector, tests) |
| Git | STRONG | git/* (7) |
| CI/CD | STRONG | tooling/ci-cd + devops/github-actions |
| observability | ADEQUATE | architecture/observability (no dedicated Prometheus/Grafana drills) |

## Backend

| Capability | Level | Where |
|---|---|---|
| API design | STRONG | architecture/api-design + backend/api-design (split scopes) |
| API security | STRONG | backend/api-security + security/* |
| authentication | STRONG | backend/authentication + spring-security |
| authorization | STRONG | backend/authorization |
| databases | STRONG | databases/* (6: fundamentals, postgres, mysql, redis, mongodb, security) |
| migrations | ADEQUATE | backend/migrations + per-engine notes |
| caching | ADEQUATE | backend/caching + databases/redis |
| queues/background jobs | ADEQUATE | distributed/systems + backend/concurrency |
| distributed systems | ADEQUATE | distributed/systems (single skill, no Kafka/RabbitMQ drills) |
| error handling | ADEQUATE | architecture/error-handling |
| rate limiting | ADEQUATE | backend/rate-limiting |

## Frontend

| Capability | Level | Where |
|---|---|---|
| UI/UX | STRONG | frontend/ui-architecture, component-design, design-systems |
| component architecture | STRONG | frontend/component-design + ui-architecture |
| design systems | STRONG | frontend/design-systems |
| UI libraries | STRONG | frontend/ui-libraries (8 libs, reuse-first) |
| responsive design | STRONG | frontend/responsive-design |
| accessibility | STRONG | frontend/accessibility (WCAG 2.1 AA) |
| technical SEO | STRONG | frontend/technical-seo |
| asset/media handling | STRONG | frontend/media-assets |
| performance | STRONG | frontend/performance |
| browser verification | STRONG | frontend/ui-verification |
| visual regression | ADEQUATE | ui-verification probes (no dedicated pixel-diff infra) |

## Languages/frameworks

| Capability | Level | Where |
|---|---|---|
| Python | STRONG | languages/python |
| FastAPI | STRONG | frameworks/fastapi |
| TypeScript | ADEQUATE | languages/typescript (concise; no generics drills) |
| JavaScript | STRONG | languages/javascript |
| React | STRONG | frameworks/react |
| Next.js | STRONG | frameworks/nextjs (generation-aware) |
| React Native | ADEQUATE | frameworks/react-native (concise patterns) |
| Expo | ADEQUATE | frameworks/expo (SDK-first; no EAS drill scripts) |
| Express | STRONG | frameworks/express (v4/v5-aware) |
| Electron | STRONG | frameworks/electron (security-first) |
| Java | STRONG | languages/java |
| Spring Boot | STRONG | frameworks/spring-boot |
| Spring Security | STRONG | frameworks/spring-security |
| Go | STRONG | languages/go |
| Rust | STRONG | languages/rust (Tokio/Axum/Serde) |

## Infrastructure

| Capability | Level | Where |
|---|---|---|
| Docker | ADEQUATE | tooling/containers + devops/docker-compose |
| Docker Compose | STRONG | devops/docker-compose |
| Kubernetes | PARTIAL | registry pointers only; no dedicated skill |
| GitHub Actions | STRONG | devops/github-actions |
| AWS | STRONG | cloud/aws-foundations |
| GCP | ADEQUATE | cloud/gcp (essentials, thinner than AWS) |
| Azure | ADEQUATE | cloud/azure (essentials, thinner than AWS) |
| Nginx | PARTIAL | registry pointers only; no dedicated skill |
| Terraform | PARTIAL | registry pointers + version detection; no dedicated skill |
| Linux/systemd | PARTIAL | registry pointers only; no dedicated skill |

## AI/ML

| Capability | Level | Where |
|---|---|---|
| MCP | STRONG | ai/mcp-engineering + security/agent-security |
| agent architecture | ADEQUATE | ai/agent-architecture (no harness-specific drills) |
| skill design | STRONG | ai/skill-design |
| LLM integration | ADEQUATE | ai/agent-architecture (routing/fallbacks; no provider SDK drills) |
| model serving | ADEQUATE | ml/model-serving |
| PyTorch | PARTIAL | registry + ml/model-serving pointers; no dedicated skill |
| Transformers | PARTIAL | registry pointers only |
| ONNX | PARTIAL | registry pointers only |
| Triton | PARTIAL | registry pointers only |
| ML observability | PARTIAL | ml/model-serving section only (drift/slo basics) |

## Intentional limitations

- No Kubernetes/Nginx/Terraform/Linux skills: registry + version detection cover discovery; dedicated skills deferred until actually used.
- ML stays at serving/ops level: training/eval depth deferred.
- GCP/Azure deliberately thinner than AWS (current relevance); same procedure shape, provider docs resolve specifics.
