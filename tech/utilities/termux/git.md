## Pull changes
`git pull origin main --no—edit` or `git pull origin main -m "merge"`


## Install git

-
    - `apt update`
    - `apt upgrade -y -o Dpkg::Options::="--force-confold"`
    - `apt install -y -o Dpkg::Options::="--force-confold" git openssh`
        - If needed: `pkg update openssl-tool`
- `ssh-keygen -t rsa -C "YOUR_EMAIL_ADDRESS"`
- Add public key to Git provider (like Github)
- Enable access to phone's storage: `termux-setup-storage`
- `ssh -T git@github.com`
