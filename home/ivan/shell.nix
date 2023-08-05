{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/eabc38219184cc3e04a974fe31857d8e0eac098d.tar.gz") {} }:

pkgs.mkShell {
  packages = with pkgs;[
    # Basic packages needed to get a system installed.
    wget
    curl
    firefox

    # Key development tools.
    git
    #git config --global user.email "ivan.hawkes@gmail.com"
    #git config --global user.name "Ivan Hawkes"
    #git config --global init.defaultBranch main
    cmake
    gcc
#    "g++"
    #build-essential
    clang    
    
    # Arm development.
#    gcc-arm-none-eabi
#    libnewlib-arm-none-eabi
#    "libstdc++-arm-none-eabi-newlib"
#    gdb-multiarch
    
    # IDE and editor.
    vscode
#    sublime4

    # Serial communications.
    minicom
    # EXECUTE THIS CMD: sudo usermod -a -G dialout $USER

    # Downloading.
#    transmission-remote-gtk

    # Vulkan development.
#    vulkan-utils

    # Web development
    nodePackages.npm
    hugo
    nodePackages.gulp
    nodePackages.gulp-cli

    # Media
    handbrake
    vlc
    krita
    blender
    reaper


  ];
}
