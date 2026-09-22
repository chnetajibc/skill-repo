---
name: git-history-analysis
description: "Read history to understand and debug: blame, bisect, pickaxe (-S/-G), archaeology, patch export. Use to locate regressions and explain evolution."
---

# git-history-analysis

Let history answer: who changed this, when did it break, what did it look like before.

## Activate when

- Hunting a regression, explaining code evolution, attributing ownership, exporting patches.

## Do NOT activate for

- Changing history (git-rebase, git-recovery).

## Procedure

1. Blame with context (`git blame -L`, `-w` to ignore whitespace) to find the introducing commit, then read that commit fully before judging.
2. Bisect regressions: hermetic check script (0=good, 1=bad, 125=skip), `git bisect start <bad> <good>`, `run`; use `--first-parent` on merge-heavy history.
3. Pickaxe before bisect when cheap: `git log -S'symbol'` / `-G'regex'` for introduction points.
4. Export: `format-patch` for sharing, `cherry-pick -x` to preserve provenance.
5. Verify: cited commit hashes in findings; bisect result confirmed by testing the reported commit directly.

## References (full upstream procedure, verbatim)

- `references/source-verbatim/` (history-salvage).
