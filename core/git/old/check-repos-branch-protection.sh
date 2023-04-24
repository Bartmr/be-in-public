#!/usr/bin/env bash
set -euo pipefail


this_dir=$(dirname "$(realpath $0)")
cd "$this_dir"

#

success_colors="\0033[1;30;102m"
danger_colors="\0033[1;37;41m"
reset_colors="\0033[0m"

#

if ! [ -x "$(command -v jq)" ]; then
  # Install the executable
  sudo apt-get update
  sudo apt-get install jq
fi

if ! [ -x "$(command -v curl)" ]; then
  # Install the executable
  sudo apt-get update
  sudo apt-get install curl
fi

#

source ./variables.sh
source ./tokens.ignore.sh

#
#
#

parallel_args=()

for repo in "${important_repos[@]}"
do

  branch="main"
  
  parallel_args+=("./_check-repos-branch-protection/check-branch-protection-for-repo.sh ${repo} ${branch}")

done

printf '%s\n' "${parallel_args[@]}" | parallel --jobs 2 --halt soon,fail=1 --keep-order

echo -e "

${success_colors}OK.${reset_colors}"
