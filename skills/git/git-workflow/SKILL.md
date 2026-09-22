---
name: git-workflow
description: "Everyday Git workflow: branch, commit, push, PR. Trunk-based default, atomic commits, force-with-lease only. Use for routine version-control work."
---

# git-workflow

Keep main deployable; make small, reviewable, revertable history.

## Activate when

- Branching, committing, pushing, opening PRs, syncing with remote.

## Do NOT activate for

- Conflict surgery (git-conflicts), lost-work recovery (git-recovery), history analysis (git-history-analysis), releases (git-release).

## Procedure

1. Diagnose state first: `git status`, `git log --oneline -5`, ahead/behind vs upstream. Never act on a dirty or diverged tree blindly.
2. Branch: short-lived `feature/*` off main (GitHub Flow default); trunk-based only with CI + flags; long-lived branches only for parallel supported versions.
3. Commit: atomic, conventional (`feat:`, `fix:`, `refactor:`…), one logical change each; split messy trees before committing.
4. Push: `--force-with-lease` on your own pushed branch after rebase; never `--force` on shared history.
5. Tool gates: IF `gh` exists, use it for PR create/status; ELSE use the hosting UI. IF worktrees fit parallel streams, one branch per worktree.
6. Verify: `git status` clean-or-intentional, CI green, PR linked to issue.

## References (full upstream procedures, verbatim)

- `references/source-1-verbatim/` (bjornjee git-workflow), `references/source-2-verbatim/` (addyosmani git-workflow-and-versioning).
