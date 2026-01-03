#!/usr/bin/env bash
set -euo pipefail

docker run --rm -t pg-debyte-ci bash -lc "\
  cargo build --workspace --all-targets --exclude pg_debyte_ext --exclude readme_known_schema --exclude readme_by_id --exclude readme_envelope && \
  cargo build -p pg_debyte_ext --all-targets --features pg17 \
"
