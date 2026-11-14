{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../roles/common.nix
    ../../modules/nixos/uefi-boot.nix
    ../../roles/desktop.nix
    ../../roles/development.nix
    ../../roles/creative.nix
    ../../roles/fabrication.nix
    ../../roles/audio-production.nix
    ../../roles/video-production.nix
    ../../roles/gaming.nix
    ../../modules/nixos/network-browsing.nix
    ../../modules/nixos/development-network.nix
    ../../modules/nixos/brother-hl-l8260-cdw.nix
  ];
  networking.hostName = "lythir";
  boot.supportedFilesystems = [ "ntfs" ];
  # Lock the DRM device for Wayland compositors.
  environment.variables.WLR_DRM_DEVICES = "/dev/dri/by-path/pci-0000:0c:00.0-card";

  # Enable LACT and its systemd daemon service
  services.lact.enable = true;

  # Tell Xserver/Wayland to use the nvidia driver alongside modesetting
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting is required for most modern WMs/DEs (Wayland and X11)
    modesetting.enable = true;

    powerManagement.enable = true;
    powerManagement.finegrained = false;

    # Set to false to use the fully proprietary kernel module instead of the open-source kernel module variant.
    # Note: RTX 40-series and 50-series support the open kernel modules (`open = true`),
    # but setting `open = false` strictly forces the completely proprietary kernel module.
    open = true;

    # Enable the nvidia-settings utility
    nvidiaSettings = true;

    # Select driver package (stable, latest, etc)
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  # Enable Bluetooth support.
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
    input = {
      General = {
        UserspaceHID = true;
      };
    };
  };

  programs.gpu-screen-recorder.enable = true;
  environment.systemPackages = [ pkgs.lact ];
  # Installation compatibility baseline; do not bump on upgrades.
  system.stateVersion = "26.05";
}
