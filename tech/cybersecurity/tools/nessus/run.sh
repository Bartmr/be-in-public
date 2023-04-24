#!/usr/bin/env bash
set -euo pipefail


tools_dir="$(dirname "$(dirname "$(realpath $0)")")"
this_dir="$(dirname "$(realpath $0)")"

$tools_dir/docker/run.sh nessus -p 8834:8834 -v /opt/nessus
