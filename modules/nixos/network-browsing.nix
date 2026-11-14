{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    samba
    cifs-utils
  ];
  services.gvfs = {
    enable = true;
    package = pkgs.gvfs;
  };
  # NetBIOS discovery only; file sharing and winbind remain disabled.
  services.samba = {
    enable = true;
    smbd.enable = false;
    winbindd.enable = false;
  };
  networking.firewall.allowedUDPPorts = [
    137
    138
  ];
}
