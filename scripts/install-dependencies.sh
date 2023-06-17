#!/bin/bash
set -euo pipefail


#

this_dir=$(dirname "$(realpath $0)")
project_dir=$(dirname "$this_dir")
cd "$project_dir"

#

sudo apt install -y parallel jq curl

pip install -r requirements.txt
npm install
