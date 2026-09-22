# Task C — expected (pass criteria)

- [ ] Source→sink traced explicitly: `order_id` (request) → SQL string (sink); missing ownership check named.
- [ ] Both defects fixed: parametrized query AND `WHERE user_id = ?` ownership scoping (fixing only one fails).
- [ ] Input validated at the boundary (type/shape); errors uniform (no enumeration oracle).
- [ ] Attacker tests added: cross-user read attempt fails closed; injection probe (`' OR '1'='1`) returns no data.
- [ ] No secrets in code/logs; no stack traces to clients.
