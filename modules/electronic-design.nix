{ pkgs, ... }:

{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    kicad
  ];
}
