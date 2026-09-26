{ config, lib, pkgs, ... }:

{
  imports = [
  ];

  # Allow unfree applications.
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "vscode"
  ];
  
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # IDE.
    #vscode
    vscodium
    
    # Compilers.
    #gcc
    #clang
    #llvm
    #gnumake

    # Build utilities.
    #cmake
    #ninja

    # Debuggers
    #gdb

    # Makes Docker far easier to manage.
    docker-compose

    # Raspberry Pi Pico
    #gcc-arm-embedded
    #libtool
    #automake
    #autoconf
    #texinfo
    #libtool
    #libftdi
    #libusb1
    #pkg-config

    # Debugging / static analysis.
    #valgrind

    # Scripting.
    #python3

    # Static web pages.
    #hugo
  ];  
}
