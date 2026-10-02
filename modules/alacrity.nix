{ pkgs, ... }:

{
  # ── Alacritty Terminal Theme (Lain / NAVI Style) ──────────
  programs.alacritty = {
    enable = true;
    settings = {

      general = {
        import = [
          "tokyo-night.toml"
        ];
      };

      window = {
        opacity = 1.0;
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
          background = "#141519";
          foreground = "#d1d5db";

        };
        normal = {
          black = "#1c1d22";
          blue = "#3b82f6";
          cyan = "#d97706";
          green = "#10b981";
          magenta = "#8b5cf6";
          red = "#ef4444";
          white = "#e5e7eb";
          yellow = "#f59e0b";
        };
        bright = {
          black = "#4b5563";
          blue = "#60a5fa";
          cyan = "#f59e0b";
          green = "#34d399";
          magenta = "#a78bfa";
          red = "#f87171";
          white = "#f3f4f6";
          yellow = "#fbbf24";
        };
      };
    };
  };
}
