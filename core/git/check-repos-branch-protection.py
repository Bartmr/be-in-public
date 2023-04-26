from typing import List, TypedDict
import requests
from concurrent.futures import ThreadPoolExecutor
import os
import json
from difflib import ndiff

class ImportantRepo(TypedDict):
  name: str

class Tokens(TypedDict):
  github_token: str
 
with open('{home}/Documents/repositories/my-notes/core/git/important-repos.json'.format(home=os.environ['HOME'])) as f:
  important_repos: List[ImportantRepo] = json.load(f)

with open('{this_directory}/tokens.ignore.json'.format(this_directory=os.path.dirname(__file__))) as f:
  tokens: Tokens = json.load(f)

with open('{this_directory}/expected-github-branch-protection.json'.format(this_directory=os.path.dirname(__file__))) as f:
  expected_github_branch_protection_template: str = json.dumps(json.load(f), indent=2)


class BranchProtection(TypedDict):
  repo_name: str
  status_code: int
  text: str
 
def get_branch_protection(important_repo: ImportantRepo) -> BranchProtection:
    print(important_repo['name'])

    response = requests.get(
      url = 'https://api.github.com/repos/Bartmr/{repo}/branches/main/protection'.format(repo=important_repo['name']),
      headers = {
        'Accept': 'application/vnd.github+json',
        'Authorization': 'Bearer {token}'.format(token=tokens['github_token']),
        'X-GitHub-Api-Version': '2022-11-28'
      }
    )

    return {
      'repo_name': important_repo['name'],
      'status_code': response.status_code,
      'text': json.dumps(response.json(), indent=2)
    }

with ThreadPoolExecutor(max_workers=2) as executor:
    branch_protections = executor.map(get_branch_protection, important_repos)

bad_branch_protections: List[BranchProtection] = []

for branch_protection in branch_protections:
  expected_github_branch_protection = expected_github_branch_protection_template.replace(
    '${username}',
    'Bartmr'
    ).replace(
      '${repo}',
      branch_protection['repo_name']
    ).replace(
      '${branch}',
      'main'
    )

  if branch_protection['status_code'] == 200 and branch_protection['text'] == expected_github_branch_protection:
    continue
  else:
    bad_branch_protections.append(branch_protection)

success_colors="\033[1;30;102m"
danger_colors="\033[1;37;41m"
reset_colors="\033[0m"

if len(bad_branch_protections) != 0:
  for bad_branch_protection in bad_branch_protections:
    print('''{danger_colors}---
{repo_name}
{status_code}
{text}
{diff}{reset_colors}'''.format(
      danger_colors=danger_colors,
      repo_name=bad_branch_protection['repo_name'],
      status_code=bad_branch_protection['status_code'],
      text=bad_branch_protection['text'],
      diff=''.join(
        ndiff(
          bad_branch_protection['text'].splitlines(keepends=True),
          expected_github_branch_protection.splitlines(keepends=True)
        )
      ),
      reset_colors=reset_colors
    ))

  raise Exception()
else:
  print('''
{success_colors} OK {reset_colors}'''.format(success_colors=success_colors, reset_colors=reset_colors))