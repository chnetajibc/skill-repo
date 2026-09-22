---
name: cohesion-coupling
description: "Design for high cohesion low coupling, stable interfaces, localized change. Architecture emerges from requirements, not ceremony."
---

# cohesion-coupling

Change should land in one place. If a single requirement edits five modules, the boundaries are wrong.

## Activate when

- Scattering (one change, many files), ripple bugs, or modules that know too much about each other.

## Do NOT activate for

- Naming/style issues (see clean-code); language mechanics (see language-modularity).

## Inspection

Map imports/dependencies of the affected modules; list what each module knows about others (types, internals, lifecycle, config).

## Decision rules

- Cohesion: elements that change together live together; unrelated concepts sharing a module get split.
- Coupling direction: depend toward stability (domain ← application ← infrastructure); never toward volatility.
- Coupling strength: prefer data > stamp > control > common > content coupling. Shared mutable state and temporal ordering ("call init first") are the worst kinds — eliminate, don't document.
- Stable interfaces: expose narrow contracts; version them when external callers exist.

## Procedure

1. Measure: count modules touched by the last 3 similar changes; list cross-module knowledge.
2. Move code toward cohesion (colocate changers) and invert the worst coupling (shared state → parameters/messages; temporal → explicit lifecycle).
3. Narrow the exposed surface; add the boundary test (contract/consumer test).
4. Verify: replay a similar change — it now lands in fewer modules; no new cycles (compiler/lint).

## Failure modes

- Splitting modules without fixing shared state (same coupling, more files); depending on concretions for "simplicity"; cyclic packages.

## Escalation

Cross-service or data-layer coupling → distributed/systems, databases/fundamentals.

## References

- Related: `../modularity/`, `../solid/`, `../../core/repository-understanding/`.
