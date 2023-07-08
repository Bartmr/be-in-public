## Reload modules on play

```
%load_ext autoreload
%autoreload 2
```

## Running terminal commands

- `!command` calls out to a shell (in a new process), while `%command` affects the process associated with the notebook. Use `%` to install packages in your user workspace.

## Documentation

### Show object or method docs

- `??method` or `??object`

## Inputs

### Load environment variables

Install the `python-dotenv` package

```python
from dotenv import load_dotenv

load_dotenv()
```

### `ipywidgets`

## Latex

- Start latex text by starting the content with `$` and closing again with `$`
- For multi-line latex
  ```
  $$
  (content)
  $$
  ```

## Git

- https://www.reviewnb.com/git-jupyter-notebook-ultimate-guide
