{
  description = "Multi-machine NixOS Configuration Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      # Matches the configuration for Lythir
      lythir = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/lythir/configuration.nix

          # ── Home Manager (per-user packages, e.g. TMOG) ──────────
          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.users.ivan = import ./users/ivan/home.nix;
          }
        ];
      };
    };
  };
}
