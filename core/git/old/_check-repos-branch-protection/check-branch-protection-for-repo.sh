#!/usr/bin/env bash
set -euo pipefail


this_dir=$(dirname "$(realpath $0)")
cd "$this_dir"

success_colors="\0033[1;30;102m"
danger_colors="\0033[1;37;41m"
reset_colors="\0033[0m"

source ../variables.sh
source ../tokens.ignore.sh

repo=$1
branch=$2

echo "$repo/$branch"
  
branch_protection_result=$(curl \
  --silent \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $github_token"\
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/${github_username}/$repo/branches/$branch/protection)

: '
sed commands replace the template strings with the actual values
'
  expected_branch_protection=$(cat ../expected-github-branch-protection.json \
    | sed "s/\${username}/$github_username/" | sed "s/\${repo}/$repo/" | sed "s/\${branch}/$branch/"
  )

if ! [ "$branch_protection_result" == "$expected_branch_protection" ]
then
  echo -e "${danger_colors}INVALID BRANCH PROTECTION \
FOR REPOSITORY ${repo}, BRANCH ${branch}:${reset_colors}"

  diff --color <(echo "$expected_branch_protection") <(echo "$branch_protection_result")

  exit 1
fi