{ config, lib, pkgs, ... }:

{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    # Retrieve files from the internet.
    wget
    curl
    
    # Monitor the system.
    htop
    btop

    # Manage code and configuration.
    git
    git-lfs
  ];  
}
