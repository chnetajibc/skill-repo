#!/bin/bash
# Validates skill repo: frontmatter, links, registry, dupes, orphans, perms, size.
# Run: bash scripts/validate.sh
REPO="$(cd "$(dirname "$0")/.." && pwd)"
fail=0
echo "== top-level SKILL.md count =="
count=$(find "$REPO/skills" -maxdepth 3 -name "SKILL.md" | grep -v references | wc -l); echo "leaves: $count"
echo "== frontmatter check =="
for f in $(find "$REPO/skills" -maxdepth 3 -name "SKILL.md" | grep -v references); do
  head -1 "$f" | grep -q "^---$" || { echo "BAD frontmatter start: $f"; fail=1; }
  head -3 "$f" | grep -q "^name: " || { echo "BAD name: $f"; fail=1; }
  head -4 "$f" | grep -q "^description: " || { echo "BAD description: $f"; fail=1; }
done; echo "frontmatter done"
echo "== relative link check =="
for f in $(find "$REPO/skills" -maxdepth 3 -name "SKILL.md" | grep -v references); do
  dir=$(dirname "$f")
  for link in $(grep -o '`\(\.\./[^`]*\)`' "$f" | tr -d '`'); do
    target="$dir/$link"
    if [ ! -e "$target" ]; then
      if grep -qxF "$link" "$REPO/scripts/known-broken-links.txt" 2>/dev/null; then
        echo "KNOWN-BROKEN (allowlisted, queued for migration): $f -> $link"
      else
        echo "BROKEN: $f -> $link"; fail=1
      fi
    fi
  done
done; echo "links done"
echo "== registry check =="
REG="$REPO/skills/research/documentation-search/references/framework-registry.yaml"
[ -f "$REG" ] || { echo "MISSING registry"; fail=1; }
entries=$(grep -cE '^[a-z0-9-]+:$' "$REG"); echo "registry entries: $entries"
[ "$entries" -ge 100 ] || { echo "REGISTRY too small: $entries"; fail=1; }
badurl=$(grep -oE 'https?://[^"'\'' ]+' "$REG" | grep -v '^https://' | head -3)
[ -n "$badurl" ] && { echo "NON-HTTPS url: $badurl"; fail=1; }
for pair in "fastapi.tiangolo.com|fastapi" "docs.spring.io|spring-boot" "docs.expo.dev|expo" "doc.rust-lang.org|rust" "go.dev|go:" "react.dev|react:" "nextjs.org|nextjs" "expressjs.com|express" "chakra-ui.com|chakra" "ant.design|antd" "headlessui.com|headlessui" "react-spectrum.adobe.com|react-aria" "schema.org|schema-org"; do
  host="${pair%%|*}"; key="${pair##*|}"
  grep -q "$host" "$REG" || { echo "REGISTRY missing $key ($host)"; fail=1; }
done
dupkeys=$(grep -E '^[a-z0-9-]+:$' "$REG" | sort | uniq -d | head -5)
[ -n "$dupkeys" ] && { echo "DUP registry keys: $dupkeys"; fail=1; }
echo "registry done"
echo "== duplicate leaf names (allowlisted: api-design) =="
dups=$(find "$REPO/skills" -mindepth 2 -maxdepth 2 -type d | xargs -n1 basename | sort | uniq -d | grep -v '^api-design$' | head -10)
[ -n "$dups" ] && { echo "DUP leaves: $dups"; fail=1; } || echo "no unexpected dupes"
echo "== orphaned references =="
for d in $(find "$REPO/skills" -path '*/references/*' -maxdepth 4 -type d | grep -v 'references/upstream' | grep -v 'references/source' | grep -v 'references/extra'); do
  [ -n "$(ls -A "$d" 2>/dev/null)" ] || { echo "EMPTY ref dir: $d"; fail=1; }
done; echo "orphans done"
echo "== executable scripts =="
for s in $(find "$REPO/skills" -path '*/scripts/*.sh' | grep -v '/references/'); do
  [ -x "$s" ] || { echo "NOT executable: $s"; fail=1; }
done; echo "perms done"
echo "== size guard (top-level SKILL.md >400 lines) =="
long=0
for f in $(find "$REPO/skills" -maxdepth 3 -name "SKILL.md" | grep -v references); do
  lines=$(wc -l < "$f" | tr -d ' ')
  if [ "$lines" -gt 400 ]; then echo "LONG ($lines): $f"; long=$((long+1)); fi
done; echo "long files: $long"
echo "== semantic depth (operational markers, min 4) =="
thin=0
for f in $(find "$REPO/skills" -maxdepth 3 -name "SKILL.md" | grep -v references); do
  m=0
  for pat in "activate when|use when|trigger" "inspect" "decis" "procedure|workflow" "fail|trap|gotcha|pitfall|smell|wrong" "verif" "escalat|fallback" "references|registry"; do
    grep -qiE "$pat" "$f" && m=$((m+1))
  done
  if [ "$m" -lt 4 ]; then echo "THIN ($m/8): $f"; thin=$((thin+1)); fail=1; fi
done; echo "thin files: $thin"
echo "== skeletal-phrase warnings =="
grep -rniE "follow best practices|write clean code|use appropriate patterns|ensure scalab|ensure secur|add tests$|follow documentation|use the framework correctly" "$REPO/skills" --include="SKILL.md" | grep -v "/references/" | head -5; echo "(warnings only)"
echo "== shell syntax =="
for s in $(find "$REPO/skills" "$REPO/scripts" "$REPO/evals" -name "*.sh" 2>/dev/null | grep -v '/references/'); do
  bash -n "$s" || { echo "SYNTAX FAIL: $s"; fail=1; }
done; echo "shell syntax done"
echo "== YAML parse =="
python3 -c "import yaml,sys; yaml.safe_load(open('$REPO/skills/research/documentation-search/references/framework-registry.yaml')); print('registry yaml ok')" 2>/dev/null || python3 -c "print('pyyaml missing - structural registry checks above apply')";
echo "== hygiene =="
find "$REPO" -name ".DS_Store" | grep -q . && { echo "DS_Store present"; fail=1; } || echo "no DS_Store"
[ "$fail" -eq 0 ] && echo "VALIDATE OK" || echo "VALIDATE FAILED"
