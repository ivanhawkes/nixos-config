{ pkgs, ... }: {
  imports = [ ../modules/nixos/codex.nix ];
  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
    docker-compose
    claude-code
  ];
  home-manager.users.ivan.imports = [ ../users/ivan/home/development.nix ];
}
