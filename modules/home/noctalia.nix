{ pkgs, ... }:

{
  # ── Noctalia Shell Configuration (Catppuccin Mocha Glass Style) ──────
  programs.noctalia = {
    enable = true;
    settings = {
      # The unified Catppuccin Mocha Desktop Palette. Noctalia 5.x ships a
      # built-in Catppuccin palette (Mocha), so we select it instead of
      # hand-rolling the colors.
      theme = {
        source = "builtin";
        builtin = "Catppuccin";
        mode = "dark";
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
