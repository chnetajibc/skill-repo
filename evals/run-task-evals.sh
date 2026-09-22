#!/bin/bash
# run-task-evals.sh — structural harness for agent-task evaluations A-E.
# Verifies each task is runnable-gradable: TASK.md + EXPECTED.md + fixtures exist,
# referenced skills exist in the repo, and EXPECTED checklists are non-empty.
# (Live agent runs are executed by the harness operator, not here.)
EV="$(cd "$(dirname "$0")" && pwd)"
REPO="$(cd "$EV/.." && pwd)"
pass=0; fail=0
check() { if eval "$2" >/dev/null 2>&1; then echo "PASS: $1"; pass=$((pass+1)); else echo "FAIL: $1"; fail=$((fail+1)); fi; }
for t in A-doc-correctness B-frontend-change C-security-endpoint D-refactor E-dependency-upgrade; do
  D="$EV/tasks/$t"
  check "$t has TASK.md" "test -s $D/TASK.md"
  check "$t has EXPECTED.md" "test -s $D/EXPECTED.md"
  n=$(grep -c "^- \[ \]" "$D/EXPECTED.md")
  if [ "$n" -ge 4 ]; then echo "PASS: $t checklist depth ($n)"; pass=$((pass+1)); else echo "FAIL: $t checklist too thin ($n)"; fail=$((fail+1)); fi
done
check "A fixture (fastapi-auth)" "test -f $REPO/skills/research/documentation-search/tests/fixtures/fastapi-auth/pyproject.toml"
check "B fixture (grid.css)" "test -f $EV/tasks/B-frontend-change/fixture/grid.css"
check "C fixture (app.py)" "test -f $EV/tasks/C-security-endpoint/fixture/app.py"
check "D fixture (orders.js)" "test -f $EV/tasks/D-refactor/fixture/orders.js"
check "E fixture (package.json)" "test -f $EV/tasks/E-dependency-upgrade/fixture/package.json"
for s in research/documentation-search frontend/responsive-design frontend/accessibility backend/authorization backend/validation core/testing core/refactoring core/dependency-research security/secure-baseline; do
  check "skill referenced: $s" "test -f $REPO/skills/$s/SKILL.md"
done
echo "== $pass passed, $fail failed =="
[ "$fail" -eq 0 ]
