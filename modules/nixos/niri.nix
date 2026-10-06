{ inputs, pkgs, ... }:

{
  # ── Niri Window Manager (system side) ─────────────────────
  programs.niri.enable = true;

  # Noctalia lock screen / shell, spawned by the niri config.
  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.system}.default
  ];
}
