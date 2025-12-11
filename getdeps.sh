#!/usr/bin/env bash
REQUIRED_PACKAGE_NAMES="git tar curl fd ripgrep fzf nnn nodejs"
# OPTIONAL_PACKAGE_NAMES="alsa-utils"
NPM_PACKAGE_NAMES="tree-sitter-cli"
# NPM_LSP_LIST="vim-language-server"

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
else
    # echo "Missing /etc/os-release"
    # exit 0
    OS="DOESNOTEXIST"
fi

# SOURCE: https://github.com/which-distro/os-release/tree/main
BASE_VOID="|Void"
BASE_ALPINE="|Alpine Linux"
BASE_FREEBSD="|FreeBSD"
BASE_GENTOO="|Gentoo"
BASE_NIXOS="|NixOS"
BASE_ARCH="|Arch Linux|Archcraft|Artix Linux|Garuda Linux|Manjaro Linux"
BASE_DEBIAN="|Debian GNU/Linux|Kali GNU/Linux|Linux Mint|Zorin OS"
BASE_FEDORA="|Fedora Linux|Nobara Linux"
BASE_SUSE="|openSUSE|openSUSE Leap|openSUSE Tumbleweed|SLES"

if [[ "$BASE_VOID" == *"|$OS"* ]]; then
    echo "Detected Void"
    echo "Installing dependencies from main repos"
    sudo xbps-install -Sy gcc
    sudo xbps-install -Sy $REQUIRED_PACKAGE_NAMES
    echo "Installing dependencies from npm"
    npm install -g $NPM_PACKAGE_NAMES
fi

if [[ "$BASE_DEBIAN" == *"|$OS"* ]]; then
    echo "Detected Debian"
    echo "Installing dependencies from main repos"
    sudo apt update
    sudo apt install gcc
    sudo apt install $REQUIRED_PACKAGE_NAMES
    echo "Installing dependencies from npm"
    npm install -g $NPM_PACKAGE_NAMES
fi

if [[ "$BASE_ARCH" == *"|$OS"* ]]; then
    echo "Detected Arch"
    echo "Installing dependencies from main repos"
    sudo pacman -Sy gcc
    sudo pacman -S $REQUIRED_PACKAGE_NAMES
    echo "Installing dependencies from npm"
    npm install -g $NPM_PACKAGE_NAMES
fi

if [[ "$(uname -o)" == "Android" ]]; then
    echo "Detected Termux"
    echo "Installing dependencies from main repos"
    apt install termux-api
    apt install $REQUIRED_PACKAGE_NAMES
    echo "Installing dependencies from npm"
    npm install -g $NPM_PACKAGE_NAMES
fi

