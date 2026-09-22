---
name: concurrency
description: "Concurrency: async vs sync, pools, timeouts, retries, circuit breakers, bounded concurrency. No unbounded fan-out."
---

# concurrency

Concurrency: async vs sync, pools, timeouts, retries, circuit breakers, bounded concurrency. No unbounded fan-out.

## Sources fused without loss (verbatim)

- source-1 magnus919-agent-skills/backend-engineering in references/source-1-verbatim/
- source-2 bjornjee-skills/skills/golang-patterns in references/source-2-verbatim/
- Both bodies inlined below in full. Stricter wins on overlap; if conflict prefer safer/security-first and note assumption.

--- BEGIN VERBATIM SOURCE 1: magnus919-agent-skills/backend-engineering ---

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

--- END SOURCE 1 ---

--- BEGIN VERBATIM SOURCE 2: bjornjee-skills/skills/golang-patterns ---

---
name: golang-patterns
description: Use when writing or reviewing Go concurrency, context handling, module boundaries, or reliability code — errgroup, worker pools, goroutine-leak avoidance, retry and circuit-breaking. Falsifiable rules, not idiom lists.
---
# Go Patterns

Read [Go basics](references/basics.md) for the shared language conventions. This skill adds bounded concurrency, context, and reliability decisions.

Use the language semantics selected by the project's `go.mod` and APIs supported by its toolchain and dependencies. Check those targets before adapting examples; do not upgrade them merely to copy a pattern.

## Concurrency

### errgroup over hand-rolled fan-in
- Multiple goroutines that can each fail ⇒ `errgroup.WithContext`. First error cancels the shared context; `g.Wait()` returns it. Re-implementing this with an error channel + `WaitGroup` is a re-implementation of stdlib-adjacent code — BLOCK in review.
- Bound it with `g.SetLimit(n)`. Unbounded fan-out over unbounded input (rows, files, URLs) exhausts FDs and memory — that is a bug, not a tuning knob.
- Write to disjoint slots (`results[i]`), never `append`, from inside `g.Go`. Shared `append` races.

```go
g, ctx := errgroup.WithContext(ctx)
g.SetLimit(8)
results := make([]Result, len(urls))
for i, url := range urls {
    g.Go(func() error {
        r, err := fetch(ctx, url) // ctx cancels the instant any sibling errors
        if err != nil {
            return fmt.Errorf("fetch %s: %w", url, err)
        }
        results[i] = r
        return nil
    })
}
if err := g.Wait(); err != nil {
    return nil, err
}
```
Check the module's loop-variable semantics before capturing range variables in closures. If iterations share variables, bind `i, url := i, url` inside the loop; omit that binding when each iteration already owns its variables.

### Goroutine leaks: the send that never returns
- A goroutine sending on a channel leaks the instant its receiver disappears (caller returned, ctx cancelled). Every send in a spawned goroutine is either buffered-for-what-you-send or wrapped in `select { case ch <- v: case <-ctx.Done(): }`.
- Buffer size = number of values you may send when nobody is guaranteed to be listening. A one-shot result channel is `make(chan T, 1)`.

```go
ch := make(chan Result, 1) // buffered: goroutine sends and exits even if caller gave up
go func() {
    r, err := work()
    if err != nil {
        return
    }
    select {
    case ch <- r:
    case <-ctx.Done():
    }
}()
```

### Bounded worker pool — teardown order is load-bearing
Normal completion: producers close `jobs` → workers drain → `wg.Wait()` → close `results`. Cancellation interrupts idle receives and output sends; `process(ctx, job)` must honor the context. The caller validates a positive worker count and owns producer shutdown. Closing `results` before `wg.Wait()` panics a still-running worker on send; skipping the `jobs` close deadlocks the drain.

```go
func run(ctx context.Context, jobs <-chan Job, n int) <-chan Result {
    if n < 1 {
        panic("worker count must be positive") // caller configuration invariant
    }
    results := make(chan Result)
    var wg sync.WaitGroup
    wg.Add(n)
    for worker := 0; worker < n; worker++ {
        go func() {
            defer wg.Done()
            for {
                var j Job
                select {
                case <-ctx.Done():
                    return
                case job, open := <-jobs:
                    if !open { return }
                    j = job
                }
                if ctx.Err() != nil { return }
                result := process(ctx, j) // processing must honor cancellation too
                select {
                case results <- result:
                case <-ctx.Done():
                    return
                }
            }
        }()
    }
    go func() { wg.Wait(); close(results) }() // close AFTER every worker has exited
    return results
}
```
When NOT to pool: CPU-bound work over a small, finite slice is simpler and equivalent as `errgroup` + `SetLimit(runtime.GOMAXPROCS(0))`. A channel-fed pool earns its complexity only for a long-lived stream you can't hold in memory.

## Context discipline
- Deadline vs timeout: `WithDeadline` when the budget is absolute (a request must finish by a wall-clock T shared across hops); `WithTimeout` when it's relative to now. A timeout derived from the parent cannot extend the parent’s deadline. Deriving from `context.Background()` instead would lose that cancellation/budget; propagate the parent. See [context.WithDeadline](https://pkg.go.dev/context#WithDeadline).
- Check `ctx.Err() != nil` before starting any expensive or irreversible unit (a batch, a remote call) — the caller may have cancelled while you sat in a queue. Cheap check, skips a doomed call.
- Never store `context.Context` in a struct field. First argument, always. Exception: request-scoped types whose lifetime *is* the request (`*http.Request`, a per-RPC handler object) may hold it — say so in a comment so the reviewer doesn't flag it.
- Context values only for request-scoped, cross-cutting data that rides the whole call tree: trace/correlation IDs, auth principal. Never for optional parameters (those are function args). The key must be an unexported package-local type (`type ctxKey int`) so no other package can collide with or read it.

## Module boundaries
- `internal/` by default. It's compiler-enforced privacy; anything not deliberately public lives there.
- `pkg/` is a directory name, not a blessing. Moving code under `pkg/` does not make it a supported API — it only removes the `internal/` guard rail. Export only what you will maintain.
- One module per repo until release cadence *actually* diverges. A second `go.mod` is justified only when a component must be versioned and released independently — otherwise it's `go.work` friction and dependency skew for no gain.
- Breaking change ⇒ new major ⇒ `/v2` module-path suffix, and *every* importer rewrites their import path. That import-path tax is real: prefer additive change (new optional field, new function) and reserve majors for genuine incompatibility.

## Reliability
- Retry only idempotent operations, with exponential backoff **and jitter** — uncoordinated retries thundering-herd a recovering dependency. Put retry behind an interface so tests inject a fake clock; a retry loop with a real `time.Sleep` is untestable and violates the I/O-behind-interfaces rule.
- More than one flaky dependency ⇒ adopt a library (`failsafe-go`) for retry + circuit-breaker + timeout composition. Hand-rolled breakers get the half-open state wrong. Battle-tested over hand-rolled.
- A breaker's job is to fail fast while a dependency is down so you stop queuing doomed work — pair it with the `ctx.Err()` pre-check above so cancelled callers never enter the breaker at all.

## When NOT to reach for concurrency
Sequential is the default. Add goroutines only when there is real I/O overlap or independent CPU work to win, and only after a profile says the serial path costs you. Concurrency added "to be fast" on a sub-millisecond path buys race conditions and a harder-to-read function for no measured gain.

--- END SOURCE 2 ---
