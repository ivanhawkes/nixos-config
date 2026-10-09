{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # The roles this machine performs (capabilities belong to the host,
    # not to individual users).
    ../../roles/desktop.nix
    ../../roles/audio-production.nix
    ../../roles/video-production.nix

    # Services every machine runs.
    ../../modules/nixos/nix.nix
    ../../modules/nixos/ssh.nix
  ];

  # NOTE: The following configuration will be applied to every machine.
  # Only put something here if it is universally needed.

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Keeps only the latest 10 generations.
  boot.loader.systemd-boot.configurationLimit = 10;

  # Hostname for this machine.
  networking.hostName = "socks";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  networking.wireless.iwd.enable = true;
  hardware.enableRedistributableFirmware = true;

  # Enable OpenGL / hardware graphics
  hardware.graphics = {
    enable = true;

    # Recommended for Steam / wine 32-bit games
    enable32Bit = true;
  };

  # Enable XWayland if you need apps like Steam or Discord.
  services.xserver.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Brisbane";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # GDM is kept as the display manager; the niri session (enabled via
  # flake.nix) is the desktop. GNOME is not installed as a desktop manager -
  # individual GNOME apps like Nautilus come from systemPackages below.
  services.displayManager.gdm.enable = true;

  # Add standard GNOME as your bulletproof fallback session.
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Enable the Docker daemon.
  virtualisation.docker.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install software every machine requires.
  environment.systemPackages = with pkgs; [
    # Formatting of Nix files.
    nixfmt

    # File manager (GNOME app, used with the niri session)
    nautilus

    # Makes Docker far easier to manage.
    docker-compose
  ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
}
