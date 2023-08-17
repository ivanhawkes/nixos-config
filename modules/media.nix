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
    jack2
    qjackctl
    reaper

    # Video production.
    handbrake
  ];
}