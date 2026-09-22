#!/bin/bash
# detect-versions.sh <repo-root>
# Detects technologies and their INSTALLED versions from project manifests.
# Output: tech|version|source-file lines. Exit 0 even when nothing is found.
# No network. No assumptions: reports only what manifests state.
ROOT="${1:-.}"
[ -d "$ROOT" ] || { echo "ERROR: not a directory: $ROOT" >&2; exit 2; }

ver_grep() { grep -m1 -oE "$2" "$1" 2>/dev/null | head -1; }

# ---- Python ----
if [ -f "$ROOT/pyproject.toml" ]; then
  v=$(grep -m1 -E 'requires-python' "$ROOT/pyproject.toml" | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | head -1)
  echo "python|${v:-unknown}|pyproject.toml"
  for pkg in fastapi pydantic starlette sqlalchemy alembic pytest ruff; do
    pv=$(grep -m1 -E "^${pkg}[ =<>~!]+|^\"${pkg}[ =<>~!]+|${pkg} *=" "$ROOT/pyproject.toml" | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | head -1)
    [ -n "$pv" ] && echo "${pkg}|${pv}|pyproject.toml"
  done
fi
[ -f "$ROOT/.python-version" ] && echo "python|$(cat "$ROOT/.python-version")|.python-version"
if [ -f "$ROOT/requirements.txt" ]; then
  while IFS= read -r line; do
    case "$line" in fastapi*|pydantic*|sqlalchemy*|pytest*) echo "$line" | sed -E 's/([A-Za-z0-9_.-]+)[=<>~! ]+([0-9][0-9A-Za-z.]*).*/\1|\2|requirements.txt/';; esac
  done < "$ROOT/requirements.txt"
fi

# ---- JS/TS ----
if [ -f "$ROOT/package.json" ]; then
  for pkg in react next typescript expo electron express zod zustand vite eslint prettier tailwind; do
    pv=$(grep -m1 -oE "\"${pkg}\"[[:space:]]*:[[:space:]]*\"[^\"]+\"" "$ROOT/package.json" | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | head -1)
    [ -n "$pv" ] && echo "${pkg}|${pv}|package.json"
  done
  # Scoped UI libraries (package name -> tech label)
  for pair in "@mui/material|mui @chakra-ui/react|chakra antd|antd @headlessui/react|headlessui react-aria|react-aria @radix-ui/react-slot|radix"; do
    pkg="${pair%%|*}"; label="${pair##*|}"
    pv=$(grep -m1 -oE "\"${pkg}\"[[:space:]]*:[[:space:]]*\"[^\"]+\"" "$ROOT/package.json" | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | head -1)
    [ -n "$pv" ] && echo "${label}|${pv}|package.json"
  done
  [ -f "$ROOT/components.json" ] && echo "shadcn|present|components.json"
  for lock in package-lock.json pnpm-lock.yaml yarn.lock bun.lock bun.lockb; do
    [ -f "$ROOT/$lock" ] && echo "js-lockfile|present|$lock"
  done
fi
[ -f "$ROOT/app.json" ] && echo "expo-app-config|present|app.json"
for f in app.config.js app.config.ts; do [ -f "$ROOT/$f" ] && echo "expo-app-config|present|$f"; done

# ---- Rust ----
if [ -f "$ROOT/Cargo.toml" ]; then
  for pkg in axum tokio serde; do
    pv=$(awk 'f && /^\[/{f=0} /^\[dependencies\]/{f=1;next} f' "$ROOT/Cargo.toml" | grep -m1 -E "^${pkg}[[:space:]]*=" | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | head -1)
    [ -n "$pv" ] && echo "${pkg}|${pv}|Cargo.toml"
  done
  ev=$(grep -m1 -E '^edition[[:space:]]*=' "$ROOT/Cargo.toml" | grep -oE '"[0-9]+"' | tr -d '"')
  [ -n "$ev" ] && echo "rust-edition|${ev}|Cargo.toml"
fi
[ -f "$ROOT/Cargo.lock" ] && echo "rust-lockfile|present|Cargo.lock"
[ -f "$ROOT/rust-toolchain.toml" ] && echo "rust-toolchain|$(grep -m1 -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' "$ROOT/rust-toolchain.toml" | head -1)|rust-toolchain.toml"

# ---- Go ----
if [ -f "$ROOT/go.mod" ]; then
  gv=$(grep -m1 -E '^go [0-9]' "$ROOT/go.mod" | awk '{print $2}')
  echo "go|${gv:-unknown}|go.mod"
fi
[ -f "$ROOT/go.sum" ] && echo "go-lockfile|present|go.sum"

# ---- Java ----
if [ -f "$ROOT/pom.xml" ]; then
  sv=$(grep -m1 -A2 'spring-boot-starter-parent' "$ROOT/pom.xml" | grep -m1 -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | head -1)
  [ -z "$sv" ] && sv=$(grep -m1 -oE 'spring-boot[^<]*[0-9]+\.[0-9]+(\.[0-9]+)?' "$ROOT/pom.xml" | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | head -1)
  echo "spring-boot|${sv:-unknown}|pom.xml"
  jv=$(grep -m1 -E 'maven.compiler.(release|source|target)|java.version' "$ROOT/pom.xml" | grep -oE '[0-9]+' | head -1)
  [ -n "$jv" ] && echo "java|${jv}|pom.xml"
fi
for f in build.gradle build.gradle.kts; do
  if [ -f "$ROOT/$f" ]; then
    sv=$(grep -m1 -oE "org.springframework.boot['\"][^']*['\"][[:space:]]*(version)?[^0-9]*[0-9]+\.[0-9]+(\.[0-9]+)?" "$ROOT/$f" | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | head -1)
    [ -z "$sv" ] && sv=$(grep -m1 -oE "springBootVersion[[:space:]]*=[[:space:]]*['\"][0-9.]+" "$ROOT/$f" | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | head -1)
    echo "spring-boot|${sv:-unknown}|$f"
  fi
done

# ---- Infra / IaC ----
if [ -f "$ROOT/Dockerfile" ]; then
  grep -E '^FROM ' "$ROOT/Dockerfile" | sed -E 's/^FROM ([^ ]+).*/docker-base-image|\1|Dockerfile/'
fi
for f in compose.yaml compose.yml; do [ -f "$ROOT/$f" ] && echo "compose|present|$f"; done
if [ -f "$ROOT/.terraform.lock.hcl" ]; then echo "terraform-lockfile|present|.terraform.lock.hcl"; fi
