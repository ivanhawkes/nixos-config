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
        ];
      };

      widget.clock.format = "%H:%M:%S // %Y-%m-%d";
    };
  };
}
