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

    # File sharing.
    #dropbox
    # Needs updating / work to install.
  ];  


  hardware.enableAllFirmware = true;

  services.samba.enable = true;
}