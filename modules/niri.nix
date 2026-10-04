{
  pkgs,
  config,
  lib,
  ...
}:

{
  # ── Niri Window Manager Tweaks ────────────────────────────
  xdg.configFile."niri/config.kdl".text =
    let
      palette = {
        muted_mauve = "746292";
        crust = "11111bd9";
      };
    in
    ''
        // ── CSD Window Bleed Fix ───────────────────────────────
        prefer-no-csd

        // ── Monitor Scaling Rules ──────────────────────────────
        output "DP-6" {
            scale 1.25
        }

        // ── 1. Declarative Static Named Workspaces ─────────────
        // Expanded to house your new dedicated file manager layer
        workspace "1"
        workspace "2"
        workspace "3"

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

            // ── Ultra-Wide & Large Screen Sizing Rules ──
            // Sets the baseline width when a brand new window opens (50% of screen)
            default-column-width { proportion 0.5; }

            // Cycles through these specific widths when you press your layout toggle key (Mod+R)
            preset-column-widths {
                proportion 0.50  // Exact half-screen split (Great for balanced side-by-side documentation/code)
                proportion 0.62  // The "Golden Ratio" Developer Split (Prioritises Codium code view)
                proportion 0.38  // Compact Reading Split (Perfect for a narrow documentation frame next to code)
            }

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

        // ── 2. Automated Session Launches ──────────────────────
        spawn-at-startup "noctalia"

        // Workspace "1" Target Spawns (Three terminal instances)
        spawn-at-startup "alacritty"
        spawn-at-startup "alacritty"
        spawn-at-startup "alacritty"

        // Workspace "2" Target Spawns (Nautilus auto-launch removed)
        spawn-at-startup "codium"
        spawn-at-startup "brave"

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

            // Cycles between 50/50 split, 62% main focus, and 38% auxiliary frame
            Mod+R { switch-preset-column-width; } 
            
            // Instantly maximizes a column to fill the entire monitor viewport (ideal for long code sessions)
            Mod+F { maximize-column; }            
            
            // Fine-grained manual width adjustments (adjusts column by 5% increments)
            Mod+BracketLeft  { set-column-width "-5%"; }
            Mod+BracketRight { set-column-width "+5%"; }
            
            // Merges or splits windows into multi-window vertical columns
            Mod+Comma  { consume-window-into-column; }
            Mod+Period { expel-window-from-column; }

            Mod+1 { focus-workspace "1"; }
            Mod+2 { focus-workspace "2"; }
            Mod+3 { focus-workspace "3"; }
            Mod+4 { focus-workspace 4; }
            Mod+5 { focus-workspace 5; }

            Mod+Shift+1 { move-column-to-workspace "1"; }
            Mod+Shift+2 { move-column-to-workspace "2"; }
            Mod+Shift+3 { move-column-to-workspace "3"; }
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

      // ── 3. High-Precision Target Routing Overrides ──────────

      // Workspace "1" Target Assignments
      window-rule {
          match app-id="Alacritty"
          open-on-workspace "1"
          min-width 100
      }

      // ── Workspace "2" Target Assignments ──
      window-rule {
          match app-id=r#"^codium$"#
          match app-id=r#"^com\.vscodium\.codium$"#
          open-on-workspace "2"
      }

      window-rule {
          match app-id=r#"^brave-browser$"#
          open-on-workspace "2"
      }

        // Workspace "3" Target Assignments
        // Always captures Nautilus at runtime and forces it to slide onto Workspace 3
        window-rule {
            match app-id="org.gnome.Nautilus"
            open-on-workspace "3"
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
