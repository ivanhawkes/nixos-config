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

    ../../modules/alacrity.nix
    ../../modules/niri.nix # <-- Safely imported at the Home Manager layer
    ../../modules/fuzzel.nix # <-- Added safely at the Home Manager layer
    ../../modules/noctalia.nix # <-- Added safely at the Home Manager layer
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

  # ── Packages & Scripts ────────────────────────────────────
  home.packages = [
    # Fixed script runner using standard Nix formatting and appimage-run
    (pkgs.writeShellScriptBin "tmog" ''
      export APPIMAGE_EXTRACT_AND_RUN=1
      exec ${pkgs.appimage-run}/bin/appimage-run "${appImage}" "$@"
    '')
  ];

  # ── Application Entries ───────────────────────────────────
  xdg.desktopEntries.tmog = {
    name = "TMOG";
    comment = "Task Manager OG";
    exec = "tmog";
    icon = "tmog";
    terminal = false;
    type = "Application";
    categories = [
      "Utility"
      "Office"
    ];
  };
}
