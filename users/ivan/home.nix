{ pkgs, inputs, lib, ... }:

{
  # ── State Version & User Metadata ────────────────────────
  home.stateVersion = "26.05";
  home.username = "ivan";
  home.homeDirectory = "/home/ivan";

  imports = [
    inputs.noctalia.homeModules.default
    inputs.catppuccin.homeModules.catppuccin
    
    # Keep your existing Niri module import line
    ../../modules/alacrity.nix
    ../../modules/niri.nix
    ../../modules/fuzzel.nix
    ../../modules/noctalia.nix
    ../../modules/tmog.nix
    ../../modules/theme.nix
    ../../modules/codium.nix
    ../../modules/starship.nix
  ];

  # Define your universal user-level theme flavor right here
  catppuccin.flavor = "mocha";
  #catppuccin.enable = true;

    # 👇 Add/modify these two lines to turn off the port compilation module engine
  catppuccin.enable = false;
  catppuccin.autoEnable = false;
}
