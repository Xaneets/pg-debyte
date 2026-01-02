#!/usr/bin/env bash
set -euo pipefail

docker build -f docker/ci.Dockerfile -t pg-debyte-ci .
