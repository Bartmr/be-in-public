#!/usr/bin/env bash
set -euo pipefail


this_dir=$(dirname "$(realpath $0)")
cd "$this_dir"

#

success_colors="\0033[1;30;102m"
danger_colors="\0033[1;37;41m"
reset_colors="\0033[0m"

#

source ./variables.sh
super_github_token=$(cat tokens.ignore.json | jq -r '.super_github_token')

#
#
#

for repo in "${important_repos[@]}"
do

  branch="main"

  echo "
---  
$repo
  
"

  curl \
    --silent \
    -X PUT \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $super_github_token"\
    -H "X-GitHub-Api-Version: 2022-11-28" \
    -d "$(cat ./_set-repos-branch-protection/branch-protection.json)" \
    https://api.github.com/repos/${github_username}/$repo/branches/$branch/protection

done

echo -e "

${success_colors}Finished.${reset_colors}"
