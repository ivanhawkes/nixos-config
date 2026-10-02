# My personal NixOS configuration.

Flake-based, multi-machine configuration. The current active host is
**lythir** (AMD + NVIDIA, niri/Noctalia desktop).

## Layout

```
flake.nix            Entry point: nixosConfigurations, devShell, inputs
hosts/<name>/        Per-machine configuration.nix + hardware-configuration.nix
roles/               Workload bundles (desktop, developer, audio/video production, server)
modules/             Reusable NixOS / home-manager modules (fonts, alacritty, niri, ...)
users/ivan/          ivan.nix (NixOS user + zsh), home.nix (home-manager entry)
devenv.nix, devenv.yaml, .envrc   Devenv + direnv environment for the Pi agent harness
```

Layering: `flake.nix` → `hosts/<machine>/configuration.nix` (system-wide) →
`users/ivan/ivan.nix` (user account, shell, role imports) → roles → modules.
Per-user desktop configuration (alacritty, niri, fuzzel, noctalia, tmog,
theme) lives in `users/ivan/home.nix` via home-manager.

## Building / updating

```bash
# Build and apply this configuration.
sudo nixos-rebuild switch --flake .#lythir

# Try it without making it the default boot.
sudo nixos-rebuild test --flake .#lythir

# Update nixpkgs and switch.
nix flake update
sudo nixos-rebuild switch --flake .#lythir
```

The flake tracks `nixos-unstable`. Optional auto-updates:

```nix
system.autoUpgrade.enable = true;
system.autoUpgrade.allowReboot = false;
```

Rebuilding home-manager only (no OS rebuild):

```bash
home-manager rebuild
```

## Getting my SSH keys.

```bash
cd ~
scp ivan@<<SECRETS>>:/home/ivan/.ssh/* ~/.ssh
```

## Adding a new machine.

```bash
export MACHINE=<<MACHINE_NAME>>
mkdir -p hosts/$MACHINE
```

1. On the new machine, run `sudo nixos-generate-config --force` and copy
   `/etc/nixos/hardware-configuration.nix` into `hosts/$MACHINE/`.
2. Copy an existing `hosts/<name>/configuration.nix` as a starting point,
   change `networking.hostName`, and adjust the hardware sections
   (NVIDIA/AMD, root device UUID, etc.).
3. Register the new machine in `flake.nix` under `nixosConfigurations`.
4. Build it: `sudo nixos-rebuild switch --flake .#<MACHINE>`.

Always back up `/etc/nixos/` before the first rebuild on a new machine.

## Git config

```bash
git config --global user.email "ivan.hawkes@gmail.com"
git config --global user.name "Ivan Hawkes"
git config --global init.defaultBranch main
```

## Desktop (lythir)

- Display manager: GDM (`services.displayManager.gdm.enable`).
- Session: **niri** (`programs.niri.enable` in `flake.nix`), themed with
  **Noctalia** (see `modules/noctalia.nix`).
- GNOME is not installed as a desktop; individual GNOME apps (Nautilus) are
  in `environment.systemPackages` in `hosts/lythir/configuration.nix`.
- Terminal: Alacritty (`modules/alacritty.nix`), launcher: Fuzzel
  (`modules/fuzzel.nix`).
- Keybinding / window-manager tweaks: `modules/niri.nix`.

## Pi agent harness (devenv)

This folder doubles as a workspace for the Pi coding agent. Enter it with
direnv (`.envrc`) or:

```bash
nix develop            # devShell from flake.nix (node + pi)
devenv shell           # or via devenv.nix
```

Then run `harness-init` (or `pi install -l npm:@baryonlabs/pi-agent-harness`)
once per checkout. The `.pi/` folder is local-only and gitignored.
