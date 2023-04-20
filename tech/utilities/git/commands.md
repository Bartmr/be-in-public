## See unpushed commits

- `git log --branches --not --remotes`

## Find the most touched files in a codebase

- `git log --format=format: --name-only --since=12.month| egrep -v '^$' | sort | uniq -c | sort -nr | head -50`

## Diff of staged changed

- `git diff --staged`
- `git diff --stat`
- `git diff --stat --unified=0`

## Delete all files matching .gitignore

- `git clean -Xdf`

## Ignore ending of file new line

- `git diff --ignore-space-at-eol´

or 

- `git diff -w´

## Remove whitespace error annotations in diff

- `git config --global core.whitespace -trailing-space`
