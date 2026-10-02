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
        background = "11111be6"; # Mocha Crust (90% Opacity for a modern blurred look)
        text = "cdd6f4ff";       # Mocha Text (High contrast off-white)
        match = "f38ba8ff";      # Mocha Maroon (Vibrant highlight for matching characters)
        selection = "313244ff";  # Mocha Surface 0 (Clean, distinguished active item bar)
        selection-text = "cba6f7ff"; # Mocha Mauve (Signature accent for active text)
        selection-match = "f38ba8ff"; # Mocha Maroon (Maintains match color integrity when active)
        border = "cba6f7ff";     # Mocha Mauve (Accent border outline to frame the window)
      };
    };
  };
}
