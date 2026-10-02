{ pkgs, config, lib, ... }:

{
  # ── Niri Window Manager Tweaks ────────────────────────────
  xdg.configFile."niri/config.kdl".text = 
    let
      palette = {
        muted_mauve = "746292"; 
        crust       = "11111bd9";
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
          gaps 12
          focus-ring { off; }

          border {
              width 4
              active-color "${"#" + palette.muted_mauve}"  
              inactive-color "${"#" + palette.crust}" 
          }

          shadow {
              on
              softness 16
              spread 2
              offset x=0 y=4
              color "rgba(0, 0, 0, 0.4)"
          }

          default-column-width { proportion 0.5; }
      }

      // ── Global Blur Parameters (Maximized Frosting) ──────────
      blur {
          passes 2    // 👈 Increased from 2 to 4 for a heavy premium blur density
          offset 3.8  // 👈 Expanded sample distance slightly for a smoother spread
          noise 0.02  // 👈 Lowered grain slightly to clear up texture clutter
      }

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

          Mod+Left  { focus-column-left; }
          Mod+Right { focus-column-right; }
          Mod+H     { focus-column-left; }   
          Mod+L     { focus-column-right; }  

          Mod+Ctrl+Left  { move-column-left; }
          Mod+Ctrl+Right { move-column-right; }

          Mod+R { switch-preset-column-width; } 
          Mod+F { maximize-column; }            

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
          
          background-effect {
              blur true
              xray false  
          }
      }

      window-rule {
          match app-id="brave-browser"
          open-maximized true
      }

      // ── Fuzzel Layer Rules (Glassmorphism & Jumbo Scale Fix) ──
      layer-rule {
          // 👈 Catches both "fuzzel" and standard "launcher" surface namespaces
          match namespace="^(fuzzel|launcher)$"
          
          geometry-corner-radius 24
          
          background-effect {
              blur true
              xray false  // 👈 CRITICAL: Turning off xray forces Niri to blur windows behind Fuzzel
          }

          shadow {
              on
              softness 30
              spread 5
              offset x=0 y=10
              color "rgba(17, 17, 27, 0.65)" 
          }
      }
    '';
}
