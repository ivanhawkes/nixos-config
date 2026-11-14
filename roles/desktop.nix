{ ... }: {
  imports = [
    ../modules/nixos/desktop.nix
    ../modules/nixos/niri.nix
  ];
  home-manager.users.ivan.imports = [ ../users/ivan/home/desktop.nix ];
}
