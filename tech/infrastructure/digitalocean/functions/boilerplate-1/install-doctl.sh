#!/bin/bash
set -euo pipefail


cd /root

download_url=$(curl -s https://api.github.com/repos/digitalocean/doctl/releases/latest \
    | jq -r '.assets[] | select(.name|match("^.*linux-amd64\\.tar\\.gz$")) | .browser_download_url')

wget -O doctl.tar.gz "$download_url"

tar xf doctl.tar.gz

mv doctl /usr/local/bin
