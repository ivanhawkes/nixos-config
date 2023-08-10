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
  ];  
}