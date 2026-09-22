---
name: go
description: "Go: small consumer-defined interfaces, composition, explicit errors/context, goroutines/channels/mutexes, modules/workspaces. Prefer simple code over enterprise abstraction."
---

# go

Go: small consumer-defined interfaces, composition, explicit errors/context, goroutines/channels/mutexes, modules/workspaces. Prefer simple code over enterprise abstraction.

## Official documentation research

Detect the Go release from go.mod first; research stdlib behavior, modules, and concurrency primitives in https://go.dev/doc/ and https://pkg.go.dev/std for that release. Registry: `../../research/documentation-search/references/framework-registry.yaml` (go). Runtime procedure: `../../research/documentation-search/`.

## Sources fused without loss (verbatim)

- source-1 bjornjee-skills/skills/golang-patterns in references/source-1-verbatim/
- source-2 bjornjee-skills/skills/golang-testing in references/source-2-verbatim/
- Both bodies inlined below in full. Stricter wins on overlap; if conflict prefer safer/security-first and note assumption.

--- BEGIN VERBATIM SOURCE 1: bjornjee-skills/skills/golang-patterns ---

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

--- END SOURCE 1 ---

--- BEGIN VERBATIM SOURCE 2: bjornjee-skills/skills/golang-testing ---

---
name: golang-testing
description: Use when writing or reviewing Go tests — table-driven suites, golden files, fuzzing, benchmarks, race-exposing tests, testcontainers integration, or t.Parallel hazards. Falsifiable rules, not a tour of the testing package.
---
# Go Testing

Read [Go basics](../golang-patterns/references/basics.md) for shared conventions. This skill covers testing decisions beyond the root verification profile.

## Table-driven: the non-obvious bits
The rule already mandates table + `t.Run`. Two things it doesn't:
- On an error case, set a `wantErr` sentinel and `return` early. Asserting on the result struct after an unexpected error produces a second, misleading failure that buries the real one.
- Name cases so a failure prints the scenario, not an index — `t.Run(tt.name, …)` gives you `TestX/empty_input` in output and as a `-run` filter.

## t.Parallel() hazards
`t.Parallel()` is where "passes locally, flakes in CI" is born.
- **Teardown timing:** a parent’s ordinary `defer` runs when its body returns, before parallel children finish. Parent `t.Cleanup` runs after the test and all subtests complete, so it can safely own their shared fixture. Check the module's loop-variable semantics before capturing table entries in parallel subtests. See [testing.T.Cleanup](https://pkg.go.dev/testing#T.Cleanup).
- **Env is process-global:** `t.Setenv` panics if the test also calls `t.Parallel`, precisely because one test's mutation would leak into concurrent siblings. A parallel test cannot use `t.Setenv` — inject config instead.
- **Shared state / fixtures:** two parallel tests mutating the same map, temp table, or singleton race even when `-race` happens to pass on one run. Give each its own namespace: `t.TempDir()`, a UUID-suffixed table, a fresh struct.

## TestMain for expensive shared setup
One container or migration for the whole package, not per-test. Here `postgresImage` is test configuration: choose an image matching the database features and release used by the target environment, and pin it for reproducibility.
```go
func TestMain(m *testing.M) {
    ctx := context.Background()
    pg, err := postgres.Run(ctx, postgresImage) // testcontainers-go
    if err != nil {
        log.Fatalf("start postgres: %v", err)
    }
    testDSN = pg.MustConnectionString(ctx)
    code := m.Run()
    _ = pg.Terminate(ctx) // explicit: TestMain owns lifetime, not t.Cleanup
    os.Exit(code)
}
```
`m.Run()`'s exit code must reach `os.Exit`, and teardown goes *between* them — a `defer` after `os.Exit` never runs, so terminate explicitly.

## Unit vs integration vs neither — the decision
- **Neither:** pure function, no collaborators ⇒ table-driven unit test, done. Don't mock what you can call directly.
- **Unit with a fake:** collaborator is behind an interface (per the I/O rule) ⇒ hand-written fake with func fields. Reach for a mocking framework only when the interface is wide and call-order matters.
- **Integration:** the thing under test *is* the DB query, queue wiring, or SQL migration. Faking the DB tests your fake, not your SQL. Use a real Postgres/Redis via `testcontainers-go`, gated behind a build tag.

```go
//go:build integration

package store_test
```
Split the lanes: `go test ./...` (fast, every push) vs `go test -tags=integration ./...` (own CI lane, needs Docker). Never gate the fast lane on Docker being present.

The fake covers the 80% case with no framework:
```go
type fakeUsers struct{ get func(string) (*User, error) }

func (f fakeUsers) Get(id string) (*User, error) { return f.get(id) }
```

## Race-exposing tests
`-race` only reports races it actually *observes* at runtime — a test that never interleaves the goroutines proves nothing. Force the interleaving with a start gate:
```go
func TestCounter_Concurrent(t *testing.T) {
    var c Counter
    start := make(chan struct{}) // gate: line everyone up before releasing
    var wg sync.WaitGroup
    for worker := 0; worker < 100; worker++ {
        wg.Add(1)
        go func() {
            defer wg.Done()
            <-start   // block until the gate opens
            c.Inc()   // all 100 hit this near-simultaneously
        }()
    }
    close(start)      // release the herd
    wg.Wait()
    if c.Value() != 100 {
        t.Errorf("got %d, want 100", c.Value())
    }
}
```
Reading race output: two stacks — one `Read at` / one `Previous write at` (or write/write) — each naming the goroutine that did it *and the line where that goroutine was created*. Trace the "created at" lines to identify the two owners touching the address; the fix is almost always a lock or a single-owner redesign, per the rule's "exactly one is authoritative."

## Golden files
For large or structured output (rendered templates, formatted docs, serialized trees) where an inline `want` string is unreadable.
```go
var update = flag.Bool("update", false, "update .golden files")

golden := filepath.Join("testdata", tt.name+".golden")
if *update {
    if err := os.WriteFile(golden, got, 0o644); err != nil {
        t.Fatal(err)
    }
}
want, err := os.ReadFile(golden)
if err != nil {
    t.Fatal(err)
}
if !bytes.Equal(got, want) {
    t.Errorf("golden mismatch (run -update to accept):\n got: %s\nwant: %s", got, want)
}
```
Review the diff before committing an `-update` — a golden blindly regenerated locks in the very bug it was meant to catch.

## Fuzzing
For parsers, decoders, and any `[]byte`/`string` boundary. Assert *properties*, not specific outputs — the fuzzer feeds inputs you didn't imagine.
```go
func FuzzRoundTrip(f *testing.F) {
    f.Add([]byte(`{"a":1}`)) // seed; discovered crashers auto-save to testdata/fuzz/
    f.Fuzz(func(t *testing.T, b []byte) {
        v, err := Decode(b)
        if err != nil {
            return // rejecting malformed input is fine
        }
        out, err := Encode(v)
        if err != nil {
            t.Fatalf("re-encode after successful decode: %v", err)
        }
        if v2, _ := Decode(out); !reflect.DeepEqual(v, v2) {
            t.Errorf("round-trip changed the value")
        }
    })
}
```
Good properties: round-trip identity, never-panics, output-always-reparses, invariant-preserved. A crasher the fuzzer finds is saved under `testdata/fuzz/` — commit it, and it becomes a permanent regression case in the normal `go test` run.

## Benchmarks
Use `b.Loop()` when supported by the project's toolchain. Otherwise follow its established `b.N` benchmark pattern, excluding setup from timing and retaining results so the compiler cannot eliminate the work.

```go
func BenchmarkEncode(b *testing.B) {
    v := build()      // setup before b.Loop() is auto-excluded from timing
    b.ReportAllocs()  // allocs/op is usually the real signal, not ns/op
    for b.Loop() {    // excludes setup and protects calls in the loop from elimination
        _ = Encode(v)
    }
}
```
`ReportAllocs` is the easy-to-forget one that changes what you learn. Compare runs with `benchstat` over ≥6 counts — a single run's ns/op is noise. Optimize only what a benchmark or profile named, per the patterns "when NOT to reach for concurrency" rule.

## httptest
Handler tests need no socket: `httptest.NewRecorder` + `httptest.NewRequest`. For an outbound *client*, `httptest.NewServer` gives a real URL backed by a stub handler.
```go
req := httptest.NewRequest(http.MethodGet, "/users/123", nil)
rec := httptest.NewRecorder()
handler.ServeHTTP(rec, req)
if rec.Code != http.StatusOK {
    t.Fatalf("got %d, want 200", rec.Code)
}
```

--- END SOURCE 2 ---
