{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Very useful for enumerating all the system specifications.
    fastfetch

    # Retrieve files from the internet.
    wget
    curl

    # Monitor the system.
    htop
    btop
  ];
}
