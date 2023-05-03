
if ! [ -x "$(command -v jq)" ]; then
  # Install the executable
  apt-get update
  apt-get install jq
fi

important_repos_dir="/data/data/com.termux/files/home/storage/shared/Documents/repositories"

source "$important_repos_dir/my-notes/core/git/variables.sh"
