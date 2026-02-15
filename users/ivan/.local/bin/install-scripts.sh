#!/bin/sh
# Script to help me move into a newly setup linux. It will make soft links for all my
# dotfiles and shell scripts that are important for daily work.


## Create some typical directories.
if [ ! -d "$HOME/.config" ]; then
    mkdir $HOME/.config
fi

if [ ! -d "$HOME/.local" ]; then
    mkdir $HOME/.local
fi
if [ ! -d "$HOME/.local/bin" ]; then
    mkdir $HOME/.local/bin
fi

if [ ! -d "$HOME/projects" ]; then
    mkdir $HOME/projects
fi

# Get Alacritty configured.
if [ ! -d "$HOME/.config/alacritty" ]; then
    mkdir $HOME/.config/alacritty
fi
rm $HOME/.config/alacritty/alacritty.yml
ln -s $HOME/nixos-config/users/ivan/.config/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml

# Shell configuration.
rm $HOME/{.bashrc,.profile,.imwheel}
ln -s $HOME/nixos-config/users/ivan/.bashrc $HOME/.bashrc
ln -s $HOME/nixos-config/users/ivan/.profile $HOME/.profile

# Clang formatting rules for VS Code C++.
rm $HOME/.clang-format
ln -s $HOME/nixos-config/users/ivan/.clang-format $HOME/.clang-format

# Fast logins to SSH servers.
rm $HOME/.local/bin/{de10-nano,dns-server,mercury,venus,odroid-hc2}
ln -s $HOME/nixos-config/users/ivan/.local/bin/dns-server $HOME/.local/bin/dns-server
ln -s $HOME/nixos-config/users/ivan/.local/bin/de10-nano $HOME/.local/bin/de10-nano
ln -s $HOME/nixos-config/users/ivan/.local/bin/mercury $HOME/.local/bin/mercury
ln -s $HOME/nixos-config/users/ivan/.local/bin/venus $HOME/.local/bin/venus
ln -s $HOME/nixos-config/users/ivan/.local/bin/odroid-hc2 $HOME/.local/bin/odroid-hc2
ln -s $HOME/nixos-config/users/ivan/.local/bin/velma $HOME/.local/bin/velma
ln -s $HOME/nixos-config/users/ivan/.local/bin/daphne $HOME/.local/bin/daphne
ln -s $HOME/nixos-config/users/ivan/.local/bin/mister $HOME/.local/bin/mister

# Janky backup.
rm $HOME/.local/bin/backup.sh
ln -s $HOME/nixos-config/users/ivan/.local/bin/backup.sh $HOME/.local/bin/backup.sh

# Raspberry Pi Pico development environment installation script.
# Quick way to get my environment ready.
rm $HOME/.local/bin/clone-pico-libraries.sh
ln -s $HOME/nixos-config/users/ivan/.local/bin/clone-pico-libraries.sh $HOME/.local/bin/clone-pico-libraries.sh

# Media file renaming utility. Only needed on the media server.
rm $HOME/.local/bin/renamer.sh
ln -s $HOME/nixos-config/users/ivan/.local/bin/renamer.sh $HOME/.local/bin/renamer.sh

