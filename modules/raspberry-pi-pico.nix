{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # XXX
    minicom
  ];
 }