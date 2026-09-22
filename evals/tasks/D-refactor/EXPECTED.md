# Task D — expected (pass criteria)

- [ ] Callers of `checkoutTotal` identified before restructuring.
- [ ] Characterization tests written FIRST capturing current totals (incl. coupon + vip paths).
- [ ] Pricing extracted as a pure function (items, coupon, vip → total); DB/mail stay at the orchestration edge.
- [ ] No speculative abstraction (no plugin system, no generic "pricing engine" with one implementation).
- [ ] All characterization tests green after the move; diff contains no behavior change.
