{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Language & hardware toolchains that come with the developer role.
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
