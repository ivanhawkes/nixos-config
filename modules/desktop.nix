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

    # Manage your dotfiles
    stow
    
    #kicad
    #freecad

    # Communications.
    discord

    # Shiny new terminal
    alacritty
];  


  hardware.enableAllFirmware = true;

  services.samba.enable = true;
}
