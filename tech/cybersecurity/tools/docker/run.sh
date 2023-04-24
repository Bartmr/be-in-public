#!/usr/bin/env bash
set -euo pipefail


project_root_dir="$HOME/Documents/repositories/be-in-public/tech/cybersecurity/tools/docker/run.sh"
this_dir="$(dirname "$(realpath $0)")"

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

docker inspect "bartmr-cybersec/$name:latest" > /dev/null 2>&1
LAST_RESULT=$?

set -e

if [ $LAST_RESULT -ne 0 ]
then
  $this_dir/rebuild.sh $name
fi

#
#

#
#

xhost +"local:docker@"

set +e

docker container inspect "bartmr-cybersec-$name"  > /dev/null 2>&1
LAST_RESULT=$?

set -e

if [ $LAST_RESULT -ne 0 ]
then
  docker run \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=unix$DISPLAY \
    -v "$project_root_dir:/home/vscode/cybersec" \
    ${run_args[@]} \
    --name "bartmr-cybersec-$name" \
    "bartmr-cybersec/$name"
else
  docker start "bartmr-cybersec-$name" -a
fi
