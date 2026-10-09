{
  pkgs,
  inputs,
  lib,
  ...
}:

{
  # ── State Version & User Metadata ────────────────────────
  home.stateVersion = "26.05";
  home.username = "ivan";
  home.homeDirectory = "/home/ivan";

  imports = [
    inputs.noctalia.homeModules.default

    # Home Manager modules (per-user desktop configuration)
    ../../modules/home/alacrity.nix
    ../../modules/home/niri.nix
    ../../modules/home/fuzzel.nix
    ../../modules/home/noctalia.nix
    ../../modules/home/tmog.nix
    ../../modules/home/theme.nix
    ../../modules/home/codium.nix
    ../../modules/home/starship.nix
    ../../modules/home/brave.nix
    ../../modules/home/fast-fetch.nix
  ];

  # ── Permanently Configure Git & Git-LFS (Forcing LF Endings) ──
  programs.git = {
    enable = true;
    
    # Enables and automatically sets up git-lfs hooks for Ivan
    lfs.enable = true; 
    
    extraConfig = {
      core = {
        autocrlf = "input";
        eol = "lf";
      };
    };
  };

  # ── Elegantly Manage and Configure GitHub CLI (gh) ──
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh"; # Preferred protocol for Git operations
    };
  };
}
