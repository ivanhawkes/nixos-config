{ config, lib, pkgs, ... }:

{
  imports = [
  ];


environment.systemPackages = with pkgs; [
    # Artwork.
    krita
    inkscape
    blender

    # Video playback.
    vlc

    # Audio production.
    reaper

    # Video production.
    handbrake
  ];  
}