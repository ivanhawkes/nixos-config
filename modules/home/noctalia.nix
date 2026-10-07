{ pkgs, ... }:

{
  # ── Noctalia Shell Configuration (Catppuccin Mocha Glass Style) ──────
  programs.noctalia = {
    enable = true;
    settings = {
      # Bypasses the .setup-complete marker file check on startup.
      setup_wizard_enabled = false;

      # Sets the primary font family for all shell UI text.
      # These can also be overridden in individual settings blocks for each widget.
      font_family = "JetBrainsMono Nerd Font";
      font_scale = 1.25; # Multiplies text size independently of the icon (0.2–2.5)
      font_weight = 700; # CSS weight style (100–1000)

      # The unified Catppuccin Mocha Desktop Palette. Noctalia 5.x ships a
      # built-in Catppuccin palette (Mocha), so we select it instead of
      # hand-rolling the colors.
      theme = {
        source = "builtin";
        builtin = "Catppuccin";
        mode = "dark";
      };

      # Noctalia 5.2 bar schema: bars are named sections ([bar.default]) and
      # widget lists are plain arrays of kebab-case widget ids. Per-widget
      # settings live in top-level [widget.<name>] sections, not inline.
      # (The old [[bar.widgets.left/right]] table format is no longer read —
      # it silently produced an empty bar.)
      bar.default = {
        position = "top";
        start = [
          "control-center"
          "workspaces" # numeric labels are the default (label_source = "id")
        ];
        center = [ "clock" ];
        end = [
          "network"
          "battery"
          "tray"
          "clipboard"
          "screenshot"
          "wallpaper"
          "session" # power glyph → session menu (lock / log out / reboot / shutdown)
        ];
      };

      # Clock format minimal, but functional.
      widget.clock = {
        format = "  %H:%M:%S";

        # Full date on hover.
        tooltip_format = "{:%A, %B %d, %Y}";
      };

      # Enable the weather service.
      weather = {
        enabled = true;
        unit = "metric";
        refresh_minutes = 30;
      };

      # Let the OS decide where I am located rather than doxing myself with a hard coded address.
      location = {
        auto_locate = true;
      };
    };
  };
}
