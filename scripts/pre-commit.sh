#!/usr/bin/env bash
set -euo pipefail
shopt -s inherit_errexit

files=`git diff --staged --name-only`

for file in $files
do
    last_char=`tail -c 1 $file`

    if [ "$last_char" != "" ]; then
        echo "" >> $file
    fi
done
