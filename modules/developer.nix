{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  environment.systemPackages = with pkgs; [
    devenv
  ];
}
