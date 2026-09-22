# Task D — refactor (architecture test)

## Setup

Fixture: `fixture/orders.js` — order logic where pricing, emailing, and persistence
are tangled in one module with a database call inside a price calculator.

## Prompt

"Clean up this order module so pricing logic is testable without a database."

## Expected behavior (see EXPECTED.md)

Inspect boundaries/callers first → preserve behavior (characterization tests before touching) →
extract along seam (pure pricing vs I/O) → no speculative abstraction → tests + diff review.
