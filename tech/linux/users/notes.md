- Edit sudo config: `sudo visudo`
- Ask for sudo without command `sudo -v`
- Ask for sudo without asking for password `sudo -n`
- Bypass asking for password for certain executables
  ```bash
  echo "$(whoami) $(hostname) = (root) NOPASSWD: $HOME/process.sh" | sudo EDITOR='tee -a' visudo -f /etc/sudoers.d/custom
  ```