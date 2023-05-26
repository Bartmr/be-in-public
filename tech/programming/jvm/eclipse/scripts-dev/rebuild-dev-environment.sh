#!/bin/bash

this_dir=$(dirname "$(realpath $0)")
project_dir=$(dirname "$this_dir")
project_name=$(basename "$project_dir")
cd "$project_dir"

docker container rm "$project_name"

set -e 


  
docker build \
  --file Dockerfile.dev \
  --tag "$project_name" .
