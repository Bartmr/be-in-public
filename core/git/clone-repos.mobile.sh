#!/usr/bin/env bash
set -euo pipefail


this_dir=$(dirname "$(realpath $0)")
cd "$this_dir"

# IMPORTANT REPOS

source ./variables.mobile.sh

#
#

danger_colors="\0033[1;37;41m"
reset_colors="\0033[0m"

#
#

mkdir -p $important_repos_dir

for repo in "${important_repos[@]}"
do
  if [ -d "$important_repos_dir/$repo" ]
  then
    echo "Skipped $repo"
  else
    # git clone --recurse-submodules "git@github.com:${github_username}/$repo.git" "$important_repos_dir/$repo"
    git clone "git@github.com:${github_username}/$repo.git" "$important_repos_dir/$repo"
  fi
done

echo "
---

-> ALL IMPORTANT REPOS WERE CLONED
"
