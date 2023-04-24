#!/usr/bin/env bash
set -euo pipefail


#

this_dir=$(dirname "$(realpath $0)")
project_dir=$(dirname "$this_dir")
cd "$project_dir"

#

pip install -r requirements.txt

pip install -r ../my-notes/requirements.txt
