---
name: responsive-design
description: "Responsive layout: content determines breakpoints; test 320/375/390/768/1024/1280/1440/1920; check overflow, wrapping, aspect ratios, safe areas, viewports."
---

# responsive-design

Content sets the breakpoints; devices only verify them.

## Activate when

- Laying out or auditing any UI across screen sizes.

## Do NOT activate for

- Component internals (see component-design); asset delivery (see media-assets).

## Procedure

1. Design mobile-first with intrinsic sizing (flex/grid, min/max constraints); add breakpoints where content breaks, not at device clichés.
2. Cover: text wrapping, overflow clipping, aspect ratios, tables→cards on narrow, touch target sizes, safe areas, keyboard-resized viewports.
3. Test matrix: 320 / 375 / 390 / 768 / 1024 / 1280 / 1440 / 1920+; check each for horizontal scroll, overlap, and truncated content.
4. Verify: no overflow at any width, readable without zoom on 320, screenshots or ui-verification probes attached.
