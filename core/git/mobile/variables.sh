
if ! [ -x "$(command -v jq)" ]; then
  # Install the executable
  apt-get update
  apt-get install jq
fi

source /data/data/com.termux/files/home/storage/shared/Documents/repositories/my-notes/core/git/variables.sh

important_repos_dir="/data/data/com.termux/files/home/storage/shared/Documents/repositories"
