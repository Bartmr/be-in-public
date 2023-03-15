#!/usr/bin/env bash
set -e

this_dir=$(dirname "$(realpath $0)")
cd "$this_dir"

docker compose -f docker-compose.dev.yml up
