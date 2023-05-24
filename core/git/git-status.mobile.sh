#!/usr/bin/env bash
set -euo pipefail

#

danger_colors="\0033[1;37;41m"
reset_colors="\0033[0m"

catch_error() {
    echo -e "${danger_colors}Error on line ${1}${reset_colors}" >&2
}

trap 'catch_error $LINENO' ERR

#

this_dir=$(dirname "$(realpath $0)")
cd "$this_dir"

source ./variables.mobile.sh

# https://en.wikipedia.org/wiki/ANSI_escape_code#3-bit_and_4-bit
highlight_colors="\0033[1;30;47m"
section_colors="\0033[1;33;100m"
success_colors="\0033[1;30;102m"
reset_colors="\0033[0m"

#
#

for repo in "${important_repos[@]}"
do
  dir="$important_repos_dir/$repo"

  echo -e $highlight_colors
  echo "[Target]: $repo"
  cd $dir
  echo -e "${reset_colors}"

  #
  #

  
  git log --branches --not --remotes
  
  git status --short

  #
  #
done
