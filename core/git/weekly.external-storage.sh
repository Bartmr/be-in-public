#!/usr/bin/env bash
set -euo pipefail

this_dir=$(dirname "$(realpath $0)")
cd "$this_dir"

set -x

./pull-repos.external-storage.sh
./clone-repos.external-storage.sh
python3 ./git-fsck.external-storage.py
