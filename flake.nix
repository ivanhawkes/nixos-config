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
      nixosConfigurations = {
        # Desktop with dedicated NVIDIA GPU
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

              # 💡 Fixed: We import home.nix AND inject the Niri/Noctalia modules here!
              home-manager.users.ivan = {
                imports = [
                  ./users/ivan/home.nix
                  inputs.noctalia.homeModules.default
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

            home-manager.nixosModules.home-manager
            {
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.backupFileExtension = "backup";

              # Socks only imports the basic configurations
#              home-manager.users.ivan = ./users/ivan/home.nix;


              # 💡 Experiment: We import home.nix AND inject the Niri/Noctalia modules here!
              home-manager.users.ivan = {
                imports = [
                  ./users/ivan/home.nix
                  inputs.noctalia.homeModules.default
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

              # Veronica only imports the basic configurations
              home-manager.users.ivan = ./users/ivan/home.nix;
            }
          ];
        };
      };
    };
}
