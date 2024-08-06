{ config, lib, pkgs, ... }:

{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    # Basic shell utilities.
    wget
    curl
    htop
    direnv

    # Pretty print machine info at the command line.
    neofetch

    # Make use of the USB utilities.
    usbutils
    
    # Load firmware into devices in user space.
    fxload

    # Manage your dotfiles.
    stow
  ];  
}
