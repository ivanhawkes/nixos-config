{ pkgs, inputs, lib, ... }:

{
  # ── State Version & User Metadata ────────────────────────
  home.stateVersion = "26.05";
  home.username = "ivan";
  home.homeDirectory = "/home/ivan";

  imports = [
    inputs.noctalia.homeModules.default
    inputs.catppuccin.homeModules.catppuccin
    
    # Home Manager modules (per-user desktop configuration)
    ../../modules/home/alacrity.nix
    ../../modules/home/niri.nix
    ../../modules/home/fuzzel.nix
    ../../modules/home/noctalia.nix
    ../../modules/home/tmog.nix
    ../../modules/home/theme.nix
    ../../modules/home/codium.nix
    ../../modules/home/starship.nix
    ../../modules/home/brave.nix
    ../../modules/home/fast-fetch.nix
  ];

  # Define your universal user-level theme flavor right here
  catppuccin.flavor = "mocha";
  #catppuccin.enable = true;

    # 👇 Add/modify these two lines to turn off the port compilation module engine
  catppuccin.enable = false;
  catppuccin.autoEnable = false;
}
