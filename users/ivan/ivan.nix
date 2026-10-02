{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../../roles/desktop.nix
    ../../roles/developer.nix
    ../../roles/audio-production.nix
    ../../roles/vidio-production.nix
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."ivan" = {
    isNormalUser = true;
    description = "Ivan Hawkes";
    group = "ivan"; # Fixes the second assertion error
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "plugdev"
      "docker"
    ];
    # If you don't already have it here, you can also keep or add:
    home = "/home/ivan";
    shell = pkgs.zsh;
  };

  # You also need to make sure the "ivan" group actually exists:
  users.groups.ivan = { };

  # Make sure Zsh is listed in valid system shells
  environment.shells = [ pkgs.zsh ];

  # Enable the Docker daemon.
  virtualisation.docker.enable = true;

  # Enable and configure Zsh + Oh My Zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "sudo"
        "docker"
        "docker-compose"
        "history"
        "alias-finder"
        "colored-man-pages"
        "command-not-found"
      ];
    };
  };
}
