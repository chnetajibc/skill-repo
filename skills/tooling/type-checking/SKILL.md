---
name: type-checking
description: "Type checking: strict TS + typed Python; runtime validation at I/O boundaries; verify with build."
---

# type-checking

Type checking: strict TS + typed Python; runtime validation at I/O boundaries; verify with build.

## Sources fused without loss (verbatim)

- source-1 bjornjee-skills/skills/typescript-patterns in references/source-1-verbatim/
- source-2 bjornjee-skills/skills/python-patterns in references/source-2-verbatim/
- Both bodies inlined below in full. Stricter wins on overlap; if conflict prefer safer/security-first and note assumption.

--- BEGIN VERBATIM SOURCE 1: bjornjee-skills/skills/typescript-patterns ---

---
name: typescript-patterns
description: TypeScript/Node conventions — strict compiler settings, parse-don't-cast boundaries, Result-style domain errors, floating-promise hygiene, ESM. Use when writing or reviewing TypeScript.
---
# TypeScript

General TS/Node rules. React Native specifics live in `react-native.md`; both may load on the same file — this one governs the language, that one the platform.

## Compiler is the first reviewer
- `strict: true` plus `noUncheckedIndexedAccess` and `exactOptionalPropertyTypes` in every new tsconfig. Weakening compiler options to make code compile is fixing the smoke alarm with a hammer.
- No `any` — use `unknown` and narrow. No non-null `!` outside tests. No `as` on data you didn't construct.
- `@ts-ignore`/`@ts-expect-error` require a reason on the same line; prefer `@ts-expect-error` (it errors when stale).

## Trust boundaries
- Parse, don't cast: every external input (HTTP body, env, file, LLM output, queue message) goes through a schema (`zod` or equivalent) at the boundary. `JSON.parse(x) as Config` is a runtime bug with a type-checker alibi.
- Inside the boundary, trust the types — re-validating everywhere means the boundary isn't doing its job.

## Errors & control flow
- Throw only at boundaries; inside domain logic return discriminated unions / `Result` shapes so the compiler forces handling.
- Discriminated unions get exhaustiveness checks: a `switch` ends with a `never`-typed default (`assertNever(x)`), so adding a variant breaks the build, not production.
- `??` vs `||`: use `||` only when `0`/`''`/`false` are genuinely invalid values. Defaulting with `||` on numeric or string config is a classic silent bug.

## Async
- No floating promises: every promise is awaited, returned, or explicitly `void`-ed with a comment. Enable `@typescript-eslint/no-floating-promises`.
- Independent awaits go through `Promise.all` — sequential awaiting of unrelated calls is silent 2-10x latency.
- Async functions that can reject are handled where the context to handle them exists — an `unhandledRejection` crash in Node is a design failure, not bad luck.

## Modules & structure
- Use ESM for new packages; preserve an existing package’s module system unless a migration is in scope. Node built-ins imported with the `node:` prefix.
- Barrel files (`index.ts` re-export hubs) are import-cycle factories and tree-shaking obstacles — import from the concrete module.
- No mutable module-level state; module scope is for constants and pure definitions. A mutable module singleton is a hidden global with import-order semantics.

## Runtime & deps
- Stdlib before deps: use built-in APIs available in the project's declared supported engine (for example, `node:test`, `fetch`, `node --env-file`, or `node:util` `parseArgs`) before adding a package.
- Declare the supported Node engine and any required built-in APIs. Commit the package manager's lockfile, and use that project's reproducible, immutable CI install command rather than a general dependency update.

## Tests
- Use `node:test` or the established runner. Unit tests isolate external services; hermetic integration tests may exercise local processes, sockets and temporary files. Verify boundary bugs at their original surface.

--- END SOURCE 1 ---

--- BEGIN VERBATIM SOURCE 2: bjornjee-skills/skills/python-patterns ---

---
name: python-patterns
description: Python style, typing, side-effect, error-handling, async, and tooling conventions (ruff, uv, pytest, pydantic-settings). Use when writing or reviewing Python code.
---
# Python

Loads when editing Python. Generic + my preferences flattened. Project-specific
rules belong in each project's CLAUDE.md. Strict review enforcement lives in
the `python-reviewer-strict` agent.

## Style & types
- PEP 8. Type annotations on every public function signature.
- Use union syntax supported by the project's Python target (`X | None` where available; otherwise `Optional[X]`). No untyped `**kwargs` in public APIs.
- Use stdlib dataclasses for internal records; use Pydantic at boundaries when its validation is needed and already available.
- `Protocol` for interfaces (duck typing).
- Use validation and configuration APIs consistently for the project's installed Pydantic version; do not migrate solely to copy newer syntax.
- Top-level imports only. No nested/inline imports inside functions or methods. The only exception is breaking a genuine circular import — and even then, fix the cycle instead.

## Side effects & boundaries
- Inject HTTP clients, DB sessions, time, randomness, env vars as parameters or attributes. Never reach for them inside business logic.
- Context managers for resources. Generators for lazy evaluation.
- `logging` for application diagnostics; `print()` is appropriate for a CLI’s intentional user output.
- Centralize config at the boundary. Use existing settings tooling; stdlib environment parsing is sufficient for small scripts, and `pydantic-settings` is appropriate when structured validation warrants it. Never hardcode secrets.

## Errors
- No silent exceptions. No `except:`, no `except Exception: pass`, no `except Exception: return None`.
- Re-raise with context: `raise X from err`. Or narrow the exception type. Or comment why swallowing is correct.

## No fallbacks
- One implementation per feature. `try: import X; except ImportError: from .fallback import X` only at a documented optional-dependency boundary.
- No mutable default arguments. `def f(x=[])` and `def f(x={})` are bugs.

## Async
- No blocking calls inside `async def` (`time.sleep`, `requests.get`, sync DB drivers, sync file I/O).
- Store references to `asyncio.create_task(...)` — bare task spawns can be GC'd mid-flight.

## Concurrency model
- Use asyncio for I/O-bound work and thread pools to isolate synchronous libraries when needed. GIL-bound Python code does not gain CPU parallelism from threads; consider processes or native code that releases the GIL. On a free-threaded runtime, verify dependency support and measure thread scaling.

## Tooling
- Use the existing formatter, lint/type checks, and security checks. Do not add tooling just to satisfy a preference.
- For new packaged projects, `uv` is a useful default; preserve existing package managers/build backends unless migration is requested.
- Use the established layout; a small script need not become a package.
- Centralize settings parsing and inject the result; avoid scattered environment reads in business logic.
- Use the established test runner; add plugins only when required. Unit tests isolate external services and time. Hermetic integration tests may use local processes, sockets, temporary files, and disposable databases; real-boundary regressions require evidence at the failing surface. Use the established runner and fixtures.

--- END SOURCE 2 ---
