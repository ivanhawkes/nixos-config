{ pkgs, ... }:

{
  # ── Fuzzel Application Launcher Theme (Lain Style) ────────
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "monospace:size=12";
        terminal = "alacritty";
        prompt = "navi> ";
        width = 40;
        lines = 10;
        tabs = 4;
        horizontal-pad = 12;
        vertical-pad = 8;
        inner-pad = 6;
        image-size-ratio = 0.5;
      };

      border = {
        width = 2;
        radius = 0;
      };

      colors = {
        background = "141519f0";
        text = "d1d5dbff";
        match = "10b981ff";
        selection = "1c1d22ff";
        selection-text = "d97706ff";
        selection-match = "10b981ff";
        border = "d97706ff";
      };
    };
  };
}
