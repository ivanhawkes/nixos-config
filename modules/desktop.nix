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
    # Typical desktop packages.
    firefox
#    google-chrome

    # Manage your dotfiles
    stow
    
    # Pretty print machine info at the command line.
    #neofetch

    #kicad
    #freecad

    # Communications.
 #   discord

    # Shiny new terminal
    alacritty
];  


  hardware.enableAllFirmware = true;

  services.samba.enable = true;
}
