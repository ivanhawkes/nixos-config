{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bambu-studio
    orca-slicer
  ];
}
