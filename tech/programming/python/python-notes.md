- `round(num, decimalPlaces)`
- `class SomeObject(TypedDict):` to create a type for an "object literal"
- `divmod(x,y)` outputs quotient and remainder as a tuple

- Indexes: https://scipy.github.io/old-wiki/pages/Cookbook/Indexing

- Why should I use "pip install --user" instead of "pip install"?. Using the "--user" flag with "pip install" allows you to install packages into your home directory instead of system-wide. This is useful when you don't have permissions to install packages system-wide, or if you want to keep your packages separate from the system-level packages. It also ensures that the packages you install won't conflict with system-level packages, since they are installed in a separate location. This does a `user installation`_ to prevent breaking any system-wide packages. If `pipenv` isn't available in your shell after installation,
you'll need to add the user site-packages binary directory to your `PATH`.
- https://packaging.python.org/en/latest/tutorials/managing-dependencies/
- https://python-poetry.org/

## `with`

Python's 'with' statement is used when working with external resources such as files, databases, or sockets. It provides a convenient way to manage resources by simplifying the try/except/finally pattern.

The with statement provides a way to wrap the execution of a block of code within a context manager. This context manager handles the setup and cleanup of the resources used during the execution of the code block. The resource is acquired at the start of the with statement, and is automatically released when the block of code has been executed. This prevents the need for manually handling resources and helps avoid potential resource leaks.
