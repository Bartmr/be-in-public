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
  - Exceptions: part of the test in an if statement, part of any command executed in a && or || list except the command following the final && or ||, any command in a pipeline but the last, or if the command’s return status is being inverted with !

- since commands inside a condition are an evaluation of `test` and return an exit code bigger than zero even if they fail before checking what they are supposed to check (in case of syntax error), it's better to write conditions that check if the correct behaviour is present or not.
  - **WRONG** way of writing conditions
    ```bash
    if [ is-invalid-context ]
    then
      # if is-invalid-context fails before it even checks the context
      # it will never go through here and will the script will continue to run
      exit 1
    fi
    ```
  - **CORRECT** way of writing conditions
    ```bash
    if ! [ is-correct-context ]
    then
      # If is-correct-context is false or fails before it even checks the context,
      # both scenarios will go through here and 'exit 1' will be called
      exit 1
    fi
    ```

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

## Log to stderr

`command >&2`

## Log stderr with sdtout

`2>&1`

- `2` represents the file descriptor for stderr. In Bash, file descriptors are used to represent different streams of input/output. The file descriptor 2 specifically refers to stderr.
- `>` is the output redirection operator, which is used to redirect output to a file or another stream.
- `&1` refers to the file descriptor for stdout. The ampersand (&) indicates that it is not a filename, but rather a reference to another file descriptor. In this case, 1 represents stdout.