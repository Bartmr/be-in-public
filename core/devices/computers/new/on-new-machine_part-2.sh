#!/usr/bin/env bash
set -euo pipefail


this_dir=$(dirname "$(realpath $0)")
cd "$this_dir"

# Install Inkscape

sudo add-apt-repository ppa:inkscape.dev/stable
sudo apt update
sudo apt install inkscape

# Install GIMP

flatpak install https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref

# Obsidian

flatpak install --user md.obsidian.Obsidian

#

mkdir -p ~/.config/autostart

# https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html

echo "[Desktop Entry]
Type=Application
Exec=$HOME/Documents/repositories/my-notes/core/on-start/on-start.sh
Hidden=false
NoDisplay=false
X-GNOME-Autostart-Phase=Desktop
Name[en_US]=OnStart
Name=OnStart
Comment[en_US]=
Comment=
" > ~/.config/autostart/on-start.sh.desktop
