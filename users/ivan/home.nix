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
    // ── Monitor Scaling Rules ──────────────────────────────
    output "DP-6" {
        scale 1.25
    }

    layout {
        // Space between windows and screen edges
        gaps 12

        // Focus ring outline style
        focus-ring {
            width 2
            active-color "#d97706"    // Matches Noctalia Amber
            inactive-color "#1c1d22"  // Matches Noctalia Surface
        }

        // Default size for new windows (columns)
        default-column-width { proportion 0.5; }
    }

    // Auto-start your desktop layers on launch
    spawn-at-startup "noctalia"

    // ── Application Keybindings ────────────────────────────
    binds {
        // Mod is usually the Windows / Command key
        Mod+T      { spawn "alacritty"; }
        Mod+B      { spawn "brave"; }
        Mod+E      { spawn "nautilus"; }
        Mod+C      { spawn "codium"; }
        
        // Application launch menu.
        Mod+D      { spawn "fuzzel"; }

        // Close focused windows.
        Mod+Q      { close-window; }

        // Logout.
        Mod+Shift+E { quit; }

        // ── Window Navigation & Window Sizing ──────────────
        Mod+Left  { focus-column-left; }
        Mod+Right { focus-column-right; }
        Mod+H     { focus-column-left; }   // Vim key style
        Mod+L     { focus-column-right; }  // Vim key style

        Mod+Ctrl+Left  { move-column-left; }
        Mod+Ctrl+Right { move-column-right; }

        Mod+R { switch-preset-column-width; } // Cycle window sizes (e.g., 50%, 100%)
        Mod+F { maximize-column; }            // Fullscreen column toggle

        // ── Workspace Switching ────────────────────────────
        // Jump directly to sequential workspaces using numbers
        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }

        // Move the active window directly to a specific workspace
        Mod+Shift+1 { move-column-to-workspace 1; }
        Mod+Shift+2 { move-column-to-workspace 2; }
        Mod+Shift+3 { move-column-to-workspace 3; }
        Mod+Shift+4 { move-column-to-workspace 4; }
        Mod+Shift+5 { move-column-to-workspace 5; }

        // Scroll through workspaces dynamically
        Mod+Up   { focus-workspace-up; }
        Mod+Down { focus-workspace-down; }
    }

    // ── Window Management Rules ────────────────────────────
    window-rule {
        match app-id="brave-browser"
        open-maximized true
    }
  '';


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
