{ pkgs, ... }:

{
  # ── Fuzzel Application Launcher Theme (Lain / NAVI Style) ──
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "monospace:size=12";
        terminal = "alacritty";
        prompt = "navi> "; # Keeps your custom NAVI style prompt
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
        radius = 12; # 👈 Matches your 12px rounded Niri window rules perfectly
      };

      colors = {
        # Fuzzel expects 8-character HEX strings (RRGGBBAA)
        background = "1e1e2eff";        # Alacritty deep blue-grey background (Mocha Base)
        text = "cdd6f4ff";              # Off-white text (Mocha Text)
        match = "746292ff";             # Muted plum accent color for matching search characters
        selection = "313244ff";         # Muted slate selection block (Surface 0)
        selection-text = "cba6f7ff";    # Selection text shifts to vibrant Mauve when focused
        selection-match = "cba6f7ff";   # Highlighted search match inside active selection bar
        border = "746292ff";            # Muted plum outline matching your Niri active window borders
      };
    };
  };
}
