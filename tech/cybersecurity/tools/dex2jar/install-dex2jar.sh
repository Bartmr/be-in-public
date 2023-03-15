#!/usr/bin/env bash
set -euo pipefail
shopt -s inherit_errexit

sudo apt install -y wget openjdk-11-jdk unzip

this_dir=$( realpath "$(dirname $0)" )

if [ ! -d "bin.ignore" ]
then
  git clone git@github.com:pxb1988/dex2jar.git bin.ignore
fi

cd bin.ignore/

./gradlew distZip

cd dex-tools/build/distributions

unzip dex-tools-*.zip

cd dex-tools-*/

if [ -z $(which d2j-dex2jar.sh) ]
then
  echo "export PATH=\$PATH:$(pwd)" >> ~/.bashrc
fi