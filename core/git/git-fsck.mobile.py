import subprocess
from typing import Any, List, Optional, TypedDict
import requests
from concurrent.futures import ThreadPoolExecutor
import os
import json
from difflib import Differ, ndiff

class ImportantRepo(TypedDict):
  name: str
  private: Optional[bool]

important_repos_dir='{home}/storage/shared/Documents/repositories'.format(home=os.environ['HOME'])
 
with open(f'{important_repos_dir}/my-notes/core/git/important-repos.json') as f:
  important_repos: List[ImportantRepo] = json.load(f)

def git_fsck(important_repo: ImportantRepo):
  important_repo_name=important_repo['name']

  cwd=f'{important_repos_dir}/{important_repo_name}'

  args='git fsck --progress --no-dangling'

  result: subprocess.CompletedProcess[bytes]  = subprocess.run(
    cwd=cwd, 
    args=args,
    shell=True,
    capture_output=True
    )

  print(f'''{important_repo_name}
{result.stdout.decode("utf-8")}
{result.stderr.decode("utf-8")}
''')
  
  if(result.returncode != 0):
    print('!!! Error !!!')
    raise Exception;


with ThreadPoolExecutor(max_workers=2) as executor:
    visibilities = executor.map(git_fsck, important_repos)
