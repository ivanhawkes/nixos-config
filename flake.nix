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
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        # Matches the configuration for Lythir
        lythir = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/lythir/configuration.nix

            {
              # Use the "x86_64-linux" string directly
              environment.systemPackages = [ inputs.noctalia.packages.x86_64-linux.default ];
            }

            # ── Home Manager (per-user packages, e.g. TMOG) ──────────
            home-manager.nixosModules.home-manager
            {
              home-manager.useUserPackages = true;

              # Cleanly inject your flake inputs straight into Home Manager modules
              home-manager.extraSpecialArgs = { inherit inputs; };

              # Automatically backup conflicting files (e.g., config.kdl.backup)
              home-manager.backupFileExtension = "backup";

              # Revert this back to your clean, standard import path
              home-manager.users.ivan = import ./users/ivan/home.nix;

            }
          ];
        };
      };
    };
}
