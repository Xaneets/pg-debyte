#!/usr/bin/env bash
set -euo pipefail

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  if [[ -n "$(git status --porcelain)" ]]; then
    echo "Working tree is not clean; commit or stash changes before packaging." >&2
    exit 1
  fi
fi

crates=(
  pg_debyte_core
  pg_debyte_macros
  pg_debyte_pgrx
)

for crate in "${crates[@]}"; do
  echo "==> cargo package -p ${crate}"
  cargo package -p "${crate}"
  echo
done
