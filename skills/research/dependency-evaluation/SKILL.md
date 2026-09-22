---
name: dependency-evaluation
description: "Dependency evaluation: CVE reachability, license risk, maintenance, supply chain. Audit before adding/updating."
---

# dependency-evaluation

Audit before you `add`: reachability, license, maintenance, supply chain — in that order of blocking power.

## Activate when

- Adding, updating, or reviewing any third-party dependency.

## Do NOT activate for

- Version-pinned API lookups (see documentation-search); first-party code.

## Inspection

Inventory the candidate: version, advisory history, license, release cadence, maintainer bus factor, transitive footprint, and how it will be used (which vulnerable functions are actually reachable?).

## Decision rules

- Reachability decides severity: vulnerable code never called = recorded but deprioritized; reachable sink = blocker.
- License must be compatible with distribution plans (copyleft review before merge, not after).
- Maintenance bar: recent releases, responsive security handling, no single-maintainer abandonment risk for critical paths.
- Supply chain: provenance (signed tags/SLSA where available), no dependency-confusion vectors, lockfile committed.

## Procedure

1. Score the candidate on the four axes above; record the verdict with evidence.
2. Install pinned with minimal scope; add the removal path note.
3. Re-audit on updates: changelog + advisory diff, breaking-change review, test suite green.
4. Verify: `audit` clean or findings triaged with owners, license recorded, lockfile diff reviewed.

## Failure modes

- Version bump without changelog read; transitive dep smuggling (audited direct, ignored transitive); license discovered at release time; unpinned ranges drifting in CI.

## Escalation

Live CVE triage → security/secrets-supply-chain; upgrade mechanics → core/dependency-research.

## References

- Related: `../../core/dependency-research/`, `../../security/secrets-supply-chain/`, `../library-selection/`.
