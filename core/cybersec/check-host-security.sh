#!/bin/bash
set -euo pipefail


# Use [[ $# -gt 0 ]] to test existence of positional parameters.

success_colors="\0033[1;30;102m"
danger_colors="\0033[1;37;41m"
reset_colors="\0033[0m"

# FIREWALL CHECK

ufw_status=$(ufw status verbose)
expected_ufw_status="Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), deny (routed)
New profiles: skip"

if [ "$ufw_status" != "$expected_ufw_status" ]
then
  echo -e "${danger_colors}Unexpected firewall status${reset_colors}"
  
  echo "${ufw_status}"

  exit 1
fi

echo -e "
${success_colors} OK ${reset_colors}"
