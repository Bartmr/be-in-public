#!/bin/bash
set -euo pipefail


# For wifiphisher
chmod o+r /etc/resolv.conf
/etc/init.d/dbus restart
