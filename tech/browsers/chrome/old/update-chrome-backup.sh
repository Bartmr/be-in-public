#!/bin/bash
set -euo pipefail


# Use [[ $# -gt 0 ]] to test existence of positional parameters.

this_dir=$(dirname "$(realpath $0)")
cd "$this_dir"

rm -rf backup

mkdir -p backup/Default

cp ~/.config/google-chrome/Default/Bookmarks backup/Default

find ~/.config/google-chrome -maxdepth 1 -type d -name "Profile *" -print0 | while read -d '' -r profile_dir
do
  profile_name=$(basename "${profile_dir}")

  mkdir -p "backup/${profile_name}"

  cp "$HOME/.config/google-chrome/${profile_name}/Bookmarks" "backup/${profile_name}"
done
