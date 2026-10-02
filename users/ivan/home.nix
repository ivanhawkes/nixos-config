{ pkgs, inputs, lib, ... }:

{
  # ── State Version & User Metadata ────────────────────────
  home.stateVersion = "26.05";
  home.username = "ivan";
  home.homeDirectory = "/home/ivan";

  # ── Imports ───────────────────────────────────────────────
  # Import Noctalia's official home-manager module from flake inputs
  imports = [
    inputs.noctalia.homeModules.default

    # Pull these in cleanly using home manager.
    ../../modules/alacrity.nix
    ../../modules/niri.nix
    ../../modules/fuzzel.nix
    ../../modules/noctalia.nix
    ../../modules/tmog.nix
    ../../modules/theme.nix
  ];
}
