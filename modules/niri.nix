{ pkgs, config, lib, ... }:

{
  # ── Niri Window Manager Tweaks ────────────────────────────
  xdg.configFile."niri/config.kdl".text = 
    let
      palette = {
        active_border = "313244";
        mauve = "cba6f7";
        crust = "11111b";
      };
    in
    ''
      // ── Monitor Scaling Rules ──────────────────────────────
      output "DP-6" {
          scale 1.25
      }

      layout {
          // Space between windows and screen edges
          gaps 12

          // Turn off focus ring so it doesn't overlap your border
          focus-ring { off; }

          border {
              width 4
              active-color "${"#" + palette.mauve}"   
              inactive-color "${"#" + palette.crust}" 
          }

          // Default size for new windows (columns)
          default-column-width { proportion 0.5; }
      }

      // Auto-start your desktop layers on launch
      spawn-at-startup "noctalia"

      // ── Application Keybindings ────────────────────────────
      binds {
          Mod+T      { spawn "alacritty"; }
          Mod+B      { spawn "brave"; }
          Mod+E      { spawn "nautilus"; }
          Mod+C      { spawn "codium"; }
          
          Mod+D      { spawn "fuzzel"; }
          Mod+Q      { close-window; }
          Mod+Shift+E { quit; }

          // ── Window Navigation & Window Sizing ──────────────
          Mod+Left  { focus-column-left; }
          Mod+Right { focus-column-right; }
          Mod+H     { focus-column-left; }   
          Mod+L     { focus-column-right; }  

          Mod+Ctrl+Left  { move-column-left; }
          Mod+Ctrl+Right { move-column-right; }

          Mod+R { switch-preset-column-width; } 
          Mod+F { maximize-column; }            

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

          Mod+Up   { focus-workspace-up; }
          Mod+Down { focus-workspace-down; }
      }

      // ── Global Window Rules (Rounded Corners) ──────────────
      // Leaving "match" out entirely makes it apply universally
      window-rule {
          geometry-corner-radius 12  // Rounds the borders to a 12px radius
          clip-to-geometry true      // Prevents application backgrounds leaking out
      }

      // Specific window rules
      window-rule {
          match app-id="brave-browser"
          open-maximized true
      }
    '';
}
