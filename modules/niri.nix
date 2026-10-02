{ config, pkgs, ... }:

{
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite

    # Add your preferred terminal (e.g., Alacritty, Kitty) and launcher here
  ];
}
