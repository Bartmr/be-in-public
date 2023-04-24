#!/usr/bin/env bash
set -euo pipefail


tools_dir="$(dirname "$(dirname "$(realpath $0)")")"
this_dir="$(dirname "$(realpath $0)")"

$tools_dir/docker/run.sh openvas -p 3000:443 -v /var/lib/openvas
