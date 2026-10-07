{ inputs, pkgs, ... }:

{
  # ── Niri Window Manager (system side) ─────────────────────
  programs.niri.enable = true;

  # Noctalia lock screen / shell, spawned by the niri config.
  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.system}.default

    # Niri integrates with xwayland-satellite automatically: it creates the
    # X11 socket, exports $DISPLAY, and spawns xwayland-satellite on demand
    # when an X11 client connects (restarting it if it dies).
    pkgs.xwayland-satellite
  ];
}
