#!/usr/bin/env bash
set -euo pipefail

./scripts/docker-ci-build-image.sh
./scripts/docker-ci-test.sh
