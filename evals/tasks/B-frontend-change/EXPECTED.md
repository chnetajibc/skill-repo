# Task B — expected (pass criteria)

- [ ] Reproduced at 375px (overflow identified, not guessed).
- [ ] Failure mode named correctly: fixed 300px tracks + unminmaxed children (overflow, not wrapping/sizing).
- [ ] Fix is the smallest correct abstraction (e.g. `repeat(auto-fit, minmax(min(100%, 280px), 1fr))`, fluid images) — no device-specific hack, no new dependency.
- [ ] Existing tokens/primitives reused; no competing design system introduced.
- [ ] Verified at 320/375/768/1024+: no horizontal scroll, no overlap.
- [ ] Keyboard navigable; images keep alt text; no console errors.
