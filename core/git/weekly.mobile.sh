#!/bin/bash
set -euo pipefail

this_dir=$(dirname "$(realpath $0)")
cd "$this_dir"

set -x

bash ./pull-repos.mobile.sh
bash ./clone-repos.mobile.sh
python3 ./git-fsck.mobile.py
