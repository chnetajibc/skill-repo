---
name: accessibility
description: "Accessibility WCAG 2.1 AA: keyboard, screen reader, semantics, focus, contrast, reduced motion, touch targets, labeled forms, error announcements."
---

# accessibility

Accessible by construction, verified by testing — not audited in at the end.

## Activate when

- Any UI work: new screens, components, forms, navigation, media, animations.

## Do NOT activate for

- Non-UI code (nothing here applies).

## Procedure

1. Semantics: native elements and landmarks first; ARIA only to fill genuine gaps; headings in order; skip links on content pages.
2. Keyboard: all functionality reachable and operable, visible focus, logical order, focus trapped/restored in dialogs, no keyboard traps.
3. Screen reader: names/roles/values on controls, live regions for async updates, error announcements tied to fields, images alted (decorative empty).
4. Visual: contrast AA, 44px-class touch targets, focus visible, `prefers-reduced-motion` honored, content usable at 200% zoom.
5. Forms: programmatic labels, grouped related controls, inline errors with suggestions.
6. Verify: keyboard-only walkthrough, screen-reader pass on changed flows, automated checks (axe/lighthouse) green, findings tracked as defects not suggestions.
