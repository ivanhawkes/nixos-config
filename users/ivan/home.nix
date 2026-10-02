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
    ./modules/niri.nix # <-- Safely imported at the Home Manager layer
  ];

  # ── Noctalia Shell Configuration (Lain / NAVI Theme) ──────
  programs.noctalia = {
    enable = true;
    settings = {
      # Static wallpaper path
      wallpaper = {
        path = "/home/ivan/Pictures/wallpapers/Anime-Girl3.png";
        mode = "fill";
      };

      # The Copland OS / Cyberpunk NAVI Palette
      palette = {
        background = "#141519"; # Deep industrial charcoal
        surface = "#1c1d22"; # Dark slate panels
        text = "#d1d5db"; # Muted white/grey
        accent = "#d97706"; # Cyberpunk rusty amber/orange
        success = "#10b981"; # Classic terminal green
      };

      # Clean, functional top bar layout
      bar = {
        position = "top";
        density = "compact";
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              id = "Workspace";
              labelMode = "numeric";
            }
          ];
          center = [
            {
              id = "Clock";
              format = "%H:%M:%S // %Y-%m-%d";
            }
          ];
          right = [
            { id = "Network"; }
            { id = "Battery"; }
            { id = "SystemTray"; }
          ];
        };
      };
    };
  };

  # ── Fuzzel Application Launcher Theme (Lain Style) ────────
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "monospace:size=12";
        terminal = "alacritty";
        prompt = "navi> ";
        width = 40;
        lines = 10;
        tabs = 4;
        horizontal-pad = 12;
        vertical-pad = 8;
        inner-pad = 6;
        image-size-ratio = 0.5;
      };

      border = {
        width = 2;
        radius = 0;
      };

      colors = {
        background = "141519f0";
        text = "d1d5dbff";
        match = "10b981ff";
        selection = "1c1d22ff";
        selection-text = "d97706ff";
        selection-match = "10b981ff";
        border = "d97706ff";
      };
    };
  };

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
