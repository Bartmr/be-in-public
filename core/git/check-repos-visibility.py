from typing import Any, List, Optional, TypedDict
import requests
from concurrent.futures import ThreadPoolExecutor
import os
import json
from difflib import Differ, ndiff

class ImportantRepo(TypedDict):
  name: str
  private: Optional[bool]

class Tokens(TypedDict):
  github_token: str
 
with open('{home}/Documents/repositories/my-notes/core/git/important-repos.json'.format(home=os.environ['HOME'])) as f:
  important_repos: List[ImportantRepo] = json.load(f)

with open('{this_directory}/tokens.ignore.json'.format(this_directory=os.path.dirname(__file__))) as f:
  tokens: Tokens = json.load(f)

with open('{this_directory}/expected-github-branch-protection.json'.format(this_directory=os.path.dirname(__file__))) as f:
  expected_github_branch_protection_template: str = json.dumps(json.load(f), indent=2)

class Visibility(TypedDict):
  repo_name: str
  status_code: int
  should_be_private: bool
  is_private: Any


def get_repo_visibility(important_repo: ImportantRepo) -> Visibility:
  print(important_repo['name'])

  response = requests.get(
      url = 'https://api.github.com/repos/Bartmr/{repo}'.format(repo=important_repo['name']),
      headers = {
        'Accept': 'application/vnd.github+json',
        'Authorization': 'Bearer {token}'.format(token=tokens['github_token']),
        'X-GitHub-Api-Version': '2022-11-28'
      }
  )

  return {
    'repo_name': important_repo['name'],
    'status_code': response.status_code,
    'should_be_private': bool(important_repo.get('private')),
    'is_private': response.json().get('private')
  }

with ThreadPoolExecutor(max_workers=2) as executor:
    visibilities = executor.map(get_repo_visibility, important_repos)

bad_visibilities: List[Visibility] = []

for visibility in visibilities:
  if visibility['status_code'] == 200:

    if visibility['should_be_private']:

      if visibility['is_private'] == True:
        continue
      else:
        bad_visibilities.append(visibility)
    
    else:

      if visibility['is_private'] == False:
        continue
      else:
        bad_visibilities.append(visibility)

  else:
    bad_visibilities.append(visibility)

success_colors="\033[1;30;102m"
danger_colors="\033[1;37;41m"
reset_colors="\033[0m"

if len(bad_visibilities) != 0:
  for bad_visibility in bad_visibilities:
    print('''{danger_colors}---
{repo_name}
{status_code}
should_be_private={should_be_private}
is_private={is_private}{reset_colors}'''.format(
      danger_colors=danger_colors,
      repo_name=bad_visibility['repo_name'],
      status_code=bad_visibility['status_code'],
      should_be_private=bad_visibility['should_be_private'],
      is_private=bad_visibility['is_private'],
      reset_colors=reset_colors
    ))

  raise Exception()
else:
  print('''
{success_colors} OK {reset_colors}'''.format(success_colors=success_colors, reset_colors=reset_colors))