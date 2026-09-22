---
name: refactoring
description: "Refactor preserving behavior: reduce complexity, honor Chestertons Fence. Verify with tests; no unrelated scope."
---

# refactoring

Same behavior, simpler code — proven by tests, scoped to the task.

## Activate when

- Complexity, duplication, or decay blocks change; opportunistic cleanup inside a touched area.

## Do NOT activate for

- Rewrites or architecture changes (plan those); formatting-only passes (see tooling/formatting).

## Procedure

1. Cover with tests first (characterization tests for legacy); understand why the code is shaped this way (Chesterton's Fence) before removing anything.
2. Small steps: extract, rename, deduplicate — running tests after each; one behavior-preserving move at a time.
3. Delete dead code outright (no "maybe later" branches); keep the diff scoped to the task.
4. Verify: full suite green, no behavior change (diff reviewed for semantic shifts), complexity reduced measurably.

## References (full upstream procedures, verbatim)

- `references/source-1-verbatim/` (code-simplification), `references/source-2-verbatim/` (awesome-code-cleanup).
