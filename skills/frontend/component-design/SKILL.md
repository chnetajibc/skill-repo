---
name: component-design
description: "Component design: boundaries, hover/focus/active/disabled/loading/success/error states, forms, navigation, hierarchy."
---

# component-design

Every component owns its states: default plus hover/focus/active/disabled/loading/success/error/empty.

## Activate when

- Creating or changing UI components, forms, navigation elements, or hierarchies.

## Do NOT activate for

- Library selection (see ui-libraries); system tokens (see design-systems).

## Procedure

1. Boundary: one responsibility, explicit props API, composition over configuration sprawl; reuse existing primitives first (see ui-libraries).
2. States: implement and visually verify every state (loading skeletons reserve space; errors guide recovery; empty states teach).
3. Forms: labeled inputs, inline validation, error announcements, sensible defaults, keyboard-complete flows.
4. Navigation/hierarchy: consistent patterns, focus management on route/step change, deep-linkable where applicable.
5. Verify: state matrix rendered, keyboard + screen-reader pass (see accessibility), ui-verification probes where available.

## References (full upstream procedures, verbatim)

- `references/source-1-verbatim/` (interaction-patterns-components), `references/source-2-verbatim/` (design-systems-frontend-architecture).
