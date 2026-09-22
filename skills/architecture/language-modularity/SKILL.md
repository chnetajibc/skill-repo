---
name: language-modularity
description: "Per-language module structure: Python, TypeScript, JavaScript, Go, Rust, Java. Boundaries, dependency direction, visibility, DI idioms, error/config/test boundaries, split signals. Inspect repo first; never force one architecture everywhere."
---

# language-modularity

Modularity is language-shaped: packages, crates, and modules have different visibility, cycles, and DI idioms. Inspect the repo and framework conventions first, then choose.

## Activate when

- Placing new code, splitting modules, fixing cycles/god-modules, or reviewing dependency direction.

## Do NOT activate for

- Framework layering specifics (see frameworks/*); generic SOLID theory (see solid).

## Universal rules

- Dependencies point one way; cycles are defects. Public surface minimal; internals private by default.
- Domain → application → infrastructure direction; config/errors cross boundaries via narrow types, not god objects.
- Split when: a module has multiple change reasons, unrelated tests cluster, or imports fan out across domains. Do NOT split on speculation — one more file is also a cost.

## Per language

### Python

- Packages (`__init__` re-exports the public API; underscore modules private); flat `src/` layout for libraries. Absolute imports; no `sys.path` hacks. Break cycles with dependency inversion (Protocols) or by moving shared types down a layer. Django/Flask/FastAPI overrides: framework app/registry layout wins — see frameworks/fastapi. Example: `services/` importing `routers/` back (bad: cycle, web leaking into logic) → move shared schema to `schemas/`, services depend on repos via Protocols.

### TypeScript

- Barrel files (`index.ts`) define the public surface; `internal/` or non-exported modules stay private. `paths` aliases for deep imports banned across boundaries. Break cycles via interfaces + constructor injection or event/ports. Monorepos: package boundaries enforced by the workspace tool, not discipline. Example: `utils/` god barrel re-exporting everything (bad: every change ripples) → scoped `@domain/*` packages with explicit entry points.

### JavaScript

- Same module rules as TS minus the type safety net: JSDoc + runtime validation at boundaries, ESLint `import/no-cycle` enforced in CI since nothing else catches cycles.

### Go

- Packages are the boundary: small, purpose-named (`httpapi`, `order`, not `util`/`common`); lowercase/unexported by default, exported surface deliberate. No cycles allowed by the compiler — treat a cycle error as a design signal: extract the shared contract into a lower package accepting interfaces, with constructors taking dependencies (no service locator). `internal/` for non-shared code; `cmd/` thin mains; `go.mod` per module. Example: `handlers` ↔ `store` cycle (bad) → `store` defines a narrow `Store` interface in the consumer package; constructor injects the implementation.

### Rust

- Crates + modules: `lib.rs`/`main.rs` roots; `pub(crate)` for intra-crate sharing, `pub` only for the crate contract; workspaces share one lockfile, features additive. Traits define seams; generics over `dyn` except real heterogeneity. Errors: `thiserror` (libraries) / `anyhow` (apps) at the crate edge — never `unwrap` across a boundary. Split crates when compile times, feature axes, or versioning diverge; NOT for namespacing alone.

### Java

- Packages + JPMS modules where used; package-private by default, `public` as a commitment. Spring: constructor-injected components in domain packages; `@Configuration` at edges; avoid component-scan sprawl with explicit base packages. Break cycles with interfaces in the lower package (Spring tolerates some cycles — treat tolerance as debt, not permission). Maven/Gradle multi-module only when deploy/version boundaries exist.

## Procedure

1. Map current modules, imports, and public surfaces before touching anything.
2. Name the boundary violation (cycle, god module, leaked internals, wrong-direction dep).
3. Apply the language's mechanism above; keep the framework's layout authoritative on conflicts.
4. Verify: cycle check green (compiler/lint), public surface diff reviewed, tests per boundary pass.

## References

- Related: `../modularity/`, `../solid/`, `../../core/repository-understanding/`, language skills in `../../languages/`, framework skills in `../../frameworks/`.
