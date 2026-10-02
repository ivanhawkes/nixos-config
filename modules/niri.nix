{ pkgs, config, lib, ... }:

{
  # ── Niri Window Manager Tweaks ────────────────────────────
  xdg.configFile."niri/config.kdl".text = 
    let
      palette = {
        muted_mauve = "746292"; # Halfway between Mauve and Alacritty background
        crust       = "11111be6"; # Catppuccin Mocha Crust (Matching your Fuzzel 90% Opacity)
      };
    in
    ''
      // ── CSD Window Bleed Fix ───────────────────────────────
      prefer-no-csd

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
              active-color "${"#" + palette.muted_mauve}"   // A beautiful, deep muted purple outline
              inactive-color "${"#" + palette.crust}" 
          }

          // ── Native Window Drop Shadows ──────────────────────
          shadow {
              on
              softness 16
              spread 2
              offset x=0 y=4
              color "rgba(0, 0, 0, 0.4)"
          }

          // Default size for new windows (columns)
          default-column-width { proportion 0.5; }
      }

      // ── Global Blur Parameters ──────────────────────────────
      // This top-level block fine-tunes how the blur handles blending
      blur {
          passes 2    // More passes = stronger, smoother frosting (default: 3)
          offset 3.5  // Sample distance per pass (default: 3.0)
          noise 0.02  // Subtle grain overlay to prevent color banding (default: 0.02)
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

      // ── Global Window Rules (Rounded Corners & Effects) ─────
      window-rule {
          geometry-corner-radius 12  
          clip-to-geometry true      
          draw-border-with-background false
          
          // The correct syntax to enable background blur behind windows
          background-effect {
              blur true
              xray false  // Setting xray to false makes it blur windows behind it instead of just the wallpaper
          }
      }

      // Specific window rules
      window-rule {
          match app-id="brave-browser"
          open-maximized true
      }

      // ── Fuzzel Layer Rules (Glassmorphism & Jumbo Scale Fix) ──
      layer-rule {
          // Fuzzel exposes its layer shell surface as "fuzzel"
          match namespace="^fuzzel$"
          
          // Syncs Niri's edge rendering to your 24px Fuzzel radius
          geometry-corner-radius 24
          
          // Activates background blur for the shell surface layer
          background-effect {
              blur true
          }

          // Deep heavy shadow profile to complement the jumbo window footprint
          shadow {
              on
              softness 30
              spread 5
              offset x=0 y=10
              color "rgba(17, 17, 27, 0.65)" // Dark Mocha Crust shadow
          }
      }
    '';
}
