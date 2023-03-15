#!/usr/bin/env bash

name=$1

docker container rm "bartmr-my-notes-$name"

set -e 

docker build \
  --tag "bartmr-my-notes/$name" .
