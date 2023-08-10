{ config, lib, pkgs, ... }:

{
  imports = [
    ../roles/user.nix
    ../roles/developer.nix
    ../roles/desktop.nix
    ../roles/productivity.nix
    ../roles/media.nix
  ];
}