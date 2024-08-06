{ config, lib, pkgs, ... }:

{
#  environment.systemPackages = with pkgs; [
#    # Get some useful fonts.
#    hack-font
#  ];  


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
    hack-font
    font-awesome
    
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
];
}
