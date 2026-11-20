{ pkgs, inputs, ... }: {
  imports = [ ../modules/nixos/codex.nix ];
  virtualisation.docker.enable = true;

  # VS Code extensions ship binaries built for generic Linux (CodeLLDB's adapter, the C/C++
  # extension's debugger); nix-ld gives them a loader and the common libraries they link.
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    # Git and GitHub CLI for version control and repository management.
    git
    git-lfs
    gh

    # LazyGit for an enhanced Git experience on the command line.
    lazygit

    # Claude Code - using overlays
#    claude-code
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code

    # Claude Code requires bubblewrap and socat for sandboxing.
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
  
    # Record the terminal and produce video from it.
    asciinema
    asciinema-agg
    ffmpeg

    # Docker Compose for managing multi-container Docker applications.
    docker-compose
  ];

  environment.etc."claude-code/managed-settings.json".text = builtins.toJSON {
    sandbox.enabled = true;
    # Xvfb writes its lock (/tmp/.X<n>-lock) and socket (/tmp/.X11-unix) under /tmp itself, and the
    # headless test scripts wait on that lock, so a narrower path cannot work.
    # Manifest is the sibling game repository Jettison's sessions also edit, commit and push.
    sandbox.filesystem.allowWrite = [
      "/home/ivan/.cache/ccache"
      "/home/ivan/.cache/jettison"
      "/tmp"
      "/home/ivan/projects/manifest"
    ];

    # Xvfb's listening socket and the ssh agent (for git push) are Unix sockets; any socket is allowed.
    sandbox.network.allowAllUnixSockets = true;
    # git push over ssh.
    sandbox.network.allowedDomains = [
      "github.com"
      "release-assets.githubusercontent.com"
    ];
  };

  home-manager.users.ivan.imports = [ ../users/ivan/home/development.nix ];
}
