# Future Proxmox VM. Deliberately not exported by flake.nix yet.
# TODO: generate real VM hardware settings and decide server services before enabling.
{
  imports = [
    ./hardware-configuration.nix
    ../../roles/common.nix
  ];
  networking.hostName = "veronica";
  # TODO: set the installation stateVersion when the VM is created.
  system.stateVersion = "26.05";
}
