#!/usr/bin/env bash
set -euo pipefail
shopt -s inherit_errexit

pip install \
    autopep8 \
    jupyterlab \
    mypy \
    nbqa
