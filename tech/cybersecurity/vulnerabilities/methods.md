- https://en.internetwache.org/dont-publicly-expose-git-or-how-we-downloaded-your-websites-sourcecode-an-analysis-of-alexas-1m-28-07-2015/
  - some sites still allow directory listing (they list all files available like a file explorer)
    - example: navigate to a known directory like `www.domain.com/.git` will show a file explorer
  - some sites make all the contents of a project public, including the `.git` directory
  - It’s enough to run the following wget command: 
    - `wget --mirror -I .git TARGET.COM/.git/`
    - Common git files
      ```  
      HEAD
      objects/info/packs
      description
      config
      COMMIT_EDITMSG
      index
      packed-refs
      refs/heads/master
      refs/remotes/origin/HEAD
      refs/stash
      logs/HEAD
      logs/refs/heads/master
      logs/refs/remotes/origin/HEAD
      info/refs
      info/exclude
      ```
    - https://github.com/internetwache/GitTools
 