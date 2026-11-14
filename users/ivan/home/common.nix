{ pkgs, config, ... }:

{
  home.stateVersion = "26.05";
  home.username = "ivan";
  home.homeDirectory = "/home/ivan";

  imports = [
    ../../../modules/home/starship.nix
    ../../../modules/home/fast-fetch.nix
    ./shell.nix
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
    prefix = [ "${config.home.homeDirectory}/projects", "${config.home.homeDirectory}/worktrees" ]
  '';
}
