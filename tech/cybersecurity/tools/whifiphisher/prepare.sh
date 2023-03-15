#!/usr/bin/env bash
set -euo pipefail
shopt -s inherit_errexit

# For wifiphisher
chmod o+r /etc/resolv.conf
/etc/init.d/dbus restart
