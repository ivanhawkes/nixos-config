{ pkgs, ... }:
{
  imports = [ ../modules/nixos/blender.nix ];
  environment.systemPackages = with pkgs; [
    krita
    inkscape
    freecad
    kicad
  ];
}
