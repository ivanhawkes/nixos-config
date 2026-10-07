{ pkgs, inputs, lib, ... }:

{
  # ── State Version & User Metadata ────────────────────────
  home.stateVersion = "26.05";
  home.username = "ivan";
  home.homeDirectory = "/home/ivan";

  imports = [
    inputs.noctalia.homeModules.default

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

}
