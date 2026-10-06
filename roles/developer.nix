{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../modules/nixos/developer.nix
  ];
}
