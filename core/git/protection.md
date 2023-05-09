## Current method of backing up and protecting repositories

- Protects against
  - local threats
    - ransomware in your machine that erases and force pushes your repositories
  - remote threats
    - Github or a 3rd party service become compromised and erase your data or block you from accessing your repositories

- Composition
  - One computer
    - with the ability to read and check branch protection rules
      - **but CANNOT have the ability to change / write branch protection rules**
    - has all the important repositories
  - One mobile phone
    - has all the important repositories
  - Github Branch Protection enabled
  - Flash drive
    - contains a backup of your git repositories, in case you lose both your computer and phone at the same time while you are out
    - must be kept in your home
    - encrypt it with the same password as your computer hard drive encryption

