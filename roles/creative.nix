{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    krita
    inkscape
    blender
    freecad
    kicad
  ];
}
