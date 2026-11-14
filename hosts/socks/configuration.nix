{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../roles/common.nix
    ../../modules/nixos/uefi-boot.nix
    ../../roles/desktop.nix
    ../../roles/development.nix
    ../../roles/creative.nix
    ../../roles/audio-production.nix
    ../../roles/video-production.nix
    ../../modules/nixos/network-browsing.nix
    ../../modules/nixos/brother-hl-l8260-cdw.nix
  ];
  networking.hostName = "socks";
  # Keep laptop power controls independently of the removed GNOME session.
  services.power-profiles-daemon.enable = true;
  hardware.enableRedistributableFirmware = true;
  hardware.wirelessRegulatoryDatabase = true;
  boot.extraModprobeConfig = ''
    options cfg80211 ieee80211_regdom="AU"
  '';
  # Installation compatibility baseline; do not bump on upgrades.
  system.stateVersion = "26.05";
}
