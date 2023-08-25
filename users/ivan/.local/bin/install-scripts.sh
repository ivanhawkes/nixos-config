#!/bin/sh
# Script to help me move into a newly setup linux. It will make soft links for all my
# dotfiles and shell scripts that are important for daily work.


## Move in my typical shell scripts.

# Shell configuration.
ln -s $HOME/nixos-config/users/ivan/.bashrc .bashrc
ln -s $HOME/nixos-config/users/ivan/.profile .profile
ln -s $HOME/nixos-config/users/ivan/.imwheel .imwheel

# Fast logins to SSH servers.
ln -s $HOME/nixos-config/users/ivan/.local/bin/de10-nano $HOME/.local/bin/de10-nano
ln -s $HOME/nixos-config/users/ivan/.local/bin/dns-server $HOME/.local/bin/dns-server
ln -s $HOME/nixos-config/users/ivan/.local/bin/mercury $HOME/.local/bin/mercury
ln -s $HOME/nixos-config/users/ivan/.local/bin/venus $HOME/.local/bin/venus

# Janky backup.
ln -s $HOME/nixos-config/users/ivan/.local/bin/backup.sh $HOME/.local/bin/backup.sh

# Set the mouse speed and scrolling speed.
ln -s $HOME/nixos-config/users/ivan/.local/bin/mousespeed.sh $HOME/.local/bin/mousespeed.sh
