#!/usr/bin/env bash
set -euo pipefail
shopt -s inherit_errexit

# Use [[ $# -gt 0 ]] to test existence of positional parameters.

curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
  apt-get install -y nodejs

echo "export NPM_CONFIG_PREFIX=/home/vscode/.npm-global
export PATH=\"${PATH}:/home/vscode/.npm-global/bin\"" >> "/home/vscode/.bashrc"
