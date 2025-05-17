#!/bin/bash
set -e
# 1Password 
sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
sudo dnf install -y 1password 1password-cli

# various software
sudo dnf install -y neovim tmux
sudo dnf install -y nextcloud-client
sudo dnf install -y dnf-plugins-core
sudo dnf install -y gnome-tweaks gnome-extensions-app



# pyenv
sudo dnf install -y make gcc patch zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel libuuid-devel gdbm-libs libnsl2 jq unrar btop htop mc
curl -fsSL https://pyenv.run | bash || true

# kdenlive
sudo dnf install -y kdenlive
# discord
sudo dnf install -y discord

# MPV media player
sudo dnf install -y mpv

# docker
sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker


# Flatpaks
sudo flatpak install -y flathub org.telegram.desktop
sudo flatpak install -y flathub com.viber.Viber
sudo flatpak install -y flathub com.obsproject.Studio
sudo flatpak install -y flathub org.audacityteam.Audacity



# Nerd fonts
curl -o /tmp/Hack.zip -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip
unzip -o /tmp/Hack.zip -d ~/.local/share/fonts/
fc-cache -vf ~/.local/share/fonts/

# tmux tpm  https://github.com/tmux-plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true

# zsh
sudo dnf install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true

# steam
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1
sudo dnf install -y lutris
sudo dnf install -y steam

# jetbrains toolbox
xdg-open https://www.jetbrains.com/toolbox-app/download/download-thanks.html?platform=linux

# nofications gnome extensions
xdg-open https://extensions.gnome.org/extension/615/appindicator-support/

# vscode, i hate it but whatever

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

dnf check-update
sudo dnf install -y code

chsh -s $(which zsh)

# aws cli
sudo dnf install -y awscli2
# digital ocean cli
sudo dnf install -y doctl

# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo mv kubectl /usr/local/bin
sudo chmod a+x /usr/local/bin/kubectl

