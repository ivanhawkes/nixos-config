{ pkgs, ... }: {

  # ── Force Home Manager's instance of Nixpkgs to accept unfree software ──
  nixpkgs.config.allowUnfree = true;

  # ── Declarative VSCode Theme & UI Configuration ──
  programs.vscode = {
    enable = true;    

    # Force Home Manager to use the FHS wrapper package
    # ILH: I have decided to not use the FHS wrapper for now, as it may introduce unnecessary complexity.
    #package = pkgs.vscode-fhs;
  };
}
