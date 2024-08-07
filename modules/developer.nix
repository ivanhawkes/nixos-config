{ config, lib, pkgs, ... }:

{
  imports = [
  ];

  # Allow unfree applications.
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "vscode"
  ];
  

  environment.systemPackages = with pkgs; [
    # IDE.
    vscode
    
    # Compilers.
    gcc
    clang
    llvm
    gnumake

    # Debuggers
    gdb

    # Raspberry Pi Pico
    gcc-arm-embedded
    libtool
    automake
    autoconf
    texinfo
    libtool
    libftdi
    libusb1
    pkg-config

    # Debugging / static analysis.
    valgrind

    # Source control.
    git

    # Build utilities.
    cmake
    ninja

    # Scripting.
    python3

    # Static web pages.
    nodejs_20
    hugo
    nodePackages.gulp-cli
  ];  
}
