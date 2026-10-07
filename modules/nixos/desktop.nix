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

    # Wayland clipboard copy and paste at the command line.
    wl-clipboard

    # Needed in order for Gnome Nautilus to browse network shares.
    nautilus
    samba # Provides the smbclient libraries needed for network interaction
    cifs-utils # Under-the-hood SMB mounting utilities
  ];

  services.gvfs = {
    enable = true;
    package = pkgs.gnome.gvfs; # Explicitly pulls in the GNOME version with SMB support
  };

  hardware.enableAllFirmware = true;

  # Nautilus' Network view browses other machines via libsmbclient (bundled
  # with nautilus), which does its own NetBIOS queries. The default firewall
  # drops the incoming replies (UDP 137/138) to our broadcast queries, so
  # allow them or the Network view stays empty.
  #
  # Samba runs deliberately minimal: nmbd answers name queries so lythir is
  # visible in other machines' browse lists, but smbd and winbindd stay off,
  # so no machine can open an SMB connection to lythir or see any shares.
  services.samba = {
    enable = true;
    smbd.enable = false;
    winbindd.enable = false;
  };
  networking.firewall.allowedUDPPorts = [
    137
    138
  ];
}
