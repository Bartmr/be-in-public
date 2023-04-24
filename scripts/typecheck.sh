#!/usr/bin/env bash
set -euo pipefail


#

this_dir=$(dirname "$(realpath $0)")
project_dir=$(dirname "$this_dir")
cd "$project_dir"

#

mypy .

nbqa mypy .
