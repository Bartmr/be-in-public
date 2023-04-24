#!/usr/bin/env bash
set -euo pipefail


sudo apt-get install -y openjdk-11-jdk xdg-utils wget

this_dir=$( realpath "$(dirname $0)" )

mkdir -p $this_dir/temp.ignore

wget -O $this_dir/temp.ignore/jd-gui.deb https://github.com/java-decompiler/jd-gui/releases/download/v1.6.6/jd-gui-1.6.6.deb

sudo mkdir -p /usr/share/desktop-directories/

sudo dpkg -i $this_dir/temp.ignore/jd-gui.deb

sudo cp $this_dir/bin/jd-gui.sh /opt/jd-gui/jd-gui.sh

sudo ln -s /opt/jd-gui/jd-gui.sh /usr/local/bin/jd-gui
