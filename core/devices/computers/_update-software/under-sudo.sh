#!/bin/bash
set -euo pipefail

set -x

apt update
apt upgrade -y

snap refresh
