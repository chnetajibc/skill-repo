---
name: ui-architecture
description: "UI architecture: primitive-component-composite-feature-page, composition over inheritance, state ownership, derived state. Avoid generic AI UI."
---

# ui-architecture

Compose upward: primitives → components → composites → features → pages. State lives with its owner; everything else derives.

## Activate when

- Structuring UI code, placing state, or reviewing component boundaries.

## Do NOT activate for

- Visual system decisions (see design-systems); global data flows (see state-management).

## Procedure

1. Layer strictly: primitives (unstyled/system-based) → components → composites → features → pages/routes. Pages hold routing only.
2. State: single owner per datum; derived data computed, never duplicated; server state via query layer, client state local until shared.
3. Composition over inheritance/props-sprawl;stable component APIs with explicit contracts.
4. Verify: no duplicated state, no prop-drilling chains, route files thin, ownership diagram reviewable.

## References (full upstream procedures, verbatim)

- `references/source-1-verbatim/` (frontend-ui-engineering), `references/source-2-verbatim/` (design-systems-frontend-architecture).
