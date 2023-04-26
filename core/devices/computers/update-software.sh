#!/usr/bin/env bash
set -euo pipefail

this_dir=$(dirname "$(realpath $0)")
cd "$this_dir"

set -x

sudo ./_update-software/under-sudo.sh

flatpak update -y
