{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../modules/nixos/steam.nix
  ];
}
