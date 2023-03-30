#!/usr/bin/env bash
set -euo pipefail
shopt -s inherit_errexit

this_dir=$(dirname "$(realpath $0)")
cd "$this_dir"

# Ask for inputs

echo "Input your email"
read email

echo "Input your name"
echo name

# Colors

info_colors="\0033[1;97;44m"
warning_colors="\0033[1;30;43m"
reset_colors="\0033[0m"

# Enable Wayland in Firefox

echo "
export MOZ_ENABLE_WAYLAND=1
export MUTTER_DEBUG_ENABLE_ATOMIC_KMS=0
export CLUTTER_PAINT=disable-dynamic-max-render-time" >> ~/.profile

# Enable backup of Firefox bookmarks

# echo "user_pref('browser.bookmarks.autoExportHTML', true)" >> "$(find ~/snap/firefox/common/.mozilla/firefox/ -name *.default)/user.js"

# Git

sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt install git

echo -e "${warning_colors}REMEMBER TO ADD A PASSWORD TO YOUR SSH KEY${reset_colors}"

ssh-keygen -t ed25519 -C "$email"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

echo -e "${info_colors}Now add that SSH key to your Git providers${reset_colors}"

git config --global user.email "$email"
git config --global user.name "$name"

git config --global pager.diff false

git config --global pull.rebase false

# Docker

sudo apt-get update

sudo apt-get install \
  ca-certificates \
  curl \
  gnupg \
  lsb-release

sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

set +e
sudo groupadd docker
set -e

newgrp docker

sudo usermod -aG docker $USER

# Python

pip install --user pipenv

# VSCode

sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

sudo apt install apt-transport-https
sudo apt update
sudo apt install code

code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-vscode-remote.remote-containers
code --install-extension muuvmuuv.vscode-sundial
code --install-extension github.copilot
code --install-extension ms-python.python

mkdir -p ~/.config/Code/User/settings.json
cat vscode-settings.json > "$HOME/.config/Code/User/settings.json"

echo "Quirk: delay when switching between your web browser window and VSCode

Go to ~/.vscode/argv.json
and set 'disable-hardware-acceleration' to true."

read no_op

#

mkdir -p ~/Documents/repositories
touch ~/Documents/repositories/.nomedia

touch ~/Documents/.nomedia

touch ~/Downloads/.nomedia

mkdir -p ~/automation-stuff
touch ~/automation-stuff/.nomedia

mkdir -p ~/my-apps
touch ~/my-apps/.nomedia

# Open terminal as child process in sudoed nautilus

sudo apt-get install -y dbus-x11

# Enable firewall

sudo ufw enable

# Enable large text

gsettings set org.gnome.desktop.interface text-scaling-factor 1.25

# Show accessibility menu (quickly enable on-screen keyboard for tablets)

gsettings set org.gnome.desktop.a11y always-show-universal-access-status true

# Install chrome

# wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# sudo dpkg -i google-chrome-stable_current_amd64.deb
# rm google-chrome-stable_current_amd64.deb

# Install Github CLI

# curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
# && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
# && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
# && sudo apt update \
# && sudo apt install gh -y

# gh auth login

# Install flatpak

sudo apt install flatpak

echo "Restart the computer"
read no_op
