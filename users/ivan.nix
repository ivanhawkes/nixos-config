{ config, lib, pkgs, ... }:

{
  imports = [
    ../roles/desktop.nix
    ../roles/developer.nix
    ../roles/media.nix
    ../roles/productivity.nix
    ../roles/user.nix
    ../roles/utility.nix
  ];
}