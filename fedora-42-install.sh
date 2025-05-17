#!/bin/bash
set -e

echo "Installing 1password"
# 1Password 
sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
sudo dnf install -y 1password 1password-cli

echo "Installing various good software"
# various software
sudo dnf install -y neovim tmux
sudo dnf install -y nextcloud-client
sudo dnf install -y dnf-plugins-core
sudo dnf install -y gnome-tweaks gnome-extensions-app


echo "Installing pyenv"
# pyenv
sudo dnf install -y make gcc patch zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel libuuid-devel gdbm-libs libnsl2 jq unrar btop htop mc
curl -fsSL https://pyenv.run | bash || true

echo "installing kdenlive"
# kdenlive
sudo dnf install -y kdenlive

echo "Installing Discord"
# discord
sudo dnf install -y discord

echo "Installing MPV media player"
# MPV media player
sudo dnf install -y mpv

echo "Installing Docker"
# docker
sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker

echo "Installing some flatpaks"
# Flatpaks
sudo flatpak install -y flathub org.telegram.desktop
sudo flatpak install -y flathub com.viber.Viber
sudo flatpak install -y flathub com.obsproject.Studio
sudo flatpak install -y flathub org.audacityteam.Audacity


echo "Installing Nerd fonts"
# Nerd fonts
curl -o /tmp/Hack.zip -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip
unzip -o /tmp/Hack.zip -d ~/.local/share/fonts/
fc-cache -vf ~/.local/share/fonts/

gsettings set org.gnome.desktop.interface monospace-font-name "Hack Nerd Font Mono Regular"


echo "Installing tpm tmux plugin manager"
# tmux tpm  https://github.com/tmux-plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true


echo "Installing ZSH and oh my zsh"
# zsh
sudo dnf install -y zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true

echo "Installing Steam"
# steam
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1
sudo dnf install -y steam
echo "Installing Lutris"
sudo dnf install -y lutris


# jetbrains toolbox
xdg-open https://www.jetbrains.com/toolbox-app/download/download-thanks.html?platform=linux

# nofications gnome extensions
xdg-open https://extensions.gnome.org/extension/615/appindicator-support/

# vscode, i hate it but whatever
echo "Installing vscode"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
sudo dnf install -y code

echo "Installing awscli2"
# aws cli
sudo dnf install -y awscli2

echo "Installing doctl"

# digital ocean cli
sudo dnf install -y doctl

echo "Installing kubectl"
# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo mv kubectl /usr/local/bin
sudo chmod a+x /usr/local/bin/kubectl

# TODO: kubectl plugin manager and oidc authentication (or whatever fuck it is called)


# TODO: Slack, yeah i hate it, but for some reason companies still use this shit


echo "Setting gnome wm preferences button-layout"
gsettings set org.gnome.desktop.wm.preferences button-layout "appmenu:minimize,maximize,close"

echo "Setting KB for login screen to en / us"
# set KB for login screen
localectl set-keymap en
localectl set-x11-keymap us

gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
