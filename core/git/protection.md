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
    - phone number acts as proof of your identity. If you lose it, you can recover it using your government ID
  - Github Branch Protection enabled
  - Flash drive
    - contains a backup of your git repositories, in case you lose both your computer and phone at the same time while you are out
    - must be kept in your home
    - backup to be updated before you leave your house with both your computer and phone
    - **this might your last resource for recovering your data if you physically lose your computer and phone number. Since it's already in a mostly safe place (your house), it's best to NOT encrypt it.**
      - you might end up misstyping the password during setup or forgetting it because you spent so much time without writing the password on your computer
    - use Ext4 file system to support large file paths

## References

- 3-2-1 backup
