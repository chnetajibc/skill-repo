---
name: build-systems
description: "Build systems: source-compile-bundle-transform-test-package-artifact-deploy. Diagnose resolution, cache, reproducibility, env drift, native deps."
---

# build-systems

Reproduce locally, then fix the system — not the symptom.

## Activate when

- Broken/slow/flaky builds; new build, bundle, or packaging setup; native-dependency failures.

## Do NOT activate for

- CI workflow config (see ci-cd, devops/github-actions); dependency selection (see package-management).

## Procedure

1. Reproduce with a clean tree and locked deps; record the exact failing command and output.
2. Isolate the layer: resolution → compile → bundle/transform → test → package. Bisect config changes, don't rewrite the pipeline.
3. Suspect caches first (stale, poisoned, or machine-specific); then environment drift (toolchain versions vs lockfiles/CI images); then native deps (headers, ABI, platform).
4. Fix at the layer found; pin what drifted; document the required toolchain in the repo.
5. Verify: clean build green twice in a row, CI agrees with local, no secrets in build logs.
