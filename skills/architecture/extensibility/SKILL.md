---
name: extensibility
description: "Build extendable systems: ports/adapters, DI, stable interfaces. Abstract only on real duplication and stable concepts."
---

# extensibility

Build extendable systems: ports/adapters, DI, stable interfaces. Abstract only on real duplication and stable concepts.

## Sources fused without loss (verbatim)

- source-1 magnus919-agent-skills/software-architecture in references/source-1-verbatim/
- source-2 magnus919-agent-skills/backend-engineering in references/source-2-verbatim/
- Both bodies inlined below in full. Stricter wins on overlap; if conflict prefer safer/security-first and note assumption.

--- BEGIN VERBATIM SOURCE 1: magnus919-agent-skills/software-architecture ---

---
name: software-architecture
description: Design and review software architectures from business drivers through system boundaries, tradeoffs, runtime behavior, evolution, and architecture practice. Use when choosing a greenfield or target architecture, comparing modular-monolith and service shapes, designing distributed consistency, replication, partitioning, coordination, ordering, transaction isolation, or failure behavior, defining architecture fitness evidence, or facilitating a consequential architecture review. Do not use for reverse engineering, API contract semantics, data-platform design, implementation, infrastructure operations, security lifecycle, or migration execution; route those to the named specialist skills.
license: MIT
compatibility: Platform-agnostic methodology. No runtime dependencies.
metadata:
  tags: software-architecture, architecture-design, tradeoffs, modularity, distributed-systems, evolutionary-architecture, architecture-review
---

# Software Architecture

Use this skill to make system-level design decisions and leave an inspectable path from drivers to evidence. It owns the architecture decision workflow, not the implementation of any subsystem.

## Workflow

1. **Frame the decision.** Establish the desired outcome, stakeholders, constraints, decision horizon, reversibility, affected systems, and evidence gaps. Do not invent scale, regulatory, latency, or ownership facts.
2. **Turn qualities into scenarios.** Name the architecture characteristics that matter, express each as an observable scenario, prioritize them, and expose conflicts. Load `references/architecture-characteristics-and-tradeoffs.md`.
3. **Choose boundaries and shape.** Compare styles, topology, and deployment granularity against the scenarios and team operating capacity. Load `references/styles-topologies-and-granularity.md`.
4. **Test ownership and coupling.** Identify policy, data, change, runtime, and team boundaries. Treat a service split as a hypothesis, not a default. Load `references/coupling-modularity-and-data-ownership.md`.
5. **Make runtime behavior explicit.** For asynchronous or distributed flows, specify authority, consistency, ordering, retries, duplicates, timeouts, partial failure, recovery, and reconciliation. Load `references/distributed-workflows-and-consistency.md`.
6. **Record and verify.** Capture the decision and rejected alternatives in `templates/architecture-design-brief.md` and `templates/tradeoff-record.md`; use `templates/architecture-review.md` for challenge and sign-off. Define fitness evidence and drift response with `references/evolution-fitness-functions-and-drift.md`.
7. **Plan change without hiding execution ownership.** Identify evolutionary slices, coexistence assumptions, and handoff conditions. Load `references/migration-and-coexistence.md`; route an approved transition to `migration-engineering`.
8. **Facilitate proportionately.** Match review depth to blast radius, irreversibility, uncertainty, and cross-team impact. Load `references/architecture-practice-and-facilitation.md`.

## Output Contract

Produce an architecture decision brief or review that includes drivers, stakeholders, constraints, prioritized scenarios, candidate options, explicit tradeoffs, boundaries and ownership, runtime and failure behavior, operational implications, decisions, evidence gaps, fitness checks, evolution slices, and named owners. State what is decided, what remains open, and which specialist owns follow-up work.

## Ownership Boundaries

- Reverse engineer an existing codebase or infer architecture from repository evidence with `software-architecture-analysis`.
- Design interface contracts, schemas, compatibility, or API topology with `api-design-and-evolution`.
- Design data platforms, data products, data models, or data governance with `data-architect`.
- Implement services, integrations, transactions, or application code with `backend-engineering` and the relevant engineering owner.
- Provision or operate cloud, network, CI/CD, containers, secrets, or observability substrate with `platform-engineering` and its tool owners.
- Define security requirements, threat models, authorization, secrets, or security evidence with `secure-software-engineering`.
- Author the durable ADR with `adr-authoring`; this skill supplies the architecture decision context and tradeoff analysis.
- Execute an approved cross-system transition with `migration-engineering`; this skill decides whether the target shape and boundary are justified.
- Model capacity, unit cost, load evidence, or SLO-cost tradeoffs with `capacity-and-cost-engineering`.
- Design and exercise degradation, failover, restore, or recovery evidence with `resilience-and-recovery`.
- Create structural diagrams with `c4-diagramming` or `mermaid-diagrams`.
- Govern a technology portfolio, radar, or proportional technology governance path with `technology-radar`.

## When Not To Use

Do not use this skill as a substitute for those specialist owners, as a code review workflow, or as a vendor/tool runbook. If the request is only one interface, data platform, implementation, infrastructure, security, capacity, diagram, ADR, or migration concern, load the narrower owner directly. If the architecture question depends on facts from an existing system, start with `software-architecture-analysis` and return here for a target decision.

## Reference Guide

| Load when | Reference |
|---|---|
| Prioritizing qualities and comparing conflicting outcomes | `references/architecture-characteristics-and-tradeoffs.md` |
| Comparing styles, deployment topology, or granularity | `references/styles-topologies-and-granularity.md` |
| Testing modularity, coupling, boundaries, and data authority | `references/coupling-modularity-and-data-ownership.md` |
| Designing distributed workflows, consistency, or failure behavior | `references/distributed-workflows-and-consistency.md` |
| Choosing replication, partitioning, coordination, ordering, or transaction-isolation mechanisms | `references/distributed-workflows-and-consistency.md`, then the [DDIA mini reference](../programming-principles/references/designing-data-intensive-apps.mini.md); load the [full reference](../programming-principles/references/designing-data-intensive-apps.full.md) only when deeper mechanism analysis is necessary |
| Defining fitness evidence, drift response, or evolutionary change | `references/evolution-fitness-functions-and-drift.md` |
| Planning coexistence and handing execution to migration engineering | `references/migration-and-coexistence.md` |
| Running architecture workshops, reviews, and decision facilitation | `references/architecture-practice-and-facilitation.md` |
| Checking provenance and the licensed-books transformation boundary | `references/source-index.md` |

Keep the ownership split explicit when loading DDIA: this skill owns the system-level architecture decision and its tradeoffs; `programming-principles` supplies distributed-data principles and mechanism detail. Route message-handler implementation to `backend-engineering`, API or event contracts to `api-design-and-evolution`, data-platform design to `data-architect`, and exercised recovery evidence to `resilience-and-recovery`.

## Completion

Stop when the architecture decision has an accountable owner, explicit alternatives and consequences, evidence or a named gap for each material claim, a verification path for prioritized characteristics, and specialist handoffs. Escalate rather than silently resolve missing authority, security, data ownership, or operational evidence.

--- END SOURCE 1 ---

--- BEGIN VERBATIM SOURCE 2: magnus919-agent-skills/backend-engineering ---

---
name: backend-engineering
description: Design and implement backend services and APIs — REST, gRPC, GraphQL,
  event-driven handlers, transaction boundaries, outbox/inbox delivery, migration
  coexistence, database access, integration, error handling, and service-level testing.
  Use for application/domain/infrastructure implementation decisions. Language and
  framework agnostic. Do not use for frontend, data engineering, platform provisioning,
  API contract ownership, service decomposition strategy, or cross-system migration
  planning.
license: MIT
metadata:
  tags: backend, api, services, server, database, integration, middleware, events, outbox,
    inbox, idempotency, coexistence, query-optimization, testing
  source_repo: https://github.com/magnus919/hermes-profiles
---

# Backend Engineering Methodology

Backend engineering is the craft of building the server-side systems that power applications — APIs, services, data access, integrations, and the runtime behavior that makes the architecture real. This methodology covers implementation after target design in `software-architecture` and before quality validation in `qa-methodology`; use `software-architecture-analysis` when the current system must first be reverse-engineered. It makes runtime boundaries, transaction behavior, message handling, and coexistence seams executable without taking ownership of the surrounding architecture or migration decision.

## The Backend Engineer's Domain

| You own | You don't own |
|---------|--------------|
| API implementation — REST/gRPC/GraphQL endpoints, request validation, response formatting, error handling, middleware chains | API contracts belong to `api-design-and-evolution`; service decomposition and target boundaries belong to `software-architecture` |
| Service logic — business rules, workflow orchestration, state management, background job processing | Deployment pipeline and infrastructure — that's `platform-engineering` |
| Event-driven implementation — domain-event publication, outbox/inbox coordination, handler idempotency, replay and failure paths | Event contract ownership and delivery semantics — that's the api-design-and-evolution |
| Migration seams inside a service — adapters, selectable paths, authority checks, and implementation handoffs | Cross-system migration lifecycle and cutover authority — that's the migration-engineering |
| Database access patterns — query design, connection management, transaction boundaries, N+1 detection, pagination | Data-platform and model strategy belong to `data-architect`; schema and pipeline operations belong to `data-engineering` |
| Integration code — third-party API clients, webhook handlers, message queue consumers/producers | Code review and quality gates — that's `qa-methodology` |
| Observability instrumentation at the service level — structured logging, metrics, tracing hooks | Observability infrastructure and reliability policy belong to `platform-engineering` and `site-reliability-engineering` |
| Service-level tests — unit tests for business logic, integration tests for API contracts | Test strategy and automation — that's `qa-methodology` |

## Reference Files

| Reference | When to load |
|-----------|-------------|
| `references/api-patterns.md` | Designing or implementing API endpoints — resource modeling, versioning, pagination, error response formats, request validation |
| `references/service-patterns.md` | Structuring service logic — clean/hexagonal/layered architecture, dependency injection, middleware composition, request lifecycle, background jobs |
| `references/event-driven-service-implementation.md` | Implementing event-driven application flows — domain events, unit of work, transactional outbox/inbox, idempotent handlers, retry/replay, observability, and failure handling |
| `references/migration-coexistence-patterns.md` | Keeping old and new implementations safe to run together — adapters, strangler handoffs, anti-corruption boundaries, dual paths, authority, and removal conditions |
| `references/database-testing.md` | Database access patterns (connection pooling, query optimization, N+1 detection, pagination strategies, transaction boundaries, read/write splitting, replication lag) and service-level testing (unit testing business logic, integration testing API contracts with test containers/WireMock, contract testing with Pact, test fixtures, CI integration) |
| `references/integration-patterns.md` | Integrating with external systems — retry with backoff, circuit breakers, idempotency keys, webhook verification, message queue consumers |
| `references/error-handling.md` | Handling errors systematically — classification (client vs server), structured responses, exception handling patterns, observability correlation |
| `references/source-index.md` | Provenance and ownership notes for this original synthesis; load when reviewing scope or source boundaries |

## Templates

| Template | When to Use |
|-----------|-------------|
| `templates/service-design-record.md` | Designing or restructuring a service — structure, API surface, data access, error handling, and testing plan in one reviewable record |
| `templates/error-handling-taxonomy.md` | Defining or auditing a service's error contract — classification, response format, retry/idempotency policy, and error-path tests |

## Scripts

| Script | When to Use |
|-----------|-------------|
| `scripts/n1-query-spotter.py` | Scanning Python source for potential N+1 query patterns (query-like calls inside loops); `--json` for CI-friendly output, exit 1 on findings |

## Related Skills

- [programming-principles](../programming-principles/SKILL.md) — DDD owns bounded contexts, aggregates, domain language, repositories, and domain-modeling guidance. This skill applies those decisions at implementation seams rather than duplicating that catalog.
- [api-design-and-evolution](../api-design-and-evolution/SKILL.md) — owns event/message contracts, delivery semantics, compatibility, and consumer-facing API decisions.
- [migration-engineering](../migration-engineering/SKILL.md) — owns cross-system migration classification, compatibility windows, reconciliation, cutover, recovery, deprecation, and cleanup. This skill only implements service-local coexistence seams.
- [software-architecture](../software-architecture/SKILL.md) — owns service decomposition and target-boundary strategy; backend engineering implements an approved boundary.
- [data-engineering](../data-engineering/SKILL.md) — owns schema migration and pipeline operations; application code may expose the repository or transaction interfaces those operations use.
- [secure-software-engineering](../secure-software-engineering/SKILL.md) — owns threat modeling, authorization, secrets, untrusted inputs, and security acceptance evidence.
- [release-engineering](../release-engineering/SKILL.md) — owns progressive delivery, artifact promotion, release gates, and rollback mechanics.
- [postgres](../postgres/SKILL.md) — diagnosing the PostgreSQL side of a database problem: configuration review, index and query-plan issues, vacuum/bloat, backups/PITR, replication and failover. Application-level data access patterns stay here; engine-level operations route there.
- [supabase](../supabase/SKILL.md) — building on Supabase: migrations, RLS, Auth, Storage, and Edge Functions. To measure an agent's Supabase task competence, use its [agent evals harness reference](../supabase/references/agent-evals.md).

## Core Principles

**The interface is the contract** — API boundaries are service-level contracts. Every endpoint signature, request schema, response format, and error code is a promise to consumers. Breaking changes are coordination problems, not version bumps.

**Business logic is the center of gravity** — Keep business rules isolated from framework concerns, transport protocols, and infrastructure details. A well-structured service can survive changes to its HTTP library, database driver, and deployment platform.

**Handle errors where they make sense** — Catch errors at the boundary where you have enough context to handle them meaningfully. Catch too early and you lose context. Catch too late and you can't recover.

**Design for failure, not just success** — Every external call can fail. Every database connection can drop. Every message can be duplicated. Idempotency, retry, and graceful degradation are not optimizations — they're requirements.

**Test at the right level** — Business logic gets unit tests. API contracts get integration tests. Service boundaries get contract tests. Each level catches a different class of failure.

## Implementation Decision Path

1. Name the bounded context, aggregate/invariant boundary, and source of truth. Use
   [programming-principles](../programming-principles/SKILL.md) for DDD choices rather
   than rebuilding its catalog here.
2. Put transport, broker, database, clock, and vendor concerns behind ports owned by
   the application or domain-facing code. Let infrastructure implement those ports.
3. For a command that changes durable state and emits a fact, load the aggregate,
   invoke domain behavior, and commit state plus outbox records in one unit of work.
   Do not hold that transaction open across network calls.
4. For an incoming message, validate the envelope at the edge, deduplicate within the
   consumer's authority, apply the handler, and acknowledge only after its durable
   effects commit. Load the event reference for replay and poison-message decisions.
5. If old and new paths coexist, record which path is authoritative for each operation,
   how outputs are compared, and what evidence permits handoff or removal. Load the
   migration reference for the implementation seam; route the migration lifecycle out.
6. Add unit tests for domain/application behavior and boundary integration tests for
   transaction, outbox, inbox, duplicate, retry, replay, and recovery behavior.

## Exit Criteria

This skill is complete when the implementation has explicit dependency direction,
transaction and authority boundaries, classified failure/retry behavior, observable
message or coexistence paths, focused tests for duplicate and failure cases, and clear
links to the neighboring owner for every out-of-scope decision.

--- END SOURCE 2 ---
