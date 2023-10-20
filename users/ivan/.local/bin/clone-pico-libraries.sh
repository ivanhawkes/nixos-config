#!/bin/sh

# Clone all the Raspberry Pi Pico libraries that I use.

if [ ! -d "$HOME/projects" ]; then
    mkdir $HOME/projects
fi

cd ~/projects
git clone --recursive git@github.com:raspberrypi/openocd.git
git clone --recursive git@github.com:raspberrypi/pico-sdk.git
git clone --recursive git@github.com:raspberrypi/picotool.git
git clone --recursive git@github.com:raspberrypi/pico-playground.git
git clone --recursive git@github.com:raspberrypi/pico-extras.git
git clone --recursive git@github.com:raspberrypi/picoprobe.git
