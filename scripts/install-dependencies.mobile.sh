#!/usr/bin/env bash
set -euo pipefail


#

this_dir=$(dirname "$(realpath $0)")
project_dir=$(dirname "$this_dir")
cd "$project_dir"

#

pkg install parallel jq
echo "will cite" | parallel --citation

pip install -r requirements.mobile.txt

../my-notes/scripts/install-dependencies.mobile.sh
