# Deferred work

## Veronica: revisit when the VM exists

Veronica does not exist yet. Its hardware file intentionally remains a copy of
Socks as a placeholder. It is excluded from `nixosConfigurations` and build checks.

Before enabling it:

- Create the Proxmox VM and generate its real hardware configuration. Replace all
  copied filesystem UUIDs, kernel modules and CPU settings.
- Choose the VM's bootloader, network setup and guest-agent integration.
- Set the actual installation state version and define the server's services,
  storage, firewall policy and backup/restore requirements.
- Add a server role when there are concrete services to compose. The current
  draft imports only the common baseline and no graphical/production workloads.
- Register it in `flake.nix`, build it and test boot and SSH access on the VM.

## Project development environments

Move manually installed Vulkan, Quartus, Node tooling and Pico SDK environments
into their owning projects' development shells where practical. The existing
compatibility exports live in `users/ivan/home/development.nix`; versions and
project requirements need to be established before replacing them. A separate
Python/Rust/Go scratch environment now lives at `~/projects/workbench`; it does
not replace project-specific devenv configurations.

## TMOG

Recheck for a maintained nixpkgs or upstream Nix package in future. The current
launcher still uses a manually installed official AppImage; see maintenance notes.
