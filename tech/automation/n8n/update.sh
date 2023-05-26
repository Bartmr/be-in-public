#!/bin/bash
set -euo pipefail

this_dir=$(dirname "$(realpath $0)")
cd "$this_dir"

docker compose pull
