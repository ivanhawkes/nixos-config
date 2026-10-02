{ pkgs, ... }:

{
  # ── Alacritty Terminal Theme (Lain / NAVI Style) ──────────
  programs.alacritty = {
    enable = true;
    settings = {

      window = {
        opacity = 1.0;
        decorations = "None"; # Eliminates the solid brown border frame
        blur = true;
        dimensions = {
          columns = 96;
          lines = 42;
        };
      };

      font = {
        size = 15;
        normal = {
          family = "JetBrainsMono NF";
          style = "Regular";
        };
        bold = {
          family = "JetBrainsMono NF";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono NF";
          style = "Italic";
        };
        bold_italic = {
          family = "JetBrainsMono NF";
          style = "Bold Italic";
        };
      };

      scrolling = {
        history = 2000;
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

      window.padding = {
        x = 12;
        y = 12;
      };

      colors = {
        primary = {
          background = "#1e1e2e"; # Mocha Base
          foreground = "#cdd6f4"; # Mocha Text
          dim_foreground = "#7f849c"; # Mocha Subtext1
          bright_foreground = "#cdd6f4"; # Mocha Text
        };

        cursor = {
          text = "#1e1e2e";   # Mocha Base
          cursor = "#f5e0dc"; # Mocha Rosewater
        };

        vi_mode_cursor = {
          text = "#1e1e2e";
          cursor = "#b4befe"; # Mocha Lavender
        };

        search = {
          matches = {
            foreground = "#1e1e2e";
            background = "#a6adc8"; # Mocha Subtext0
          };
          focused_match = {
            foreground = "#1e1e2e";
            background = "#a6e3a1"; # Mocha Green
          };
        };

        hints = {
          start = {
            foreground = "#1e1e2e";
            background = "#f9e2af"; # Mocha Yellow
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
          black   = "#45475a"; # Mocha Surface1
          red     = "#f38ba8"; # Mocha Red
          green   = "#a6e3a1"; # Mocha Green
          yellow  = "#f9e2af"; # Mocha Yellow
          blue    = "#89b4fa"; # Mocha Blue
          magenta = "#f5c2e7"; # Mocha Pink
          cyan    = "#94e2d5"; # Mocha Teal
          white   = "#bac2de"; # Mocha Subtext1
        };

        bright = {
          black   = "#585b70"; # Mocha Surface2
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
