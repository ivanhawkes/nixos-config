{ pkgs, ... }: {
  imports = [ ../modules/nixos/codex.nix ];
  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
    docker-compose
    claude-code
    # Both agents use bubblewrap for Linux sandboxing; Claude also needs socat.
    bubblewrap
    socat
  ];
  environment.etc."claude-code/managed-settings.json".text = builtins.toJSON {
    sandbox.enabled = true;
  };
  home-manager.users.ivan.imports = [ ../users/ivan/home/development.nix ];
}
