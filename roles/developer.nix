{ config, lib, pkgs, ... }:

{
  imports = [
    ../modules/developer.nix
    ../modules/go.nix
#    ../modules/arduino.nix
#    ../modules/raspberry-pi-pico.nix
  ];
}