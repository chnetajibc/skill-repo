#!/bin/bash
# run-doc-behavior-tests.sh — TEST 1..8 for documentation-search runtime behavior.
# Usage: bash scripts/run-doc-behavior-tests.sh
# Tests detection + registry + fallback/citation wiring (not live web research).
SKILL="$(cd "$(dirname "$0")/.." && pwd)"
FIX="$SKILL/tests/fixtures"
REG="$SKILL/references/framework-registry.yaml"
DET="$SKILL/scripts/detect-versions.sh"
pass=0; fail=0
check() { # check <name> <command...>
  local name="$1"; shift
  if "$@" >/dev/null 2>&1; then echo "PASS: $name"; pass=$((pass+1)); else echo "FAIL: $name"; fail=$((fail+1)); fi
}
expect() { # expect <name> <needle> <haystack-cmd...>
  local name="$1" needle="$2"; shift 2
  if "$@" | grep -qF "$needle"; then echo "PASS: $name"; pass=$((pass+1)); else echo "FAIL: $name (missing '$needle')"; fail=$((fail+1)); fi
}
echo "== TEST 1 fastapi: detect version =="
expect "T1 fastapi version" "fastapi|0.115.6|pyproject.toml" bash "$DET" "$FIX/fastapi-auth"
expect "T1 python floor" "python|3.12" bash "$DET" "$FIX/fastapi-auth"
expect "T1 registry fastapi" "https://fastapi.tiangolo.com/" grep -F "https://fastapi.tiangolo.com/" "$REG"
echo "== TEST 2 nextjs: detect version, avoid outdated API =="
expect "T2 next version" "next|14.2.5|package.json" bash "$DET" "$FIX/nextjs-versioned"
expect "T2 registry nextjs" "https://nextjs.org/docs" grep -F "https://nextjs.org/docs" "$REG"
echo "== TEST 3 spring: detect version =="
expect "T3 spring-boot version" "spring-boot|3.2.5|pom.xml" bash "$DET" "$FIX/spring-versioned"
expect "T3 registry spring-boot" "https://docs.spring.io/spring-boot/" grep -F "https://docs.spring.io/spring-boot/" "$REG"
echo "== TEST 4 rust/axum: inspect Cargo.toml =="
expect "T4 axum version" "axum|0.7.5|Cargo.toml" bash "$DET" "$FIX/rust-axum"
expect "T4 registry axum" "https://docs.rs/axum/" grep -F "https://docs.rs/axum/" "$REG"
echo "== TEST 5 expo: detect SDK =="
expect "T5 expo version" "expo|51.0.28|package.json" bash "$DET" "$FIX/expo-sdk"
expect "T5 registry expo" "https://docs.expo.dev/" grep -F "https://docs.expo.dev/" "$REG"
echo "== TEST 6 new dependency: research registry first =="
expect "T6 registry candidate" "zod:" grep -F "zod:" "$REG"
check "T6 task file present" test -f "$FIX/new-dependency/TASK.md"
echo "== TEST 7 ambiguous docs: fallback =="
check "T7 fallback template" test -f "$SKILL/tests/templates/fallback-checklist.md"
expect "T7 registry repo fallback" "official_repository" grep -F "official_repository" "$REG"
echo "== TEST 8 memory contradiction: docs win =="
check "T8 decision template" test -f "$SKILL/tests/templates/decision-record.md"
expect "T8 docs-win rule" "docs win" grep -F "docs win" "$SKILL/SKILL.md"
echo "== $pass passed, $fail failed =="
[ "$fail" -eq 0 ]
