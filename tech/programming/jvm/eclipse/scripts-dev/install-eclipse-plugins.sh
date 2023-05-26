#!/bin/bash
set -e

cd /home/java

eclipse \
  -application org.eclipse.equinox.p2.director \
  -noSplash \
  -repository https://files.pkg.jetbrains.space/kotlin/p/kotlin-eclipse/main/last/ \
  -installIU org.jetbrains.kotlin.feature.feature.group > /dev/null
