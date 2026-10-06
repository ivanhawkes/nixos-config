{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Language & hardware toolchains that come with the developer role.
  imports = [
    ./ai.nix
    ./arduino.nix
    ./ffmpeg.nix
    ./go.nix
    ./python.nix
    ./raspberry-pi-pico.nix
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  environment.systemPackages = with pkgs; [
    devenv
  ];
}
