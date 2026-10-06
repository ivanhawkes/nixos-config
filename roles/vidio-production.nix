{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../modules/nixos/handbrake.nix
  ];
}
