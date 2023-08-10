{ config, lib, pkgs, ... }:

{
  imports = [
    ../modules/desktop.nix
    ../modules/video-editing.nix
    ../modules/video-recording.nix
  ];
}