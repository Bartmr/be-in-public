#!/usr/bin/env bash
set -e

cd /home/java

wget -O eclipse.tar.gz "https://rhlx01.hs-esslingen.de/pub/Mirrors/eclipse/technology/epp/downloads/release/2022-12/R/eclipse-jee-2022-12-R-linux-gtk-x86_64.tar.gz"

tar xf eclipse.tar.gz
