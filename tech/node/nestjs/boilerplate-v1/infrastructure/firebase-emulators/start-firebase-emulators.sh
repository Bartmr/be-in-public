#!/usr/bin/env bash
set -e

this_dir=$(dirname "$(realpath $0)")
cd "$this_dir"

firebase emulators:start --export-on-exit=./.firebase-data --import=./.firebase-data
