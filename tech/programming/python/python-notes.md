## Modules and Dependencies

- Why should I use "pip install --user" instead of "pip install"?. Using the "--user" flag with "pip install" allows you to install packages into your home directory instead of system-wide. This is useful when you don't have permissions to install packages system-wide, or if you want to keep your packages separate from the system-level packages. It also ensures that the packages you install won't conflict with system-level packages, since they are installed in a separate location. This does a `user installation`_ to prevent breaking any system-wide packages. If `pipenv` isn't available in your shell after installation,
you'll need to add the user site-packages binary directory to your `PATH`.
- https://packaging.python.org/en/latest/tutorials/managing-dependencies/
- https://python-poetry.org/

## `with`

Python's 'with' statement is used when working with external resources such as files, databases, or sockets. It provides a convenient way to manage resources by simplifying the try/except/finally pattern.

The with statement provides a way to wrap the execution of a block of code within a context manager. This context manager handles the setup and cleanup of the resources used during the execution of the code block. The resource is acquired at the start of the with statement, and is automatically released when the block of code has been executed. This prevents the need for manually handling resources and helps avoid potential resource leaks.

## Data types

### Dictionaries

#### TypedDict

```python
class SomeName(TypedDict):
  prop: str
```
```python
TypedDict('someName', {'key': str})
```

### Strings

#### Template strings like Javascript

```python
f'{variable} world'
```

## Scopes

Python creates a new variable scope every time a function is run or a module is imported. You cannot access variables from the upper scope unless you use some keywords

### Accessing and declaring in the upper scope

```python
def run():
  this_var = 2

  def run_2():
    nonlocal this_var
    
    this_var = 3

  run_2()

  print(this_var)

run()
```

## Error handling

### Handle uncaught exceptions

```python
import sys
import traceback

def exception_handler(exception_type, exception, traceback):
    print("\033[31mException: {}\033[0m".format(exception))

sys.excepthook = exception_handler
```