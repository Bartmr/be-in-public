#!/usr/bin/env bash
set -euo pipefail
shopt -s inherit_errexit

this_dir=$(dirname "$(realpath $0)")
project_dir=$(dirname "$this_dir")

cd "$project_dir"

doctl serverless connect my-api

npm run integrity-check

npm run clean
npm run build

cd build

# if [ -f "../.env.local" ]
# then
#   doctl serverless deploy . --env ../.env.local
# else
#   doctl serverless deploy .
# fi

doctl serverless deploy .
