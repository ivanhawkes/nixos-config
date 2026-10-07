{ pkgs, ... }: {
  # ── Fuzzel Application Launcher Theme (Catppuccin Mocha Jumbo Scale) ──
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:weight=medium:size=20";
        terminal = "alacritty";
        prompt = "navi ❯ ";
        width = 65;
        lines = 8;
        tabs = 4;
        horizontal-pad = 48;
        vertical-pad = 32;
        inner-pad = 20;
        image-size-ratio = 0.8;
      };

      border = {
        width = 2;
        radius = 24;
      };

      colors = {
        # Fuzzel expects 8-character HEX strings (RRGGBBAA)
        background = "11111b99";
        text = "cdd6f4ff";
        match = "f38ba8ff";
        selection = "313244d9";
        selection-text = "cba6f7ff";
        selection-match = "f38ba8ff";
        border = "cba6f7ff";
      };
    };
  };
}
