{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../modules/handbrake.nix
  ];
}
