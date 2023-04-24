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

## `set -e`

- `set -e`
  - part of the test in an if statement, part of any command executed in a && or || list except the command following the final && or ||, any command in a pipeline but the last, or if the command’s return status is being inverted with !

## `set -u`

### Positional parameters

Use `[[ $# -gt 0 ]]` to test existence of positional parameters.

### Using default values if variable is not set

```bash
DEFAULT=5
RESULT=${VAR:-$DEFAULT}
echo "$RESULT"
```

### Using conditional statements that check if variables are set

```bash
if [ -z "${MY_VAR:-}" ]; then
  echo "MY_VAR was not set"
fi
```

## Traps

- `trap 'command arg' SIGNAL`

SIGNAL can be:
 - all exit trigger signals listed in `trap --list`
 - `EXIT`: shell is exiting (with any exit code)
 - `ERR`: one of the commands exited with a non-zero code
 - `DEBUG`: called before every command

## `exit`

- `exit`
  - `exit` calls do not trigger `trap ERR`
  - use `exit` inside a trap to modify the exit code
