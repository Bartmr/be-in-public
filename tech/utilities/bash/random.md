## Links

- https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
- https://www.gnu.org/software/bash/manual/html_node/Special-Parameters.html
- http://mywiki.wooledge.org/BashPitfalls
- https://github.com/SixArm/unix-shell-script-tactics/blob/main/doc/parse-options-via-while-and-case-not-getopts-or-getopt.md
- https://www.gnu.org/software/bash/manual/html_node/Modifying-Shell-Behavior.html
- https://github.com/SixArm/unix-shell-script-tactics
- https://dougrichardson.us/notes/fail-fast-bash-scripting.html

## Notes

- Search for previous commands by pressing `Ctrl + r`
-
  ```bash
  # split declaration and assignment of variable, so subshell propagates error and the main shell exits in case of error
  local branch_it_was_in
  branch_it_was_in=$(git symbolic-ref --short HEAD)
  ```
- The appearance of [...] can be misleading; it really is parsed just as if it were spelled test, with the same command-line processing as any regular shell command. That means that if you try to compare things using < or > they'll be interpreted as redirects. Try to use ( and ) for grouping and you'll be creating a subshell (and probably generating a syntax error by doing so in the middle of a command's arguments). Try to combine expressions with && and || inside the brackets and you'll be terminating the command early and again triggering a syntax error.

You can still use && and || outside of the brackets; at that point you're just running multiple instances of the test command instead of just one. But you can also use -a and -o as long as they're inside the brackets. So these two pipelines produce the same result:
```bash
[ "$status" -ne 200 -a "$string" != "$value" ]

[ "$status" -ne 200 ] && [ "$string" != "value" ]
```
The difference is that the first one is all checked by one instance of the test command, while the second runs two of them.
- `-ne` compares integers while != compares strings and patterns
- If you have a variable storing a string with new lines, and you want to print the string with those new lines, just wrap the variable in quotes (`""`) when using it, like so:
  ```bash
  variable="Has
  new
  lines"

  echo "$variable"
  ```
- Double brackets (`[[ comparisson == something* ]]`) is for comparing values with regexes and wildcards. Single brackets (`[ comparisson == "something" ]`) is syntax sugar for the `test` command
- `tr` vs `sed` vs `awk`
  ```
  Yes, tr is a "simple" tool compared to awk and sed, and both awk and sed can easily mimic most of its basic behaviour, but neither of sed or awk has "tr built in" in the sense that there is some single thing in them that exactly does all the things that tr does.

  tr works on characters, not strings, and converts characters from one set to characters in another (as in tr 'A-Z' 'a-z' to lowercase input). Its name is short from "translate" or "transliterate".

  It does have some nice features, like being able to delete multiple consecutive characters that are the same, which may be a bit fiddly to implement with a single sed expression.

  For example,

  tr -s '\n'
  will squeeze all consecutive newlines from the input into single newlines.

  To characterize the three tools crudely:

  tr works on characters (changes or deletes them).
  sed works on lines (modifies words or other parts of lines, or inserts or deletes lines).
  awk work on records with fields (by default whitespace separated fields on a line, but this may be changed by setting FS and RS).
  ```
- Pull latest release from Github Repo
  ```bash
  curl -s https://api.github.com/repos/digitalocean/doctl/releases/latest \
    | jq -r '.assets[] | select(.name|match("^.*linux-amd64\\.tar\\.gz$")) | .browser_download_url'
  ```
- Wait for background jobs
  ```bash
  process-1 &
  process-2 &

  wait < <(jobs -p)
  ```
- `!` reverts the exit status of the command it precedes. The command it precedes is allowed to fail in this case, even when `set -e` is set
- `if []` or `if test` is just a exit code check. If the exit code is `0`, it also means `true` as a condition.


## Wrapper operators

- `[ ]`
  - exactly the same as calling `test`. It's just syntatic sugar.
  - elements are passed to test like command arguments, meaning:
    - operators keep their original bash meaning (example: `>` still forwards text output). If you want to do comparissons, you either 
      - `test` arguments like `-gt`
      - use `\>` so the symbol becomes escaped and passed as an argument to `test`
- `[[ ]]`
  - **operators do different things in here**
  - new Bash standard
  - used to match string patterns and Regexes
  - supports comparisson signals like `>`. they do not behave like bash operators
- `(( ))`
  - **operators do different things in here**
  - since bash operators are for string handling (`2 + 3` will be `"23"` and `>` will forward the string output of a command), you can do arithmetic operations using `(())`, which will change the meaning of some bash operators to math operators.
    - To assign an arithetic operation operation to a variable
      ```bash
      var=$((4 + 5))
      ```
    - To increment or decrement a variable
      ```bash
      (( var += 1 ))
      ```
    - You can also do ternaries
      ```bash
      var=$(( a < b ? a : b ))
      ```
- `( )`
  - Group commands and run them in a subshell
- `{ }`
  - Group commands and run them in the same shell, and return result
  - can be used as something that aggregates results in a single point that can then be operated. Similar to `(something && somethingElse)` in most programming languages.
    ```bash
    if ! { test "$diff_result" == "0" || test "$diff_result" == "1"; }
    ```

## Conditions

- See [Wrapper operators](#wrapper-operators)
- Conditions evaluate the exit status of the command (be it `test` or any other). 0 exit code is true, 1 is false.
- `!` inverts the boolean result of an exit code
- Aggregate conditions
  ```bash
  if ! { test "$diff_result" == "0" || test "$diff_result" == "1"; }
  then
    echo "Error while calling diff"
    exit 1
  fi
  ```

### Practices

- since commands inside a condition return an exit code bigger than zero even if they fail before checking what they are supposed to check, it's better to write conditions that check if the correct behaviour is present or not.
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

### Check if executable exists

```bash
if ! [ -x "$(command -v jq)" ]; then
  # Install the executable
  apt-get update
  apt-get install jq
fi
```

## Data types

- In bash, everything is
  - Strings. Strings are composed of even more strings, when splitted by the `IFS` environment variable. That's why `command arg1 arg2` are equivalent to 3 strings, but `command "arg1 arg2"`are 2 strings.
    - `""` signal that the white-spaces / `IFS` characters are part of the string
  - an exit code
    - exit codes equal to 0 mean `true`
    - exit codes bigger than 0 mean `true`

### Lists / Arrays

- Array iteration of an undeclared variable is not caught by `set -u`
- `"${!array[@]}"` lists the indexes of the array, in a new line. Notice the `!`
- `"${array[$i]}"` gets an element from the array
- `"${array[@]}"` lists all elements of the array, in a new line

## Modules

- The equivalent bash equivalent to the `import` statement in many languages is the `source` command. The `source` command will run the text in the file in the current shell.
  ```bash
  # variables.sh

  x="10"
  ```
  ```bash
  source ./variables.sh 
    # variables.sh text will run in the current shell
    # x is now declared on the current shell
  ```


## Keywords

- command substitution
