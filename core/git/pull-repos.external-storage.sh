#!/usr/bin/env bash
set -euo pipefail


#

danger_colors="\0033[1;37;41m"
reset_colors="\0033[0m"

err_report() {
    echo -e "${danger_colors}Error on line ${1}${reset_colors}" >&2
}

trap 'err_report $LINENO' ERR

#

this_dir=$(dirname "$(realpath $0)")
cd "$this_dir"

# https://en.wikipedia.org/wiki/ANSI_escape_code#3-bit_and_4-bit

info_colors="\0033[1;97;44m"
success_colors="\0033[1;30;102m"
reset_colors="\0033[0m"

#
#

source ./variables.sh

#
#

parallel_args=()

for i in "${!important_repos[@]}"
do
  repo="${important_repos[$i]}"
    
  if [ "$i" == "0" ]
  then
    # Ask for Git credentials first if SSH key is locked

    ../_pull-repos/pull-from-branch.sh "${external_storage_important_repos_dir}/${repo}" main
  else
    parallel_args+=("../_pull-repos/pull-from-branch.sh ${external_storage_important_repos_dir}/${repo} main")
  fi
done

printf '%s\n' "${parallel_args[@]}" | parallel --jobs 2 --halt soon,fail=1 --keep-order

#
#

echo ""
echo ""
echo -e "${info_colors}PULLED REPOS THAT YOU USE DAILY${reset_colors}"
echo -e "${success_colors}MAIN BRANCHES FROM REPOS WERE PULLED SUCCESSFULLY${reset_colors}
"
