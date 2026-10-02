{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./fonts.nix
    # ./codium.nix
  ];

  # Discord is an unfree application, covered by nixpkgs.config.allowUnfree
  # in the host configuration.

  environment.systemPackages = with pkgs; [
    # Code editor.
    # vscodium

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
