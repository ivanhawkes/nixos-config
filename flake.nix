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

    # Worktrunk, improved workflow for git worktrees.
    worktrunk.url = "github:max-sixty/worktrunk";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,

      # Required by Codex.
      llm-agents,
      worktrunk,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        # Desktop with dedicated NVIDIA GPU
        lythir = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/lythir/configuration.nix
            ./users/ivan/ivan.nix
            ./modules/nixos/niri.nix

            # Inject Codex.
            # Overrides the package to grant rustc extra stack space so it doesn't segfault.
            {
              environment.systemPackages = [
                (llm-agents.packages.${system}.codex.overrideAttrs (oldAttrs: {
                  # Increases rustc stack limit from default to 128MB to prevent the SIGSEGV
                  RUST_MIN_STACK = "134217728";
                }))
              ];
            }

            home-manager.nixosModules.home-manager
            {
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.backupFileExtension = "backup";

              home-manager.users.ivan = {
                imports = [
                  inputs.noctalia.homeModules.default
                  ./users/ivan/home.nix
                  ./modules/home/niri.nix
                  ./modules/home/noctalia.nix
                ];
              };
            }
          ];
        };

        # Laptop/Secondary machine with Intel graphics
        socks = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/socks/configuration.nix
            ./users/ivan/ivan.nix
            ./modules/nixos/niri.nix

            # Inject Codex.
            {
              environment.systemPackages = [
                llm-agents.packages.${system}.codex
              ];
            }

            home-manager.nixosModules.home-manager
            {
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.backupFileExtension = "backup";

              home-manager.users.ivan = {
                imports = [
                  inputs.noctalia.homeModules.default
                  ./users/ivan/home.nix
                  ./modules/home/niri.nix
                  ./modules/home/noctalia.nix
                ];
              };
            }
          ];
        };

        # Server running in a VM on Proxmox.
        veronica = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/veronica/configuration.nix
            ./users/ivan/ivan.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.backupFileExtension = "backup";

              home-manager.users.ivan = ./users/ivan/home.nix;
            }
          ];
        };
      };
    };
}
