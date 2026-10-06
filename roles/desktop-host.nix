{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../modules/nixos/all-hosts.nix
    ../modules/nixos/desktop.nix
  ];
}
