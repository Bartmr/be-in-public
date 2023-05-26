import subprocess
from typing import Any, List, Optional, TypedDict
from concurrent.futures import Future, ThreadPoolExecutor
import os
import json

class ImportantRepo(TypedDict):
  name: str
  private: Optional[bool]

important_repos_dir='{home}/storage/shared/Documents/repositories'.format(home=os.environ['HOME'])
 
with open(f'{important_repos_dir}/my-notes/core/git/important-repos.json') as f:
  important_repos: List[ImportantRepo] = json.load(f)

def git_fsck(important_repo: ImportantRepo):
  important_repo_name=important_repo['name']

  result: subprocess.CompletedProcess[bytes]  = subprocess.run(
    executable="/bin/bash",
    cwd=f'{important_repos_dir}/{important_repo_name}', 
    args='git fsck --no-dangling 2>&1',
    shell=True,
    capture_output=True
    )

  print(f'''-- {important_repo_name} --
{result.stdout.decode("utf-8")}{result.stderr.decode("utf-8")}''')
  
  if(result.returncode != 0):
    raise Exception();


with ThreadPoolExecutor(max_workers=2) as executor:
  futures: List[Future[Any]] = []

  for important_repo in important_repos:
    futures.append(executor.submit(git_fsck, important_repo))
  
  for future in futures:
    future.result()
  
