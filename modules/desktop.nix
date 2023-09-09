{ config, lib, pkgs, ... }:

{
  imports = [
    ./fonts.nix
  ];

  # Discord is an unfree application.
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "discord"
  ];
  
environment.systemPackages = with pkgs; [
    # Typical desktop packages.
    firefox
    google-chrome
    krita
    inkscape
    vlc

    # Communications.
    discord

    # Shiny new terminal
    alacritty
    qtile

    # Wine with support both 32- and 64-bit applications.
    wineWowPackages.stable

    # support 32-bit only
    wine

    # support 64-bit only
    (wine.override { wineBuild = "wine64"; })

    # wine-staging (version with experimental features)
    wineWowPackages.staging

    # winetricks (all versions)
    winetricks

    # native wayland support (unstable)
    wineWowPackages.waylandFull

    # File sharing.
    #dropbox
    # Needs updating / work to install.
  ];  


  hardware.enableAllFirmware = true;

  services.samba.enable = true;
}
