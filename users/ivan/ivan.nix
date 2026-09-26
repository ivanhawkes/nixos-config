{ config, lib, pkgs, ... }:

{
  imports = [
    ../../roles/user.nix
    ../../roles/desktop.nix
    ../../roles/utility.nix
    ../../roles/developer.nix
    ../../roles/media.nix
#    ../../roles/productivity.nix
#    ../../roles/electronic-design.nix
  ];
}