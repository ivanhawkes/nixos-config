# My personal NixOS configuration.

Flake-based, multi-machine configuration. The current active host is
**lythir** (AMD + NVIDIA, niri/Noctalia desktop).

## Layout

```
flake.nix            Entry point: nixosConfigurations + inputs (wiring only)
hosts/<name>/        Per-machine configuration.nix + hardware-configuration.nix
roles/               Workload bundles (desktop, developer, audio/video production, server)
modules/nixos/       Reusable NixOS modules (fonts, desktop, developer, ...)
modules/home/        Reusable home-manager modules (alacritty, niri, codium, ...)
users/ivan/          ivan.nix (NixOS user + zsh), home.nix (home-manager entry)
devenv.nix, devenv.yaml, .envrc   Devenv + direnv environment for the Pi agent harness
```

Layering: `flake.nix` → `hosts/<machine>/configuration.nix` (system-wide,
imports the machine's roles) → roles → `modules/nixos/…`.
The user account and shell live in `users/ivan/ivan.nix`; per-user desktop
configuration (alacritty, niri, fuzzel, noctalia, tmog, theme, codium)
lives in `users/ivan/home.nix` via home-manager, importing `modules/home/…`.

Where things go:

- **Roles** describe machine capabilities and are imported by the host,
  never by a user file.
- **System-wide services & tools** → host file or a role, in `modules/nixos/`.
- **Per-user apps & dotfiles** → `users/<user>/home.nix`, in `modules/home/`.
- A module lives in exactly one of `modules/nixos/` or `modules/home/`
  depending on which option namespace it sets — never both.

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
- Session: **niri** (`modules/nixos/niri.nix`), themed with
  **Noctalia** (see `modules/home/noctalia.nix`).
- GNOME is not installed as a desktop; individual GNOME apps (Nautilus) are
  in `environment.systemPackages` in `hosts/lythir/configuration.nix`.
- Terminal: Alacritty (`modules/home/alacritty.nix`), launcher: Fuzzel
  (`modules/home/fuzzel.nix`).
- Keybinding / window-manager tweaks: `modules/home/niri.nix`.

## Pi agent harness (devenv)

This folder doubles as a workspace for the Pi coding agent. Enter it with
direnv (`.envrc`) or:

```bash
devenv shell           # via devenv.nix (node + pi)
```

Then run `harness-init` (or `pi install -l npm:@baryonlabs/pi-agent-harness`)
once per checkout. The `.pi/` folder is local-only and gitignored.
