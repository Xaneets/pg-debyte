#!/usr/bin/env bash
set -euo pipefail

BASE_IMAGE="${BASE_IMAGE:-pg-debyte-ci-base}"

if [[ "${BASE_IMAGE}" != "pg-debyte-ci-base" ]]; then
  if ! docker pull "${BASE_IMAGE}"; then
    docker build -f docker/ci-base.Dockerfile -t "${BASE_IMAGE}" .
  fi
else
  docker build -f docker/ci-base.Dockerfile -t "${BASE_IMAGE}" .
fi

docker build -f docker/ci.Dockerfile --build-arg BASE_IMAGE="${BASE_IMAGE}" -t pg-debyte-ci .
