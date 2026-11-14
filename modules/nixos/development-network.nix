{
  config,
  lib,
  pkgs,
  ...
}:
let
  ports = "80,443,8080";
  rule = "-p tcp -m multiport --dports ${ports} -j nixos-fw-accept";
  open = pkgs.writeShellApplication {
    name = "development-ports-open";
    runtimeInputs = [ pkgs.iptables ];
    text = ''
      for tool in iptables ip6tables; do
        if ! "$tool" -w -C nixos-fw ${rule} 2>/dev/null; then
          "$tool" -w -I nixos-fw 1 ${rule}
        fi
      done
    '';
  };
  close = pkgs.writeShellApplication {
    name = "development-ports-close";
    runtimeInputs = [ pkgs.iptables ];
    text = ''
      for tool in iptables ip6tables; do
        if "$tool" -w -C nixos-fw ${rule} 2>/dev/null; then
          "$tool" -w -D nixos-fw ${rule}
        fi
      done
    '';
  };
in
{
  assertions = [
    {
      assertion = config.networking.firewall.enable && !config.networking.nftables.enable;
      message = "Development ports require the enabled iptables NixOS firewall.";
    }
  ];
  # NixOS reloads its firewall during rebuilds without restarting dependents.
  # Restore temporary rules only when the user already opened this service.
  networking.firewall.extraCommands = ''
    if ${pkgs.systemd}/bin/systemctl is-active --quiet development-ports.service; then
      ${lib.getExe open}
    fi
  '';
  # No wantedBy: ports start closed after boot. Restart with the firewall if
  # the service was manually opened, so its reported state stays accurate.
  systemd.services.development-ports = {
    description = "Temporary development access on TCP 80, 443 and 8080";
    requires = [ "firewall.service" ];
    after = [ "firewall.service" ];
    partOf = [ "firewall.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = lib.getExe open;
      ExecStop = lib.getExe close;
      # Also undo partial setup if either address family fails during startup.
      ExecStopPost = lib.getExe close;
    };
  };
  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "dev-ports";
      runtimeInputs = [
        pkgs.systemd
        pkgs.sudo
      ];
      text = ''
        case "''${1:-status}" in
          open) sudo systemctl start development-ports.service ;;
          close) sudo systemctl stop development-ports.service ;;
          status) systemctl status development-ports.service ;;
          *) echo "Usage: dev-ports [open|close|status]" >&2; exit 2 ;;
        esac
      '';
    })
  ];
}
