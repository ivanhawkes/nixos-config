# SSH server, enabled on every host.
# Login is restricted to public-key authentication: no password or
# keyboard-interactive logins, and no root login.
{
  services.openssh = {
    enable = true;

    # Don't open port 22 to everyone; the firewall rules below restrict
    # SSH to local network traffic only.
    openFirewall = false;

    settings = {
      # Keys only: no password or keyboard-interactive authentication.
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;

      # Root cannot log in at all.
      PermitRootLogin = "no";
    };
  };

  # Open the firewall to SSH, but only for local network traffic (the
  # private LAN ranges). Loopback is already trusted by the firewall.
  # Note: iptables-backend specific; rewrite if the firewall backend changes.
  networking.firewall.extraCommands = ''
    iptables -A nixos-fw -p tcp --dport 22 -s 192.168.0.0/16 -j nixos-fw-accept
    iptables -A nixos-fw -p tcp --dport 22 -s 10.0.0.0/8 -j nixos-fw-accept
    iptables -A nixos-fw -p tcp --dport 22 -s 172.16.0.0/12 -j nixos-fw-accept
    ip6tables -A nixos-fw -p tcp --dport 22 -s fd00::/8 -j nixos-fw-accept
  '';
}
