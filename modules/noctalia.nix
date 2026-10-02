{ config, pkgs, ... }:

{
  # ── Imports ───────────────────────────────────────────────
  imports = [
    # Import Noctalia's official home-manager module from flake inputs
    inputs.noctalia.homeModules.default
  ];

  environment.systemPackages = with pkgs; [
  ];
}
