#!/usr/bin/env bash
set -euo pipefail


this_dir=$(dirname "$(realpath $0)")
cd "$this_dir"

# Colors

info_colors="\0033[1;97;44m"
warning_colors="\0033[1;30;43m"
reset_colors="\0033[0m"

#

~/Documents/repositories/be-in-public/scripts/install-dependencies.sh

#

~/Documents/repositories/be-in-public/core/git/clone-repos.sh

# Enable Wayland in Firefox

echo "
export MOZ_ENABLE_WAYLAND=1
export MUTTER_DEBUG_ENABLE_ATOMIC_KMS=0
export CLUTTER_PAINT=disable-dynamic-max-render-time" >> ~/.profile

# Enable backup of Firefox bookmarks

# echo "user_pref('browser.bookmarks.autoExportHTML', true)" >> "$(find ~/snap/firefox/common/.mozilla/firefox/ -name *.default)/user.js"

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

# Node

# https://github.com/nodesource/distributions

curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - &&\
sudo apt-get install -y nodejs

echo "export NPM_CONFIG_PREFIX=/home/$(whoami)/.npm-global
export PATH=\"${PATH}:/home/$(whoami)/.npm-global/bin\"" >> "/home/$(whoami)/.bashrc"

# Java

sudo apt install openjdk-11-jdk

echo "
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" >> .bashrc

# Android Studio

# echo "
# export ANDROID_HOME=\$HOME/Android/Sdk
# export PATH=\$PATH:\$ANDROID_HOME/emulator
# export PATH=\$PATH:\$ANDROID_HOME/platform-tools" >> .bashrc

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
code --install-extension bradlc.vscode-tailwindcss
code --install-extension Prisma.prisma
# code --install-extension github.copilot
code --install-extension ms-python.python
code --install-extension esbenp.prettier-vscode
code --install-extension dbaeumer.vscode-eslint

mkdir -p ~/.config/Code/User/settings.json
cat vscode-settings.json > "$HOME/.config/Code/User/settings.json"

# echo "Quirk: delay when switching between your web browser window and VSCode

# Go to ~/.vscode/argv.json
# and set 'disable-hardware-acceleration' to true."

# read no_op

# Dbeaver

# sudo add-apt-repository ppa:serge-rider/dbeaver-ce
# sudo apt-get update
# sudo apt-get install dbeaver-ce

#

mkdir -p ~/Documents/repositories
touch ~/Documents/repositories/.nomedia

touch ~/Documents/.nomedia

touch ~/Downloads/.nomedia

mkdir -p ~/automation-stuff
touch ~/automation-stuff/.nomedia

mkdir -p ~/my-apps
mkdir -p ~/my-apps/bin
touch ~/my-apps/.nomedia

echo "
export PATH=\$PATH:/home/$(whoami)/my-apps/bin" >> .bashrc

# Open terminal as child process in sudoed nautilus

sudo apt-get install -y dbus-x11

# Enable firewall

# sudo ufw enable

# Enable large text

gsettings set org.gnome.desktop.interface text-scaling-factor 1.25

# Show accessibility menu (quickly enable on-screen keyboard for tablets)

gsettings set org.gnome.desktop.a11y always-show-universal-access-status true

# Install chrome

# wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# sudo dpkg -i google-chrome-stable_current_amd64.deb
# rm google-chrome-stable_current_amd64.deb

# Install Microsoft Edge

wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main"

sudo apt update && sudo apt install microsoft-edge-stable

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
