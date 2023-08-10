{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Standard free office suite.
    libreoffice-qt
  ];  
}