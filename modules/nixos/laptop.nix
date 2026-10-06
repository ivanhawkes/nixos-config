{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./fonts.nix
  ];

  # Discord is an unfree application, covered by nixpkgs.config.allowUnfree
  # in the host configuration.

  environment.systemPackages = with pkgs; [
    # Dotfile management.
    stow

    # Communications.
    discord

    # Artwork.
    krita
    inkscape

    # Modelling.
    blender
    freecad

    # Electronic design.
    kicad

    # Video playback.
    vlc
  ];

  hardware.enableAllFirmware = true;
  services.samba.enable = true;
}
