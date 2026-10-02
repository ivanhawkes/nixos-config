{ pkgs, ... }:

{
  # Install the package.
  environment.systemPackages = with pkgs; [
    reaper
  ];
}
