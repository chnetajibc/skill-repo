---
name: ui-verification
description: "Verify UI with rule-keyed Playwright probes: visual states, responsive breakpoints, a11y assertions. Use after building or changing user-facing UI."
---

# ui-verification

Every UI rule gets a probe; every probe maps to the rule it checks.

## Activate when

- New/changed screens, responsive work, or design-system updates need proof, not screenshots alone.

## Do NOT activate for

- Design decisions themselves (see design-systems, responsive-design).

## Procedure

1. Map each Oberved rule to a probe id (see `references/upstream-ui-verification/probes/`).
2. Cover states: loading/empty/error/success, hover/focus/disabled, plus 320→1920 widths and reduced-motion.
3. Assert accessibility: roles, labels, focus order, contrast (pair with `../accessibility/`).
4. Run headless in CI; store traces on failure; flake-quarantine with owner and expiry.
5. Verify: green run linked from the PR; failures reproduce locally via the trace.

## References

- `references/upstream-ui-verification/` (verbatim upstream incl. probes).
