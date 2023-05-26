#!/bin/bash
set -euo pipefail


files=`git diff --staged --name-only`

for file in $files
do
    last_char=`tail -c 1 $file`

    if [ "$last_char" != "" ]; then
        echo "" >> $file
    fi
done
