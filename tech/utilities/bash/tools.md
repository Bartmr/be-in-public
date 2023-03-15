- `awk`
  - Mixes text search with actions. Like a programming language for text inputs
- https://explainshell.com/
- jq
  - https://jqplay.org/jq
- sqlite3
  - See tables in database file `sqlite3 ./file/path ".tables"`
  - See columns in table `sqlite3 ./file/path "PRAGMA table_info(table)"`
  - SQL code to generate a table `sqlite3 ./file/path ".schema table"`
- `inotify-tools`
  ```bash
  #!/bin/bash
  a="/usr/local/inotify-tools/bin/inotifywait -mrq -e modify,move,create,delete /directory-to-watch/"
  $a | while read directory event file
      do
        # do things
      done
  ```