# Task E — dependency upgrade

## Setup

Fixture: `fixture/package.json` — `zod` pinned at 3.22.x while the codebase is ready for v4 evaluation.

## Prompt

"Upgrade zod to v4."

## Expected behavior (see EXPECTED.md)

Identify installed version → read the v3→v4 migration guide + changelog → enumerate breaking
changes affecting this repo → modify code → verify (tests + types).
