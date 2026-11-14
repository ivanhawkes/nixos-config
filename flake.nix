{
  description = "Multi-machine NixOS Configuration Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Required by Codex.
    llm-agents.url = "github:numtide/llm-agents.nix";

    codex-desktop-linux = {
      url = "github:ilysenko/codex-desktop-linux";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "worktrunk/flake-utils";
    };

    # Worktrunk, improved workflow for git worktrees.
    worktrunk.url = "github:max-sixty/worktrunk";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      mkHost =
        name:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ (./hosts + "/${name}/configuration.nix") ];
        };
      hosts = {
        lythir = mkHost "lythir";
        socks = mkHost "socks";
      };
      pkgs = import nixpkgs { inherit system; };
    in
    {
      nixosConfigurations = hosts;
      formatter.${system} = pkgs.nixfmt-tree;
      checks.${system} = builtins.mapAttrs (_: host: host.config.system.build.toplevel) hosts // {
        formatting = pkgs.runCommand "nix-formatting" { nativeBuildInputs = [ pkgs.nixfmt ]; } ''
          cd ${self}
          find . -name '*.nix' -type f -print0 | xargs -0 nixfmt --check
          touch $out
        '';
      };
    };
}
