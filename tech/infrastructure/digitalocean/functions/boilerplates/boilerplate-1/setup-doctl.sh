#!/usr/bin/env bash
set -euo pipefail
shopt -s inherit_errexit

doctl auth init

doctl serverless install
