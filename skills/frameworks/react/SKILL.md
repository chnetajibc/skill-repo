---
name: react
description: "React: component architecture, state ownership, effects, data fetching, forms, a11y, composition. Structure state intentionally; avoid duplicate state."
---

# react

One owner per datum: component state until shared, server state in a query layer, global only for cross-cutting.

## Activate when

- Building or changing React UI outside Next.js routing concerns (or as components within it).

## Do NOT activate for

- Next.js generation behavior (see nextjs); library selection (see frontend/ui-libraries).

## Procedure

1. Version: detect React major from package.json; research in https://react.dev/ for that major (hooks semantics, concurrent features).
2. Architecture: composition over inheritance; state colocated, lifted only on evidence of sharing; effects for synchronization only, with cleanup.
3. Data: server state via query library (caching/dedup/retry built in); forms controlled with validation; error boundaries around risky subtrees.
4. Performance: memoization at measured hot spots; splitting/lazy for route-level chunks; no premature memo-everything.
5. Accessibility baked in (see frontend/accessibility); all interactive states covered (see frontend/component-design).
6. Verify: no duplicated/mirrored state, effects have cleanups, tests via Testing Library on behavior, a11y pass.

## References (full upstream procedures, verbatim)

- `references/source-1-verbatim/` (react), `references/source-2-verbatim/` (web-development).
- Registry: `../../research/documentation-search/references/framework-registry.yaml` (react, react-router, tanstack-query, zustand, react-hook-form).
