#!/bin/bash
set -euo pipefail

MAX_JOBS=2

git_pull_impl() (
  cd "$1"

  pwd

  git checkout main
  git pull origin main
)

git_pull() {
  output=$(git_pull_impl "$1")
  echo "$output"
}

for dir in *; do
  if [ -d "$dir/.git" ]; then
    # Wait until there are less than MAX_JOBS jobs running
    while [ $(jobs -rp | wc -l) -ge "$MAX_JOBS" ]; do
      sleep 0.1
    done

    git_pull "$dir" &

  fi
done

wait
echo "Done pulling all changes for all repositories!"