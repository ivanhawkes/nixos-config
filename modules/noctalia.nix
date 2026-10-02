{ inputs, config, pkgs, ... }:

{
  imports = [
    # Any local Home Manager sub-modules could go here
  ];

  # Using home.packages so Home Manager can read it correctly
  home.packages = with pkgs; [
    # You can add user-specific packages here later
  ];
}
