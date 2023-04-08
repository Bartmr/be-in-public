## Excluding files

```
[tool.mypy]

exclude = '''(?x)(
    regex1
    | regex2
  )'''

[tool.nbqa.exclude]

mypy = '''(?x)(
    regex1
    | regex2
  )'''
```