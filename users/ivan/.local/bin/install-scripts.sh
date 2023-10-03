#!/bin/sh
# Script to help me move into a newly setup linux. It will make soft links for all my
# dotfiles and shell scripts that are important for daily work.


## Move in my typical shell scripts.

# Get Alacritty configured.
mkdir $HOME/.config
mkdir $HOME/.config/alacritty/
rm $HOME/.config/alacritty/alacritty.yml
ln -s $HOME/nixos-config/users/ivan/.config/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml

# Shell configuration.
mkdir $HOME/.local/bin
rm $HOME/{.bashrc,.profile,.imwheel}
ln -s $HOME/nixos-config/users/ivan/.bashrc $HOME/.bashrc
ln -s $HOME/nixos-config/users/ivan/.profile $HOME/.profile
ln -s $HOME/nixos-config/users/ivan/.imwheel $HOME/.imwheel

# Clang formatting rules for VS Code C++.
rm $HOME/.clang-format
ln -s $HOME/nixos-config/users/ivan/.clang-format $HOME/.clang-format

# Fast logins to SSH servers.
rm $HOME/.local/bin/{de10-nano,dns-server,mercury,venus}
ln -s $HOME/nixos-config/users/ivan/.local/bin/de10-nano $HOME/.local/bin/de10-nano
ln -s $HOME/nixos-config/users/ivan/.local/bin/dns-server $HOME/.local/bin/dns-server
ln -s $HOME/nixos-config/users/ivan/.local/bin/mercury $HOME/.local/bin/mercury
ln -s $HOME/nixos-config/users/ivan/.local/bin/venus $HOME/.local/bin/venus

# Janky backup.
rm $HOME/.local/bin/backup.sh
ln -s $HOME/nixos-config/users/ivan/.local/bin/backup.sh $HOME/.local/bin/backup.sh

# Set the mouse speed and scrolling speed.
rm $HOME/.local/bin/mousespeed.sh
ln -s $HOME/nixos-config/users/ivan/.local/bin/mousespeed.sh $HOME/.local/bin/mousespeed.sh
