{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Get some useful fonts.
    hack-font
  ];  


  fonts.fontconfig = {
    defaultFonts = {
      monospace = [ "Io Mono" ];
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
    };
    allowBitmaps = false;
    allowType1 = false;
    includeUserConf = false;
  };
}