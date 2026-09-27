{
  config,
  lib,
  pkgs,
  ...
}:

{
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

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    hack-font
  ];
}
