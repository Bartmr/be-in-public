#!/usr/bin/env bash
set -euo pipefail
shopt -s inherit_errexit

sudo apt install -y wget openjdk-11-jdk

this_dir=$( realpath "$(dirname $0)" )

mkdir -p $this_dir/temp.ignore/bin

wget -O $this_dir/temp.ignore/bin/apktool https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool

wget -O $this_dir/temp.ignore/bin/apktool.jar https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.6.1.jar

chmod +x $this_dir/temp.ignore/bin/apktool $this_dir/temp.ignore/bin/apktool.jar

sudo ln -s $this_dir/temp.ignore/bin/apktool /usr/local/bin/apktool
sudo ln -s $this_dir/temp.ignore/bin/apktool.jar /usr/local/bin/apktool.jar

