#!/usr/bin/env bash
set -e

this_dir=$(dirname "$(realpath $0)")
project_dir=$(dirname "$this_dir")
project_name=$(basename "$project_dir")
cd "$project_dir"

set +e
docker inspect "$project_name:latest" > /dev/null 2>&1
LAST_RESULT=$?
set -e

if [ $LAST_RESULT -ne 0 ]
then
  ./scripts-dev/rebuild-dev-environment.sh
fi

#
#

xhost +"local:docker@"

set +e

docker container inspect "$project_name"  > /dev/null 2>&1
LAST_RESULT=$?

set -e

if [ $LAST_RESULT -ne 0 ]
then
  docker run -ti \
    --net host \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=unix$DISPLAY \
    -v "$(pwd):/home/java/synthz-backend" \
    --name "$project_name" \
    "$project_name"
else
  docker start "$project_name" -a
fi
