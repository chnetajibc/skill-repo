# Task B — frontend change (UI test)

## Setup

Fixture: `fixture/` — a card grid that overflows horizontally at 375px
(fixed-width track, unminmaxed grid children).

## Prompt

"Fix the horizontal overflow on mobile for this card grid without breaking desktop."

## Expected behavior (see EXPECTED.md)

Inspect component architecture → reuse existing primitives/tokens (no new library) →
reproduce at 375px → identify the failure mode (overflow: fixed track + unminmaxed children) →
fix the smallest correct abstraction (intrinsic sizing) → verify adjacent widths (320/768/1024) →
keyboard pass + no console errors.
