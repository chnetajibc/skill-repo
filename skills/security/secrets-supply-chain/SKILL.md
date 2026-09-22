---
name: secrets-supply-chain
description: "Detect leaked secrets and vulnerable dependencies with reachability analysis. Use when adding/updating dependencies, configuring CI, or auditing supply chain. Gates scanner use on tool availability."
---

# secrets-supply-chain

Secrets and supply-chain hygiene. Findings first, fixes by the code owner.

## Activate when

- Adding, updating, or auditing dependencies.
- Touching CI workflows, Dockerfiles, lockfiles, or release pipelines.
- Suspected leaked credential or dependency-confusion risk.

## Do NOT activate for

- General code-logic review (see secure-baseline).
- Runtime agent/MCP risk (see agent-security).

## Procedure

1. Secrets: search for hardcoded keys/tokens (patterns in `references/upstream-secrets-scan/`), then check git history for burned keys (rotation required, not just deletion). Never print a real secret in findings; use placeholders.
2. Dependencies: inventory direct + transitive deps, check advisories, then assess reachability — is the vulnerable function actually called? Unreachable + no exploit path = lower priority, still recorded.
3. CI: review workflows for pwn-request risk, expression injection (`${{ }}` with untrusted input), unpinned actions, over-scoped tokens, and cache poisoning (see `references/upstream-gha-security-review/`).
4. Report: package, version, advisory/CVE, reachability evidence, fix (pinned upgrade), and regression note.
5. Verify: re-run the applicable scanner (`npm audit`, `pip-audit`, `govulncheck`, `trivy`, `osv-scanner`) if installed; if no scanner is available, say so explicitly and rely on manual patterns only.

## References

- `references/upstream-secrets-scan/`, `references/upstream-sca-audit/` (OWASP, verbatim).
- `references/upstream-gha-security-review/` (Sentry, verbatim).
