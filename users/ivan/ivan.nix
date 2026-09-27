{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../../roles/user.nix
    ../../roles/desktop.nix
    ../../roles/utility.nix
    ../../roles/developer.nix
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."ivan" = {
    isNormalUser = true;
    description = "Ivan Hawkes";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "plugdev"
      "docker"
    ];
    packages = with pkgs; [
      firefox
      kicad
      freecad
      #libreoffice-qt

      # Formatting of Nix files.
      nixfmt
    ];
  };

  # Set Zsh as the default shell for your user
  users.users.ivan = {
    shell = pkgs.zsh;
  };

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
