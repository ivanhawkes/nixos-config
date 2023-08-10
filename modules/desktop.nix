{ config, lib, pkgs, ... }:

{
  imports = [
    ./fonts.nix
  ];

  environment.systemPackages = with pkgs; [
    # Typical desktop packages.
    firefox
    google-chrome
    krita
    inkscape
    vlc
  ];  


  hardware.enableAllFirmware = true;

  services.samba.enable = true;
}