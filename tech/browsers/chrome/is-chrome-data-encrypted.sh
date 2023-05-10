#!/usr/bin/env bash
set -euo pipefail


section_colors="\0033[1;33;100m"
success_colors="\0033[1;30;102m"
warning_colors="\0033[1;30;103m"
reset_colors="\0033[0m"

this_dir=$(dirname "$(realpath $0)")

if ! [ -x "$(command -v sqlite3)" ]; then
  # Install the executable
  sudo apt-get update
  sudo apt-get install sqlite3
fi

if ! [ -x "$(command -v jq)" ]; then
  # Install the executable
  sudo apt-get update
  sudo apt-get install jq
fi

#

if [ -d "$HOME/.config/google-chrome/Default" ]
then
  $this_dir/_is-chrome-data-encrypted/is-chrome-profile-encrypted.sh \
    "$HOME/.config/google-chrome/Default"
else
  echo -e "${warning_colors}No Default profile directory${reset_colors}"
fi


find ~/.config/google-chrome -maxdepth 1 -type d -name "Profile *" -print0 | while read -d '' -r profile_dir
do
  echo ""

  $this_dir/_is-chrome-data-encrypted/is-chrome-profile-encrypted.sh "$profile_dir"
done

#

echo ""
echo -e "${success_colors}Chrome data is being correctly encrypted${reset_colors}"
