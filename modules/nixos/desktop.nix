{ pkgs, ... }: {
  imports = [ ./fonts.nix ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.enableAllFirmware = true;
  services.xserver = {
    enable = true;
    xkb.layout = "au";
  };
  programs.firefox.enable = true;
  # Battery reporting is needed by Noctalia without the GNOME desktop.
  services.upower.enable = true;
  environment.systemPackages = with pkgs; [
    stow
    discord
    vlc
    wl-clipboard
    nautilus
    google-chrome
    sound-theme-freedesktop
  ];
  environment.pathsToLink = [ "/share/sounds" ];
}
