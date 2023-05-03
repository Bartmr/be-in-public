- Revoke all SSH keys used in your previous phone
  - Github

- Login to the Google accounts specified in `core/primary-assets.md`
- Install and setup Firefox
  - setup browser data sync
- Install and setup F-Droid
- Install Termux from F-Droid
  - https://f-droid.org/en/packages/com.termux
  - setup Git in Termux
    - `apt update`
    - `apt upgrade -y -o Dpkg::Options::="--force-confold"`
    - `apt install -y -o Dpkg::Options::="--force-confold" git openssh`
    - `termux-setup-storage`
    - `mkdir -p ~/storage/shared/Documents/repositories`
    - `touch ~/storage/shared/Documents/repositories/.nomedia`
    - `pkg install nano`
    - 
      ```bash
      echo "
      export EDITOR=\"nano\"

      cd ~/storage/shared/Documents/repositories" >> ~/.bashrc
      ```
    - `ssh-keygen -t ed25519 -C "pbartmr@gmail.com"`
    - `git config --global user.email "pbartmr@gmail.com"`
    - `git config --global user.name "Bartolomeu Rodrigues"`
    - `git config --global pager.diff false`
    - `git config --global --add safe.directory '*'`
    - `git config --global pull.rebase false`
    - `cd ~/storage/shared/Documents/repositories`
    - `git clone "git@github.com:Bartmr/my-notes.git"`
    - `git clone "git@github.com:Bartmr/be-in-public.git"`
    - `/data/data/com.termux/files/home/storage/shared/Documents/repositories/be-in-public/core/git/mobile/clone-repos.sh`
- Install Obsidian
- Install Google Play Books
- Install Kindle
- Install Feedly
- Install Pocket
- `tech/social-media`