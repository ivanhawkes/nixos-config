{ pkgs, inputs, lib, ... }:

let
  # Absolute path to your AppImage — adjust to match whoami
  appImage = "/home/ivan/.local/opt/tmog/tmog.AppImage";
in
{
  # ── State Version & User Metadata ────────────────────────
  home.stateVersion = "26.05";
  home.username = "ivan";
  home.homeDirectory = lib.mkForce "/home/ivan";

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
  ];

  # ── Optional Retro GTK & Icon configurations ──────────────
  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
