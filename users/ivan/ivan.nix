{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."ivan" = {
    isNormalUser = true;
    description = "Ivan Hawkes";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "dialout"
      "plugdev"
      "docker"
    ];
    # If you don't already have it here, you can also keep or add:
    home = "/home/ivan";
    shell = pkgs.zsh;
  };

  # Make sure Zsh is listed in valid system shells
  environment.shells = [ pkgs.zsh ];

  # Enable and configure Zsh.
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    ohMyZsh = {
      enable = true;
      plugins = [
        "sudo"
        "git"
        "history"
        "alias-finder"
        "docker"
        "docker-compose"
        "colored-man-pages"
        "command-not-found"
      ];
      
      # Starship and Alacritty are setting the theme. 
      theme = "";
    };    
  };

  # Direnv automatically opens the developer environment shell if a directory has one.
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  environment.systemPackages = with pkgs; [
    devenv
  ];
}
