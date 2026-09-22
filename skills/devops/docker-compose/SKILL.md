---
name: docker-compose
description: "Define local and small-prod stacks with Docker Compose: minimal images, non-root, pinned digests, secret hygiene. Use when containerizing services or dependencies."
---

# docker-compose

One command to a working stack; production habits from the first file.

## Activate when

- Adding Dockerfiles, compose files, or local Postgres/Redis/queue dependencies.

## Do NOT activate for

- Kubernetes or cloud-managed deploys (see cloud/aws-foundations).

## Procedure

1. Images: minimal base, pinned digest, non-root user, no secrets baked in; `.dockerignore` present.
2. Compose: versioned services, healthchecks, named volumes, explicit networks; env from files/vault, never committed.
3. Dependencies: Postgres/Redis as versioned services with seed + migrate steps documented.
4. Security: apply the container checklist from `references/upstream-docker-compose/` and `../../tooling/containers/`.
5. Verify: cold `up --build`, healthchecks green, app connects, teardown leaves no stray volumes.

## References

- `references/upstream-docker-compose/` (verbatim upstream).
- Related: `../../tooling/containers/`, `../../databases/postgres-operations/`.
