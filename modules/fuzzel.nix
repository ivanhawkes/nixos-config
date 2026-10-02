{ pkgs, ... }: {
  # ── Fuzzel Application Launcher Theme (Noctalia Jumbo Scale) ── 
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        # JetBrains Mono provides crisp high-DPI scaling and aligns with Noctalia's defaults
        font = "JetBrains Mono:weight=medium:size=20"; 
        terminal = "alacritty";
        prompt = "navi ❯ "; 
        width = 65; # Slightly widened to account for the wider monospace character glyphs
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
        background = "0f111ae6"; 
        text = "f2f4f8ff"; 
        match = "80aa99ff"; 
        selection = "24293eff"; 
        selection-text = "00f5d4ff"; 
        selection-match = "00f5d4ff"; 
        border = "00f5d44d"; 
      };
    };
  };
}
