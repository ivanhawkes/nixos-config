{ pkgs, ... }: {
  # ── Declarative VSCodium Theme & UI Configuration ──
  # 👈 Fix: Changed from programs.vscode to programs.vscodium to handle paths properly
  programs.vscodium = {
    enable = true;

    # 👈 Fix: Nesting configuration under profiles.default to clean up option warnings
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
      ];

      userSettings = {
        # ── Theme & Appearance ──
        "workbench.colorTheme" = "Catppuccin Mocha";
        "catppuccin.accentColor" = "mauve"; 
        "workbench.iconTheme" = "catppuccin-mocha";
        "window.titleBarStyle" = "custom"; 

        # ── Typography & Font Scaling ──
        "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
        "editor.fontSize" = 16;       
        "editor.lineHeight" = 26;     
        "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font'";
        "terminal.integrated.fontSize" = 14;

        # ── Modern UI Visual Cleanups ──
        "editor.fontLigatures" = true;       
        "editor.minimap.enabled" = false;    
        "editor.scrollbar.vertical" = "hidden"; 
        "editor.scrollbar.horizontal" = "hidden";
        "workbench.activityBar.location" = "top"; 
        "editor.lineNumbers" = "relative";   
        "editor.cursorBlinking" = "smooth";  
        "editor.cursorSmoothCaretAnimation" = "on";
      };
    };
  };
}
