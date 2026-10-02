{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../modules/all-hosts.nix
  ];
}
