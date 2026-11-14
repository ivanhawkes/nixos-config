# Personal NixOS configuration

A pinned flake for two x86_64-linux Niri/Noctalia workstations.

| Host | Purpose | Status |
| --- | --- | --- |
| lythir | AMD/NVIDIA desktop; creative work, fabrication, gaming | Active |
| socks | Intel laptop; creative work and development | Configured; full GNOME desktop removed |
| veronica | Future Proxmox server VM | Draft only; not a flake output |

## Layout

```text
flake.nix                Inputs, host construction, formatter and build checks
hosts/<host>/            Explicit role selection and machine-specific settings
roles/                   Common baseline and workload bundles
modules/nixos/           Reusable services, desktop integration and hardware policy
modules/home/            Reusable per-user application configuration
users/ivan/account.nix   Account and system shell support
users/ivan/home/         Common, desktop and development Home Manager profiles
users/ivan/files/        Personal dotfiles
users/ivan/scripts/      Personal helper scripts
docs/                   Installation, maintenance, deferred tasks and background
```

Composition is explicit: the flake selects hosts, hosts select roles, and roles
compose NixOS modules and the appropriate Home Manager profiles. Shared modules
should not reference a particular user's files. Keep machine identifiers, driver
tuning and `system.stateVersion` in the host; keep `home.stateVersion` with the user.

The desktop role enables Niri, GDM, Nautilus and portal support. Individual GNOME
applications work without enabling the full GNOME desktop. Network browsing,
printing, creative applications and development listeners are separate imports.

## Routine commands

```sh
nix fmt
# Evaluate both supported hosts and all check derivations without building.
nix flake check --no-build
# Check formatting, then build both complete systems without activating them.
nix flake check
# Build only one host, without activation.
nix build .#nixosConfigurations.lythir.config.system.build.toplevel
# Apply when ready, on the intended host.
sudo nixos-rebuild switch --flake .#lythir
```

Home Manager is integrated with NixOS and is applied by the system rebuild.
There is no standalone Home Manager flake output.

- [Installation and adding a host](docs/installation.md)
- [Maintenance, desktop integration and local dependencies](docs/maintenance.md)
- [Deferred work, including Veronica](docs/TODO.md)
- [Personal background and AI disclosure](docs/background.md)

The optional Pi harness environment is defined in `devenv.nix` and entered using
`devenv shell` or direnv. Run `harness-init` to initialize its local packages;
`.pi/` is ignored. This environment is independent of the system flake lock.
