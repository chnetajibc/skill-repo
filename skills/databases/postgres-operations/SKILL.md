---
name: postgres-operations
description: "Design and operate PostgreSQL: EXPLAIN-first schema, indexes, migrations, transactions, pooling, locking. Use when modeling data, writing queries, or debugging slow paths."
---

# postgres-operations

Ship schema + queries + indexes as one artifact; prove performance with EXPLAIN, not intuition.

## Activate when

- Designing tables, indexes, migrations, or queries.
- Debugging slow queries, deadlocks, or connection exhaustion.
- Reviewing any change touching the data layer.

## Do NOT activate for

- Non-relational access patterns better served by docs/KV (justify the substrate first).
- Secret/credential handling (see security/secrets-supply-chain).

## Procedure

1. Model: entities, ownership, lifecycle, invariants; separate domain, persistence, and DTO models.
2. Write the query first, then `EXPLAIN (ANALYZE, BUFFERS)` it; add the index the plan needs; re-run to confirm.
3. Migrations: expand → migrate → contract; separate schema from data migrations; every migration ships a down-migration or an explicit irreversible note.
4. Transactions: multi-table writes atomic and idempotent; keep them short; chunk background work into bounded transactions.
5. Concurrency: choose locking deliberately (`FOR UPDATE`, advisory locks, `SKIP LOCKED` for queues); test concurrent workers; size pools to the workload and set statement timeouts.
6. Deletion: soft delete when audit/restoration matters, else hard delete with documented cascades.
7. Verify: migration up+down on a scratch DB, EXPLAIN output saved, concurrent-worker test where locking is used.

## References

- `references/upstream-postgres/` (verbatim upstream).
- `references/upstream-database-audit/` (audit checklist, verbatim upstream).
- Related: `../../architecture/data-modeling/`, `../../backend/database-design/`.
