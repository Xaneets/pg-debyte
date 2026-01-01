#!/usr/bin/env bash
set -euo pipefail


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
