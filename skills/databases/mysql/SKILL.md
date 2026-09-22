---
name: mysql
description: "MySQL/InnoDB operations: schema, indexing, transactions, locking, query optimization, backups, replication. Use for MySQL work; research version docs before relying on behavior."
---

# mysql

InnoDB reality: mind the isolation default, the locking reads, and the optimizer's mood.

## Activate when

- Designing MySQL schemas, indexes, queries, or operating MySQL (backups, replication, pooling).

## Do NOT activate for

- Postgres specifics (see postgres-operations); substrate choice (see fundamentals).

## Procedure

1. Version: detect server version first; research in https://dev.mysql.com/doc/ for THAT version (isolation defaults, DDL atomicity limits, and JSON behavior are version-gated).
2. Schema/indexes: InnoDB, explicit charsets/collations, indexes matched to EXPLAIN output; composite indexes ordered by selectivity and sort needs.
3. Transactions: keep short; `SELECT ... FOR UPDATE` / `LOCK IN SHARE MODE` only where needed; understand next-key locking before debugging deadlocks.
4. Queries: EXPLAIN before and after; watch filesorts/temporary tables; paginate with keysets on large mutable sets.
5. Operations: logical + physical backups with restore drills, replica lag monitoring, pool sizing, slow-query log review.
6. Verify: EXPLAIN evidence, migration up+down, restore drill, deadlock/concurrency test where locking is used.

## References
- `../fundamentals/`, `../database-security/`.
- Registry: `../../research/documentation-search/references/framework-registry.yaml` (mysql).
