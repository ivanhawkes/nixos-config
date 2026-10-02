{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../modules/developer.nix
    ../modules/go.nix
    ../modules/ai.nix
    #    ../modules/arduino.nix
    #    ../modules/raspberry-pi-pico.nix
  ];
}
