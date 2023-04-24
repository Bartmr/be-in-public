#!/usr/bin/env bash
set -euo pipefail

# Use [[ $# -gt 0 ]] to test existence of positional parameters.

danger_colors="\0033[1;37;41m"
reset_colors="\0033[0m"

err_report() {
    echo -e "${danger_colors}Error on line ${1}${reset_colors}" >&2
}

trap 'err_report $LINENO' ERR

#

this_dir=$(dirname "$(realpath $0)")
cd "$this_dir"
