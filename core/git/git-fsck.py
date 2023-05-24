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


 
with open('{home}/Documents/repositories/my-notes/core/git/important-repos.json'.format(home=os.environ['HOME'])) as f:
  important_repos: List[ImportantRepo] = json.load(f)

def git_fsck(important_repo: ImportantRepo):
  important_repo_name=important_repo['name']

  cwd=f'/home/bartmr/Documents/repositories/{important_repo_name}'

  args='git fsck --no-dangling'

  try:
    subprocess.run(
     cwd=cwd,
     args=args,
     shell=True,
     check=True
    )
  except Exception as error:
    print(important_repo_name)
    print(error)

with ThreadPoolExecutor(max_workers=2) as executor:
    visibilities = executor.map(git_fsck, important_repos)
