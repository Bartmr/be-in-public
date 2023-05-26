#!/bin/bash
set -euo pipefail

echo "Insert passphrase"
read -s passphrase
echo "Again"
read -s passphrase_again

if ! [ "$passphrase" == "$passphrase_again" ]
then
    echo "Passphrases don't match"
    exit 1
fi

for file in ./*; do
    gpg -c --passphrase "$passphrase" --batch "$file"
done
