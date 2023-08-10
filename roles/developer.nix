{ config, lib, pkgs, ... }:

{
  imports = [
    ../modules/developer.nix
    ../modules/arduino.nix
    ../modules/go.nix
    ../modules/raspberry-pi-pico.nix
  ];
}