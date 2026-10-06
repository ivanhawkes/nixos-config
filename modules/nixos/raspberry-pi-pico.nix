{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    minicom
  ];
}
