{ pkgs, ... }: {
  # ── Declarative VSCodium Theme & UI Configuration ──
  programs.vscodium = {
    enable = true;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
      ];

      userSettings = {
        # ── Global UI Scaling Factor ──
        "window.zoomLevel" = 1; # 👈 Scales the entire application UI layout up by exactly 1.25x

        # ── Theme & Custom Color Overrides ──
        "workbench.colorTheme" = "Catppuccin Mocha";
        "catppuccin.accentColor" = "mauve";
        "workbench.iconTheme" = "catppuccin-mocha";
        "window.titleBarStyle" = "custom";

        # ── Customizing UI Colors to Match Your Setup ──
        "workbench.colorCustomizations" = {
          "editor.background" = "#11111b";
          "sideBar.background" = "#11111b";
          "activityBar.background" = "#11111b";
          "statusBar.background" = "#11111b";
          "titleBar.activeBackground" = "#11111b";
          "activityBar.activeBorder" = "#cba6f7";
          "statusBar.foreground" = "#cdd6f4";
        };

        # ── Internal Element Rounding & Border Tweaks ──
        "window.dialogStyle" = "custom";
        "chat.editor.fontFamily" = "'JetBrainsMono Nerd Font'";

        # ── Typography & Font Scaling (32" 1440p Monitor Optimization) ──
        "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
        "editor.fontSize" = 14;
        "editor.lineHeight" = 26;
        "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font'";
        "terminal.integrated.fontSize" = 14;

        # ── Modern UI Visual Cleanups (Minimalist Layout) ──
        "editor.fontLigatures" = true;
        "editor.minimap.enabled" = false;
        "editor.scrollbar.vertical" = "hidden";
        "editor.scrollbar.horizontal" = "hidden";
        "workbench.activityBar.location" = "top";
        "editor.cursorBlinking" = "smooth";
        "editor.cursorSmoothCaretAnimation" = "off";

        "workbench.sideBar.location" = "right";
        "window.menuBarVisibility" = "classic";
        "editor.lineDecorationsWidth" = 6;
        # "editor.lineNumbers" = "relative";
        "editor.lineNumbers" = "off";
      };
    };
  };
}
