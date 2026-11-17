{ pkgs, ... }: {
  imports = [ ../modules/nixos/codex.nix ];
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    # Git and GitHub CLI for version control and repository management.
    git
    git-lfs
    gh

    # LazyGit for an enhanced Git experience on the command line.
    lazygit
    
    # Claude Code requires bubblewrap and socat for sandboxing.
    claude-code
    bubblewrap
    socat

    # Pi Coding Agent - simple, light, customise for the project.
    pi-coding-agent

    # Bring worktrunk into the project.
    worktrunk

    # Go programming language.
    go

    # Useful command-line utilities for searching, filtering, and viewing files.
    ripgrep
    fd
    fzf
    bat
    eza
    tree
    jq
    yq-go

    # Docker Compose for managing multi-container Docker applications.
    docker-compose
  ];

  environment.etc."claude-code/managed-settings.json".text = builtins.toJSON {
    sandbox.enabled = true;
    # Xvfb writes its lock (/tmp/.X<n>-lock) and socket (/tmp/.X11-unix) under /tmp itself, and the
    # headless test scripts wait on that lock, so a narrower path cannot work.
    sandbox.filesystem.allowWrite = [ "/home/ivan/.cache/ccache" "/tmp" ];
  };

  home-manager.users.ivan.imports = [ ../users/ivan/home/development.nix ];
}
