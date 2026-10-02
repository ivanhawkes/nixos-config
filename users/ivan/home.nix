{ pkgs, inputs, ... }:

let
  # Absolute path to your AppImage — adjust to match whoami
  appImage = "/home/ivan/.local/opt/tmog/tmog.AppImage";
in
{
  # ── State Version & User Metadata ────────────────────────
  home.stateVersion = "26.05";
  home.username = "ivan";
  home.homeDirectory = "/home/ivan";

  # ── Imports ───────────────────────────────────────────────
  # Import Noctalia's official home-manager module from flake inputs
  imports = [
    inputs.noctalia.homeModules.default
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

  # ── Niri Window Manager Tweaks ────────────────────────────
  xdg.configFile."niri/config.kdl".text = ''
    layout {
        focus-ring {
            enable
            width 2
            active-color "#d97706"    // Matches Noctalia Amber
            inactive-color "#1c1d22"  // Matches Noctalia Surface
        }
    }

    // Auto-start your desktop layers on launch
    spawn-at-startup "noctalia"
  '';

  # ── Optional Retro GTK & Icon configurations ──────────────
  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Dark"; # Great base color scheme for a retro rust/amber look
      package = pkgs.gruvbox-gtk-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  # ── Packages & Scripts ────────────────────────────────────
  home.packages = [
    # puts `tmog` on your \$PATH
    (pkgs.writeShellScriptBin "tmog" ''
      # Extract-and-run avoids FUSE entirely (cleaner on NixOS).
      # Delete this line if you prefer native FUSE.
      export APPIMAGE_EXTRACT_AND_RUN=1
      exec appImage "@"
    '')
  ];

  # ── Application Entries ───────────────────────────────────
  # shows TMOG in your application menu
  xdg.desktopEntries.tmog = {
    name = "TMOG";
    comment = "Task Manager OG";
    exec = "tmog"; # resolved via the wrapper on \$PATH
    icon = "tmog"; # optional: point to a .png/.svg if you have one
    terminal = false;
    type = "Application";
    categories = [
      "Utility"
      "Office"
    ];
  };
}
