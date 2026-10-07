{ pkgs, ... }:

{
  # ── Alacritty Terminal Theme (Catppuccin Mocha Jumbo Scale) ──────────
  programs.alacritty = {
    enable = true;
    settings = {

      # Alacritty's default is TERM=alacritty; pin xterm-256color because some tools
      # lack terminfo for it. May help with a subtle bug that happens when using
      # NixOS, Niri, Alacritty, Starship and Pi Coding Harness.
      env = {
        TERM = "xterm-256color";
      };

      window = {
        opacity = 0.85;
        decorations = "None"; # Eliminates native window decorations cleanly for Niri
        blur = true;
        
        # Increased initial bounds so terminal grids scale comfortably alongside 1.25x scaling
        dimensions = {
          columns = 110;
          lines = 32;
        };

        # Doubled padding fields to provide a spacious modern outline framing your shell text
        padding = {
          x = 24;
          y = 24;
        };
      };

      font = {
        size = 15;
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold Italic";
        };
      };

      scrolling = {
        history = 5000;
        multiplier = 3;
      };

      keyboard = {
        bindings = [
          {
            key = "Insert";
            mods = "Control";
            action = "Copy";
          }
          {
            key = "Insert";
            mods = "Shift";
            action = "Paste";
          }
        ];
      };

      # Perfected Catppuccin Mocha Color Maps
      colors = {
        primary = {
          background = "#1e1e2e"; 
          foreground = "#cdd6f4"; 
          dim_foreground = "#7f849c"; 
          bright_foreground = "#cdd6f4"; 
        };

        cursor = {
          text = "#1e1e2e";   
          cursor = "#f5e0dc"; 
        };

        vi_mode_cursor = {
          text = "#1e1e2e";
          cursor = "#b4befe"; 
        };

        search = {
          matches = {
            foreground = "#1e1e2e";
            background = "#a6adc8"; 
          };
          focused_match = {
            foreground = "#1e1e2e";
            background = "#a6e3a1"; 
          };
        };

        hints = {
          start = {
            foreground = "#1e1e2e";
            background = "#f9e2af"; 
          };
          end = {
            foreground = "#1e1e2e";
            background = "#a6adc8";
          };
        };

        line_indicator = {
          foreground = "#1e1e2e";
          background = "#a6adc8";
        };

        selection = {
          text = "#1e1e2e";
          background = "#f5e0dc";
        };

        normal = {
          black   = "#45475a"; 
          red     = "#f38ba8"; 
          green   = "#a6e3a1"; 
          yellow  = "#f9e2af"; 
          blue    = "#89b4fa"; 
          magenta = "#f5c2e7"; 
          cyan    = "#94e2d5"; 
          white   = "#bac2de"; 
        };

        bright = {
          black   = "#585b70"; 
          red     = "#f38ba8";
          green   = "#a6e3a1";
          yellow  = "#f9e2af";
          blue    = "#89b4fa";
          magenta = "#f5c2e7";
          cyan    = "#94e2d5";
          white   = "#a6adc8";
        };

        dim = {
          black   = "#45475a";
          red     = "#f38ba8";
          green   = "#a6e3a1";
          yellow  = "#f9e2af";
          blue    = "#89b4fa";
          magenta = "#f5c2e7";
          cyan    = "#94e2d5";
          white   = "#bac2de";
        };
      };
    };
  };
}
