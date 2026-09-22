---
name: production-readiness
description: "Production readiness: checklists, flags, staged rollouts, health checks, runbooks, monitoring, rollback. Ship only with evidence."
---

# production-readiness

Nothing ships without a checklist, a rollout plan, and a way back.

## Activate when

- Preparing any production deploy or judging go/no-go.

## Do NOT activate for

- CI mechanics (see tooling/ci-cd); release tagging (see git/git-release).

## Procedure

1. Checklist: health/readiness probes real, metrics/alarms on, logs structured, secrets externalized, limits/quotas set, runbook written.
2. Rollout: feature flags for behavior changes, staged percentages with error-budget watches, automatic halt criteria.
3. Rollback: previous artifact one step away; drill before needed; data migrations reversible or explicitly irreversible with owner sign-off.
4. Verify: pre-launch review signed, monitors quiet in staging, rollback path tested, on-call named.

## References (full upstream procedures, verbatim)

- `references/source-1-verbatim/` (production-readiness), `references/source-2-verbatim/` (shipping-and-launch).
