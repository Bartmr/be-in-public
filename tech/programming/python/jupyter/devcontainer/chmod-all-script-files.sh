#!/usr/bin/env bash
set -euo pipefail
shopt -s inherit_errexit

find . -type f -iname "*.sh" -exec chmod +x {} \;