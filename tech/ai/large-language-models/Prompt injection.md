Protect yourself from prompt injection by using delimiters  to contain thre user input 

- Wrong
  ```
  Summarize the following text:
  {user input} 
  ```
- Right 
  ```
  Summarize the following text:
  \```
  {user input} 
  \```
  ```