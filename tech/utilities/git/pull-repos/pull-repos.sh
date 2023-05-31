#!/bin/bash
set -euo pipefail

MAX_JOBS=2

for dir in *; do
  if [ -d "$dir/.git" ]; then
    # Wait until there are less than MAX_JOBS jobs running
    while [ $(jobs -rp | wc -l) -ge "$MAX_JOBS" ]; do
      sleep 0.1
    done

    ./pull-repo.sh "$dir" &

  fi
done

wait
echo "Done pulling all changes for all repositories!"