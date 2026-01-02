#!/usr/bin/env bash
set -euo pipefail

docker run --rm -t pg-debyte-ci bash -lc "\
  cargo build --workspace --all-targets --exclude pg_debyte_ext && \
  cargo build -p pg_debyte_ext --all-targets --features pg17 \
"
