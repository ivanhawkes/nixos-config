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

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      catppuccin,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # ── 1. Isolated Dev Shell for Pi ───────────────────────
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.git
          pkgs.git-lfs
          pkgs.nodejs_latest
          pkgs.pi-coding-agent
        ];

        shellHook = ''
          # Isolate npm paths to prevent NixOS global write permission issues
          export NPM_CONFIG_PREFIX="$PWD/.pi/npm"
          export PATH="$PWD/.pi/npm/bin:$PATH"
          
          echo "⚡ Pi Configuration Workspace Loaded!"
          echo "👉 Run 'pi install -l npm:@baryonlabs/pi-agent-harness' to begin."
        '';
      };

      # ── 2. Your Existing Configurations ────────────────────
      nixosConfigurations = {
        lythir = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/lythir/configuration.nix
            ./users/ivan/ivan.nix 

            {
              environment.systemPackages = [ inputs.noctalia.packages.${system}.default ];
              programs.niri.enable = true; 
            }

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
