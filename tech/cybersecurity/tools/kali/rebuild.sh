#!/usr/bin/env bash
set -euo pipefail
shopt -s inherit_errexit

cd "$(dirname $0)"

"$HOME/Documents/repositories/my-notes/tech/tools/docker/rebuild.sh" kali
