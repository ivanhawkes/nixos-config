{ pkgs, ... }:

{
  home.stateVersion = "26.05";
  home.username = "ivan";
  home.homeDirectory = "/home/ivan";

  imports = [
    # Core system tools and universal application configs
    ../../modules/home/alacritty.nix
    ../../modules/home/fuzzel.nix
    ../../modules/home/tmog.nix
    ../../modules/home/theme.nix
    ../../modules/home/codium.nix
    ../../modules/home/starship.nix
    ../../modules/home/brave.nix
    ../../modules/home/fast-fetch.nix
    ../../modules/home/aliases.nix
    ../../modules/home/dotfiles.nix
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      user = {
        name = "Ivan Hawkes";
        email = "ivan@gmail.com";
      };

      core = {
        autocrlf = "input";
        eol = "lf";
      };

      submodule.recurse = true;
      fetch.recurseSubmodules = "on-demand";
      protocol.file.allow = "always";
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };

  # Direnv automatically opens the developer environment shell if a directory has one.
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Manually tell Nix to place the TOML configuration file
  xdg.configFile."direnv/direnv.toml".text = ''
    [global]
    hide_env_diff = true
    log_filter = "^$"

    [whitelist]
    prefix = [ "$(expand_path ~/projects)", "$(expand_path ~/worktrees)" ]
  '';
}
