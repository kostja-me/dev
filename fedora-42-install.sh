#!/bin/bash
set -e
# 1Password 
sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
sudo dnf install -y 1password 1password-cli

# various software
sudo dnf install -y neovim
sudo dnf install -y nextcloud-client
sudo dnf install -y dnf-plugins-core
sudo dnf install -y unrar

# pyenv
sudo dnf install -y make gcc patch zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel libuuid-devel gdbm-libs libnsl2
curl -fsSL https://pyenv.run | bash || true


# docker
sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker


# Flatpaks
sudo flatpak install -y flathub org.telegram.desktop
sudo flatpak install -y flathub com.viber.Viber


# Nerd fonts
curl -o /tmp/Hack.zip -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip
unzip -o /tmp/Hack.zip -d ~/.local/share/fonts/
fc-cache -vf ~/.local/share/fonts/


# zsh
sudo dnf install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true

# steam
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1

sudo dnf install steam -y

# jetbrains toolbox
xdg-open https://www.jetbrains.com/toolbox-app/download/download-thanks.html?platform=linux
