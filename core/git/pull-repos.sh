#!/usr/bin/env bash
set -euo pipefail
shopt -s inherit_errexit

this_dir=$(dirname "$(realpath $0)")
cd "$this_dir"

# https://en.wikipedia.org/wiki/ANSI_escape_code#3-bit_and_4-bit

info_colors="\0033[1;97;44m"
success_colors="\0033[1;30;102m"
reset_colors="\0033[0m"

#
#

if ! [ -x "$(command -v parallel)" ]; then
  # Install the executable
  sudo apt-get update
  sudo apt-get install parallel
fi

#
#

source ./variables.sh

#
#

parallel_args=()

for repo in "${important_repos[@]}"
do 
  parallel_args+=("./_pull-repos/pull-from-branch.sh ${important_repos_dir}/${repo} main")
done

printf '%s\n' "${parallel_args[@]}" | parallel --jobs 2 --halt soon,fail=1 --keep-order

#
#

echo ""
echo ""
echo -e "${info_colors}PULLED REPOS THAT YOU USE DAILY${reset_colors}"
echo -e "${success_colors}MAIN BRANCHES FROM REPOS WERE PULLED SUCCESSFULLY${reset_colors}"
