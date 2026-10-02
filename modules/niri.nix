{ pkgs, ... }:

{
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
        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }

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
}
