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

  # Discord is an unfree application.
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
    ];

  environment.systemPackages = with pkgs; [
    # Code editor.
    vscodium

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
