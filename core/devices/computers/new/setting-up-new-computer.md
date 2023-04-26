> **WARNING** Never install multi-factor authentication apps on desktop computers. These apps store data that can be accessed and hacked by other software in your computer. Always keep multi-factor apps on your phone. Multi-factor should always have each factor in a separate device.

- Revoke all SSH keys used in your previous machine / OS
  - Github

- During OS installation
  - Enable disk encryption (LUKS)
    - Use LVM with encryption
    - Use a long password that would take someone years of CPU time to decrypt your hard-drive if it's in their possession

- Fix quirks. Look in `core/new-machine/computers`

- Setup Firefox
  - Enable the `Primary Password`
    - set the `Primary Password` to the same password you use to decrypt your hard-drive
  - log into your Mozilla account to sync your browser data
  - log into the Google accounts specified in `core/primary-assets.md`
  - setup `Pocket`

- Install Firefox Developer Edition
  - **do not log into your Mozilla account. This browser flavour is solely for the purpose of programming**
    - this edition of Firefox is unstable, and might break your bookmarks and browser data during sync

- Install and setup git
  ```bash
  sudo add-apt-repository ppa:git-core/ppa
  sudo apt update
  sudo apt install git

  ssh-keygen -t ed25519 -C "pbartmr@gmail.com"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519

  git config --global user.email "pbartmr@gmail.com"
  git config --global user.name "Bartolomeu Rodrigues"

  git config --global pager.diff false
  git config --global pull.rebase false

  ```

- Clone initial repositories
  - `mkdir -p ~/Documents/repositories`
  - `git clone git@github.com:Bartmr/my-notes.git`
  - `git clone git@github.com:Bartmr/be-in-public.git`

- Run `core/new-machine/on-new-machine_part-1.sh`

- Restart your computer

- Run `core/new-machine/on-new-machine_part-2.sh`

## Steps that are good to know

I just use Ubuntu's night-mode

- `xgamma -gamma 0.8`
- `sudo apt-get install xcalib`
- `xcalib -blue <gamma> <brightness-percent> <contrast-percent> -alter`
  - `xcalib -c` to reset back to defaults
  - Default values
    - Brightness 0
    - Contrast 100
    - Gamma 1.00
- KolorControl
  - Install from <https://github.com/Ablinne/kolorcontrol>
  - `~/.local/bin/kolorcontrol`
  - Preferred settings
    - Green with contrast 92
    - Blue with contrast 80
- Psensor - temperature monitor: <https://itsfoss.com/check-laptop-cpu-temperature-ubuntu/>
- Install [CPU Power Manager by martin31821](https://extensions.gnome.org/extension/945/cpu-power-manager/)
- Calibrate screen color with Ubuntu night-mode
  - Get the temperature: `gsettings get org.gnome.settings-daemon.plugins.color night-light-temperature`
    - for the ASUS Pro from 2017, `uint32 4300` is a good value. Set it using `gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 4300`

## Troubleshooting

### Docker

#### PermissionError: [Errno 13] Permission denied

If you get this error while starting docker-compose...
```
docker-compose -f infrastructure/docker-compose.yml -f infrastructure/docker-compose.dev.yml up
Traceback (most recent call last):
File "urllib3/connectionpool.py", line 677, in urlopen
File "urllib3/connectionpool.py", line 392, in _make_request
File "http/client.py", line 1277, in request
File "http/client.py", line 1323, in _send_request
File "http/client.py", line 1272, in endheaders
File "http/client.py", line 1032, in _send_output
File "http/client.py", line 972, in send
File "docker/transport/unixconn.py", line 43, in connect
PermissionError: [Errno 13] Permission denied
```
you need to own the unix socker by running `sudo chown $(whoami):$(whoami) /var/run/docker.sock`.