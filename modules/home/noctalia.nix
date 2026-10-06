{ pkgs, ... }:

{
  # ── Noctalia Shell Configuration (Catppuccin Mocha Glass Style) ──────
  programs.noctalia = {
    enable = true;
    settings = {
      # Static wallpaper path
      wallpaper = {
        path = "/home/ivan/Pictures/wallpapers/Anime-Girl3.png";
        mode = "fill";
      };

      # The unified Catppuccin Mocha Desktop Palette
      palette = {
        background = "#11111b"; # Catppuccin Mocha Crust (Perfect dark baseline)
        surface    = "#1e1e2e"; # Catppuccin Mocha Base (For panels/context menus)
        text       = "#cdd6f4"; # Catppuccin Mocha Text
        accent     = "#cba6f7"; # Catppuccin Mocha Mauve (Syncs flawlessly with your Niri active boundaries)
        success    = "#a6e3a1"; # Catppuccin Mocha Green
      };

      # Upgraded top bar layout for increased clarity on 32" screens
      bar = {
        position = "top";
        density = "normal"; # Swapped from compact to normal to scale nicely with your 1.25x scaling factor
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              id = "Workspace";
              labelMode = "numeric";
            }
          ];
          center = [
            {
              id = "Clock";
              format = "%H:%M:%S // %Y-%m-%d";
            }
          ];
          right = [
            { id = "Network"; }
            { id = "Battery"; }
            { id = "SystemTray"; }
          ];
        };
      };
    };
  };
}
