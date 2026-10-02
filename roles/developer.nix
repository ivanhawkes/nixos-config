{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../modules/developer.nix
    ../modules/go.nix
    ../modules/ai.nix
  ];
}
