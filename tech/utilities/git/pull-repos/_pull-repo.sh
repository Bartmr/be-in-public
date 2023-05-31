#!/bin/bash
set -euo pipefail

run() {
  cd "$1"

  pwd

  git checkout main
  git pull origin main
}

output=$(run "$1")
echo "$output"
