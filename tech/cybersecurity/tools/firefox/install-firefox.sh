#!/bin/bash
set -euo pipefail


sudo echo "sudo allowed"

sudo apt-get update

sudo apt install -y curl wget gxmessage libdbus-glib-1-2 jq file bzip2
sudo apt install -y libasound2
sudo apt install -y libx11-xcb1

wget --content-disposition -O firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US"

tar -xjf ./firefox.tar.bz2

sudo mv firefox /opt

sudo ln -s /opt/firefox/firefox /usr/local/bin/firefox

rm firefox.tar.bz2
