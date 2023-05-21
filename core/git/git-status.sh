#!/usr/bin/env bash
set -euo pipefail


this_dir=$(dirname "$(realpath $0)")
cd "$this_dir"

source ./variables.sh

# https://en.wikipedia.org/wiki/ANSI_escape_code#3-bit_and_4-bit
highlight_colors="\0033[1;30;47m"
section_colors="\0033[1;33;100m"
success_colors="\0033[1;30;102m"
reset_colors="\0033[0m"

#
#

for c in $(jq -c '.[]' ~/Documents/repositories/my-notes/core/git/important-repos.json)
do
  repo=$(echo "$c" | jq -c -r '.name')

  dir="$important_repos_dir/$repo"

  echo -e $highlight_colors
  echo "[Target]: $repo"
  cd $dir
  echo -e "[pwd   ]: $(pwd)${reset_colors}"

  #
  #

  
  git log --branches --not --remotes
  
  git status --short

  #
  #
done

echo ""
echo ""
echo -e "${success_colors}REPOS ARE FINE${reset_colors}"
