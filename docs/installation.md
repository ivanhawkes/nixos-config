# Installation and adding a host

Start with a working NixOS installation and enable `nix-command` and `flakes`.
Clone this repository and obtain your SSH credentials through your normal secure
process. The account module defines Ivan's account; set its password separately
and provision authorized SSH keys before relying on remote access.

1. Create `hosts/<name>/` and copy the installed machine's actual
   `/etc/nixos/hardware-configuration.nix` into it. Do not copy disk UUIDs from
   another host or overwrite a working installation's hardware scan.
2. Create `configuration.nix`, importing the hardware file and `roles/common.nix`.
   Select other roles and a bootloader appropriate to that machine explicitly.
3. Set `networking.hostName` and the installation's original `system.stateVersion`.
   Do not change state versions merely to upgrade package releases.
4. Register the host using `mkHost` in `flake.nix`. The host is then included in
   the system build checks automatically. Adapt the helper for other platforms.
5. Add new files to Git's index (or use intent-to-add) so the flake can see them.
6. Evaluate with `nix flake check --no-build`, then build that host:

```sh
nix build .#nixosConfigurations.NAME.config.system.build.toplevel
sudo nixos-rebuild test --flake .#NAME
sudo nixos-rebuild switch --flake .#NAME
```

Use the actual host name in place of `NAME`. Build and activate only on suitable
hardware. Keep a known working boot generation available while testing changes.

Veronica is not ready for these steps; see [the deferred checklist](TODO.md).
