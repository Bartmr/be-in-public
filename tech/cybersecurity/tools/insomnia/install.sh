#!/usr/bin/env bash
set -euo pipefail


sudo echo "sudo allowed"

echo "deb [trusted=yes arch=amd64] https://download.konghq.com/insomnia-ubuntu/ default all" \
    | sudo tee -a /etc/apt/sources.list.d/insomnia.list

sudo apt-get update
sudo apt-get install -y insomnia
