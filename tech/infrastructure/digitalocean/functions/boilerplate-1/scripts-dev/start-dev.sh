#!/usr/bin/env bash
set -euo pipefail
shopt -s inherit_errexit

this_dir=$(dirname "$(realpath $0)")
project_dir=$(dirname "$this_dir")

cd "$project_dir"

doctl serverless connect my-api-dev

if [ ! -d "build" ]
then
  webpack build --config webpack.config.js --mode development
fi

echo "

Watching project...

"

webpack watch --config webpack.config.js --mode development &

cd build

doctl serverless deploy .

doctl serverless watch . &

wait < <(jobs -p)
