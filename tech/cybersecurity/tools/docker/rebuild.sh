#!/usr/bin/env bash

name=$1

docker container rm "bartmr-cybersec-$name"

set -e 
  
docker build \
  --build-arg USER_UID=$(id -u) \
  --build-arg USER_GID=$(id -g) \
  --build-arg CACHEBUST=$(date +%s) \
  --tag "bartmr-cybersec/$name" "../$name"
