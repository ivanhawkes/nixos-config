{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../modules/desktop.nix
    ../modules/niri.nix
  ];
}
