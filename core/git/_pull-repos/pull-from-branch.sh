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

branch_it_was_in=$(git symbolic-ref --short HEAD)

git checkout $branch_to_pull --quiet

git_pull_output=$(git pull --ff-only origin $branch_to_pull 2>&1)

if ! [[ "$git_pull_output" == *"Already up to date."* ]]
then
  echo "$git_pull_output"
fi


git checkout $branch_it_was_in --quiet
