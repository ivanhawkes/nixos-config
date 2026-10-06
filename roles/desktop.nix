{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../modules/nixos/all.nix
    ../modules/nixos/desktop.nix
  ];
}
