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
    let
      system = "x86_64-linux";
    in
    {
      # Dev environment for the Pi agent harness lives in devenv.nix.

      # ── NixOS Configurations ───────────────────────────────
      nixosConfigurations = {
        lythir = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/lythir/configuration.nix
            ./users/ivan/ivan.nix
            ./modules/nixos/niri.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.backupFileExtension = "backup";
              home-manager.users.ivan = import ./users/ivan/home.nix;
            }
          ];
        };

        # ── Added socks configuration ──────────────────────────
        socks = nixpkgs.lib.nixosSystem {
          inherit system; # Assumes socks is also an x86_64-linux machine
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/socks/configuration.nix # You'll need to create this file
            ./users/ivan/ivan.nix
            # Add or remove other modules specific to socks here
            
            home-manager.nixosModules.home-manager
            {
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.backupFileExtension = "backup";
              home-manager.users.ivan = import ./users/ivan/home.nix;
            }
          ];
        };
      };
    };
}
