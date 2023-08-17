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

    # Make use of the USB utilities.
    usbutils
    
    # Load firmware into devices in user space.
    fxload
  ];  
}