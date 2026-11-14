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
      helperScripts = import ./packages/helper-scripts.nix { inherit pkgs; };
    in
    {
      nixosConfigurations = hosts;
      formatter.${system} = pkgs.nixfmt-tree;
      packages.${system} = helperScripts;
      checks.${system} = builtins.mapAttrs (_: host: host.config.system.build.toplevel) hosts // {
        helper-scripts = pkgs.linkFarm "helper-scripts" (
          nixpkgs.lib.mapAttrsToList (name: path: {
            inherit name path;
          }) helperScripts
        );
        configuration-policy =
          let
            lythir = hosts.lythir.config;
            socks = hosts.socks.config;
          in
          assert builtins.all (h: !h.services.desktopManager.gnome.enable && h.programs.niri.enable) [
            lythir
            socks
          ];
          assert builtins.all
            (
              h:
              builtins.all (port: !(builtins.elem port h.networking.firewall.allowedTCPPorts)) [
                80
                443
                8080
              ]
            )
            [
              lythir
              socks
            ];
          assert lythir.systemd.services ? development-ports;
          assert !(socks.systemd.services ? development-ports);
          assert lythir.systemd.services.development-ports.wantedBy == [ ];
          assert
            !(nixpkgs.lib.hasInfix "LG Electronics"
              socks.home-manager.users.ivan.xdg.configFile."niri/config.kdl".text
            );
          assert nixpkgs.lib.hasInfix "LG Electronics"
            lythir.home-manager.users.ivan.xdg.configFile."niri/config.kdl".text;
          pkgs.runCommand "configuration-policy" { } "touch $out";
        formatting = pkgs.runCommand "nix-formatting" { nativeBuildInputs = [ pkgs.nixfmt ]; } ''
          cd ${self}
          find . -name '*.nix' -type f -print0 | xargs -0 nixfmt --check
          touch $out
        '';
      };
    };
}
