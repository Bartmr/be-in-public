#!/bin/bash
set -euo pipefail


# https://github.com/nodesource/distributions

curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
  apt-get install -y nodejs

echo "export NPM_CONFIG_PREFIX=/home/$(whoami)/.npm-global
export PATH=\"${PATH}:/home/$(whoami)/.npm-global/bin\"" >> "/home/$(whoami)/.bashrc"
