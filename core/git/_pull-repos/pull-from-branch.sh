#!/bin/bash
set -euo pipefail


# https://en.wikipedia.org/wiki/ANSI_escape_code#3-bit_and_4-bit
repo_colors="\0033[1;30;47m"
reset_colors="\0033[0m"

#
#
#

dir=$1
branch_to_pull=$2

echo -e "
${repo_colors}[Target]: $(basename $dir)${reset_colors}"

cd $dir
echo -e "${repo_colors}[pwd   ]: $(pwd)${reset_colors}"

branch_it_was_in=$(git symbolic-ref --short HEAD)

git checkout $branch_to_pull --quiet

echo ""
git pull --ff-only origin $branch_to_pull

git checkout $branch_it_was_in --quiet
