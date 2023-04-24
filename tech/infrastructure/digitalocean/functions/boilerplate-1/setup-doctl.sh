#!/usr/bin/env bash
set -euo pipefail


doctl auth init

doctl serverless install
