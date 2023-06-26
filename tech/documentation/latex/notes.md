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

## Equations

```latex
\begin{equation*}
\end{equation*}
```