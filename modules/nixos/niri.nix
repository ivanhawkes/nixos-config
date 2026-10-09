{ inputs, pkgs, ... }:

{
  # Enable the system-level Niri package and polkit integration.
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  # Ensure a Wayland-compatible display manager session exists.
  services.displayManager.gdm.enable = true;

  # Noctalia lock screen / shell, spawned by the niri config.
  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.system}.default

    # Niri integrates with xwayland-satellite automatically: it creates the
    # X11 socket, exports $DISPLAY, and spawns xwayland-satellite on demand
    # when an X11 client connects (restarting it if it dies).
    pkgs.xwayland-satellite
  ];

  # Optional: Add required plumbing for Wayland screen sharing / portals
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    config.common.default = [ "gnome" "wlr" ];
  };
}
