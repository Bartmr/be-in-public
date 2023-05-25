#!/usr/bin/env bash
set -euo pipefail

this_dir=$(dirname "$(realpath $0)")
cd "$this_dir"

set -x

./pull-repos.sh
./clone-repos.sh
python3 ./git-fsck.py
