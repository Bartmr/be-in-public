#!/usr/bin/env bash
set -euo pipefail

danger_colors="\0033[1;37;41m"
reset_colors="\0033[0m"

catch_error() {
    echo -e "${danger_colors}Error on line ${1}${reset_colors}" >&2
}

trap 'catch_error $LINENO' ERR

#

this_dir=$(dirname "$(realpath $0)")
cd "$this_dir"
