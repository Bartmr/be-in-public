#!/bin/bash
set -euo pipefail


doctl auth init

doctl serverless install
