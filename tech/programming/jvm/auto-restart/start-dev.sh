#!/bin/bash
set -e

this_dir=$(dirname "$(realpath $0)")
project_dir=$(dirname "$this_dir")
cd "$project_dir"

if [ ! -d build ]
then
  gradle build
fi

gradle build --continuous &

# Add 
# developmentOnly("org.springframework.boot:spring-boot-devtools")
# to gradle dependencies

gradle bootRun

wait < <(jobs -p)
