#!/usr/bin/env bash
set -euo pipefail
shopt -s inherit_errexit

find . | uniq -Di
