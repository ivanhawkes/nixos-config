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
        // Suppress showing the hotkey hints at launch.
        hotkey-overlay {
            skip-at-startup
        }

        // ── CSD Window Bleed Fix ───────────────────────────────
        prefer-no-csd

        // ── Monitor Scaling Rules ──────────────────────────────
        // Matched by EDID (make/model/serial) instead of connector name,
        // so the rule survives the monitor being moved to another port.
        output "LG Electronics LG HDR QHD 0x0001BF55" {
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

            // ── Remove the Hard Border ──
            border {
                off // Disables the hard border lines
            }

            // ── Dense, Tighter Light-Blue Glow ──
            shadow {
                on
                softness 12   // Halved from 24 to keep the halo tight and clean
                spread 3      // Slightly reduced to prevent over-stretching
                offset x=0 y=0 
                color "rgba(137, 180, 250, 0.95)" // Opacity bumped from 0.6 to 0.95 for a dense, vibrant look
            }

            // ── Ultra-Wide & Large Screen Sizing Rules ──
            // Sets the baseline width when a brand new window opens (50% of screen)
            default-column-width { proportion 0.5; }

            // Set globally to on-overflow so large/enlarged columns center out nicely
            // center-focused-column "on-overflow"
            center-focused-column "never"

            // Cycles through these specific widths when you press your layout toggle key (Mod+R)
            preset-column-widths {
                proportion 0.50  // Exact half-screen split (Great for balanced side-by-side documentation/code)
                proportion 0.62  // The "Golden Ratio" Developer Split (Prioritises VS Code code view)
                proportion 0.38  // Compact Reading Split (Perfect for a narrow documentation frame next to code)
            }

            struts {
                left 12
                right 12
                top 12
                bottom 12
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
        spawn-at-startup "google-chrome"

        // ── Application Keybindings ────────────────────────────
        binds {
            Mod+T      { spawn "sh" "-c" "alacritty & niri msg action set-column-width 50%"; }
            Mod+B      { spawn "google-chrome"; }
            Mod+E      { spawn "nautilus"; }
            
            Mod+D      { spawn "fuzzel"; }
            Mod+Q      { close-window; }

            // ── Screen Recording Hotkeys via Noctalia IPC ──
            // Mod + F10: Toggles a full standard video screen capture
            Mod+F10 { spawn "noctalia" "msg" "plugin" "noctalia/screen_recorder:service" "all" "toggle"; }
            
            // Mod + F9: Saves the last 30 seconds of high-FPS replay buffer instantly to your storage
            Mod+F9  { spawn "noctalia" "msg" "plugin" "noctalia/screen_recorder:service" "all" "replay-save"; }

            Mod+L allow-inhibiting=false { spawn "noctalia" "msg" "session" "lock"; }
            
            // Clean logout via Noctalia's session action (runs its logging_out hooks)
            Mod+Shift+E { spawn "noctalia" "msg" "session" "logout"; }

            // Column Focus Hotkeys.
            Mod+Left  { focus-column-left; }
            Mod+Right { focus-column-right; }

            // Centers the currently focused terminal/column on your screen
            Mod+C { center-column; }

            // Moves the currently focused column to the left or right within the layout.
            Mod+Ctrl+Left  { move-column-left; }
            Mod+Ctrl+Right { move-column-right; }

            // Cycles between 50/50 split, 62% main focus, and 38% auxiliary frame
            Mod+R { switch-preset-column-width; } 
            
            // Instantly maximizes a column to fill the entire monitor viewport (ideal for long code sessions)
            Mod+F { maximize-column; }            
            
            // Fine-grained manual width adjustments (adjusts column by 6% increments)
            Mod+BracketLeft  { set-column-width "-3%"; }
            Mod+BracketRight { set-column-width "+3%"; }
            
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

      // Terminals.
      window-rule {
          match app-id="Alacritty"
          open-on-workspace "1"
          min-width 100

          // At 50%, it stays split. When manually enlarged via Mod+R/Mod+F, global "on-overflow" will center it.
          default-column-width { proportion 0.5; } 
      }

      // Browser (Chrome & VS Code) Target Assignments.
      window-rule {
          match app-id=r#"^code$"#
          match app-id=r#"^com\.vscode\.code$"#
          open-on-workspace "2"
          open-maximized true
          default-column-width { proportion 0.5; } 
      }

      window-rule {
          match app-id=r#"^google-chrome$"#
          open-on-workspace "2"
          open-maximized true
          default-column-width { proportion 0.5; } 
      }

        // File explorer (Nautilus)
        window-rule {
            match app-id=r#"^(org\.gnome\.)?[Nn]autilus$"#
            open-on-workspace "3"
            
            // Fixed 1024 logical pixel constraint prevents Nautilus from dropping 
            // beneath half-screen width on your 1440p monitor (2048 / 2 = 1024).
            min-width 1024
            default-column-width { proportion 0.5; }
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
                offset x=6 y=6
                color "rgba(17, 17, 27, 0.65)" 
            }
        }
    '';
}
