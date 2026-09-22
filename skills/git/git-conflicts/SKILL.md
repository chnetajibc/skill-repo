---
name: git-conflicts
description: "Resolve merge/rebase/cherry-pick conflicts: understand both sides, resolve minimally, verify with tests. No blind ours/theirs."
---

# git-conflicts

Conflicts are review decisions, not typing exercises: understand intent on both sides first.

## Activate when

- Merge, rebase, or cherry-pick stops with conflicts.

## Do NOT activate for

- Clean merges/rebases (git-workflow, git-rebase) or lost work (git-recovery).

## Procedure

1. Orient: `git status` for conflicted paths; `git log --merge --oneline` for both sides' intent.
2. Resolve per hunk: keep the intent of both where compatible; where incompatible, choose the side matching the PR's purpose and note why. Never blanket `ours`/`theirs` on code you haven't read.
3. Mark resolved (`git add`), continue (`--continue`), and re-run the affected tests before pushing.
4. Abort criteria: if the conflict surface exceeds understanding, `git merge --abort` / `git rebase --abort` and split the change smaller.
5. Verify: full diff re-read, tests green, no conflict markers (`grep -r '<<<<<<<'`).

## References (full upstream procedure, verbatim)

- `references/source-verbatim/` (history-rebuild).
