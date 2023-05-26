#!/bin/bash
set -euo pipefail


this_dir=$(dirname "$(realpath $0)")

name=""
run_args=()

index=0
for i in "$@";
do

  if [ "$index" == "0" ]
  then
    name=$i
  else
    run_args+=($i)
  fi

  index=$(expr $index + 1)

done

set +e

docker inspect "bartmr-my-notes/$name:latest" > /dev/null 2>&1
LAST_RESULT=$?

set -e

if [ $LAST_RESULT -ne 0 ]
then
  $this_dir/rebuild.sh $name
fi

#
#

mkdir -p "bin"

mkdir -p "data"
chmod go+rw "data"

#
#

xhost +"local:docker@"

set +e

docker container inspect "bartmr-my-notes-$name"  > /dev/null 2>&1
LAST_RESULT=$?

set -e

if [ $LAST_RESULT -ne 0 ]
then
  docker run \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=unix$DISPLAY \
    -v "$(pwd)/data:/home/$name/docker-data" \
    -v "$(pwd)/bin:/home/$name/docker-bin" \
    ${run_args[@]} \
    --name "bartmr-my-notes-$name" \
    "bartmr-my-notes/$name"
else
  docker start "bartmr-my-notes-$name" -a
fi
