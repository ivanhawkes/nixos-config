{ pkgs, ... }:

{
  home.stateVersion = "26.05";
  home.username = "ivan";
  home.homeDirectory = "/home/ivan";

  imports = [
    # Core system tools and universal application configs
    ../../modules/home/alacrity.nix
    ../../modules/home/fuzzel.nix
    ../../modules/home/tmog.nix
    ../../modules/home/theme.nix
    ../../modules/home/codium.nix
    ../../modules/home/starship.nix
    ../../modules/home/brave.nix
    ../../modules/home/fast-fetch.nix
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
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };
}
