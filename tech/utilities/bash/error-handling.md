## Exit on non-zero exit

`set -euo pipefail`

## Catch non-zero exits

- `trap 'command_to_run arg' ERR`

-
  ```bash
  err_report() {
    echo -e "${danger_colors}Error on line ${1}${reset_colors}" >&2

      # If you're not using set -e
      # exit 1
  }

  trap 'err_report $LINENO' ERR
  ```
