{ inputs, ... }: {
  imports = [
    inputs.noctalia.homeModules.default
    ../../../modules/home/alacritty.nix
    ../../../modules/home/fuzzel.nix
    ../../../modules/home/theme.nix
    ../../../modules/home/tmog.nix
    ../../../modules/home/niri.nix
    ../../../modules/home/noctalia.nix
  ];
  home.sessionVariables.QT_SCALE_FACTOR = "1.25";
  # mpv defaults to software decoding; auto-safe uses VA-API/NVDEC when it works.
  xdg.configFile."mpv/mpv.conf".text = "hwdec=auto-safe\n";
}
