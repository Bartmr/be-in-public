#!/usr/bin/env bash
set -euo pipefail

this_dir=$(dirname "$(realpath $0)")
cd "$this_dir"

set -x

./pull-repos.mobile.sh
./clone-repos.mobile.sh
python3 ./git-fsck.mobile.py
