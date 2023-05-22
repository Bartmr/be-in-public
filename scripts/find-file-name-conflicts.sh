#!/usr/bin/env bash
set -euo pipefail

git ls-files | sort -f | uniq -Di
