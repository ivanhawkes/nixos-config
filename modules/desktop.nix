{ config, lib, pkgs, ... }:

{
  imports = [
    ./fonts.nix
  ];

  # Discord is an unfree application.
#  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
#      "discord"
#  ];
  
  environment.systemPackages = with pkgs; [
    # Browsers.
    firefox
    google-chrome

    # Code editor.
    vscodium

    # Dotfile management.
    stow
    
    # Communications.
    #discord

    # Shiny new terminal
    alacritty

    # Artwork.
    krita
    inkscape
    blender

    # Video playback.
    vlc

    # Audio production.
#    jack2
#    qjackctl
#    reaper

    # Video production.
    handbrake
    #ffmpeg
    #obs-studio
  ];  

  hardware.enableAllFirmware = true;

  services.samba.enable = true;
}
