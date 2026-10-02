{ pkgs, ... }:

{
  # ── Noctalia Shell Configuration (Lain / NAVI Theme) ──────
  programs.noctalia = {
    enable = true;
    settings = {
      # Static wallpaper path
      wallpaper = {
        path = "/home/ivan/Pictures/wallpapers/Anime-Girl3.png";
        mode = "fill";
      };

      # The Copland OS / Cyberpunk NAVI Palette
      palette = {
        background = "#141519"; # Deep industrial charcoal
        surface = "#1c1d22"; # Dark slate panels
        text = "#d1d5db"; # Muted white/grey
        accent = "#d97706"; # Cyberpunk rusty amber/orange
        success = "#10b981"; # Classic terminal green
      };

      # Clean, functional top bar layout
      bar = {
        position = "top";
        density = "compact";
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
