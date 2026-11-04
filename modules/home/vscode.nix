{ pkgs, ... }: {

  # ── Force Home Manager's instance of Nixpkgs to accept unfree software ──
  nixpkgs.config.allowUnfree = true;

  # ── Declarative VSCode Theme & UI Configuration ──
  programs.vscode = {
    enable = true;    
  };
}
