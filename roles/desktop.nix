{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../modules/all-hosts.nix
    ../modules/desktop.nix
  ];
}
