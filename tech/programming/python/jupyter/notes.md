## Latex

- Start latex text by starting the content with `$` and closing again with `$`
- For multi-line latex
  ```
  $$
  (content)
  $$
  ```
- https://www.codersarts.com/forum/machine-learning/writing-mathematical-equations-in-jupyter-notebook
  - https://jupyter-notebook.readthedocs.io/en/stable/examples/Notebook/Typesetting%20Equations.html
- Latex symbols
  - https://oeis.org/wiki/List_of_LaTeX_mathematical_symbols
- You can add or override Latex commands using
  ```
  \newcommand{\something}[1]{\bm{#1}}
  \renewcommand{\matr}[1]{\bm{#1}}
  ```
  - `[1]` are the arguments / command content
  - `{...}` contains the expression that should wrap the argument / content

  In this case, both `newcommand` and `renewcommand` wrap their content in a command that makes the text bold

## Running terminal commands

- `!command` calls out to a shell (in a new process), while `%command` affects the process associated with the notebook

## Documentation

### Show object or method docs

- `??method` or `??object`
