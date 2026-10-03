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

          // ── 1. Perfect Side-by-Side Sizing Rules ──────────
          // Forces every newly spawned window to occupy exactly half the available monitor width
          default-column-width { proportion 0.5; }

          // Tells Niri to strictly respect your window bounds instead of shifting columns around
          struts {
              left 0
              right 0
          }
      }

      // ── Global Blur Parameters (Maximized Frosting) ──────────
      blur {
          passes 2    
          offset 3.8  
          noise 0.02  
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

          Mod+L allow-inhibiting=false { spawn "noctalia" "msg" "session" "lock"; }
          
          Mod+Shift+E { quit; }

          Mod+Left  { focus-column-left; }
          Mod+Right { focus-column-right; }

          Mod+Ctrl+Left  { move-column-left; }
          Mod+Ctrl+Right { move-column-right; }

          // ── 2. On-the-Fly Layout Toggles ──────────────────
          Mod+R { switch-preset-column-width; } 
          Mod+F { maximize-column; }            
          
          // Fast layout overrides to adjust the split ratios instantly
          Mod+Comma  { consume-window-into-column; }
          Mod+Period { expel-window-from-column; }
          Mod+BracketLeft  { set-column-width "-10%"; }
          Mod+BracketRight { set-column-width "+10%"; }

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

      // ── 3. Application Geometry Overrides ──────────────────
      // This forces Alacritty terminal layers to explicitly conform to Niri column bounds
      window-rule {
          match app-id="alacritty"
          min-width 100
      }

      // ── Fuzzel Layer Rules (Glassmorphism & Jumbo Scale Fix) ──
      layer-rule {
          match namespace="^(fuzzel|launcher)$"
          geometry-corner-radius 24
          background-effect {
              blur true
              xray false  
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
