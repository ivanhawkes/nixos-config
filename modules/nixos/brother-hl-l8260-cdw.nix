{ pkgs, ... }:

{
  services.printing = {
    enable = true;
    startWhenNeeded = false; # Keeps CUPS running persistently
    webInterface = true;     # Forces the http://localhost:631 web interface to load
    drivers = with pkgs; [ cups-filters brgenml1cupswrapper brgenml1lpr ];
  };

  # Enable Avahi for network auto-discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
