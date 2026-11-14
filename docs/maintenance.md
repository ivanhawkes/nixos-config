# Maintenance

## Validation and updates

`nix fmt` formats the repository's Nix files. `nix flake check --no-build`
evaluates all supported systems and checks. `nix flake check` builds both complete
systems and runs the formatting check without activating either machine. A
successful evaluation does not verify booting or graphical behavior.

```sh
nix flake update
nix flake check
sudo nixos-rebuild test --flake .#lythir
sudo nixos-rebuild switch --flake .#lythir
```

Use `socks` when targeting the laptop. Review the lockfile diff before activation.
The devenv harness uses its own lockfile and is updated separately.

## Desktop and applications

Niri and GDM are selected by `roles/desktop.nix`. Full GNOME desktop sessions are
not enabled. Nautilus is installed explicitly; `network-browsing.nix` provides
GVfs/SMB discovery, while the Brother module provides printing and discovery.
The Niri module owns the shared GNOME/GTK portal defaults. Test screen sharing,
file dialogs, locking and application launchers in a logged-in session after
activation. UPower is explicitly enabled for battery reporting, and Socks keeps
power-profiles-daemon for laptop power controls. Noctalia preferences and Niri keybindings are Home Manager modules.

Creative/CAD packages are in `roles/creative.nix`; slicers in `roles/fabrication.nix`.
The video role installs only the NVIDIA-capable HandBrake wrapper, avoiding two
competing copies of the same executables. Its driver path remains usable on
non-NVIDIA hosts, but NVENC requires NVIDIA hardware and driver support.

Only Lythir imports `modules/nixos/development-network.nix`. Development ports
start closed on boot; open them temporarily when running a listener:

```sh
dev-ports open      # sudo starts the service: TCP 80, 443 and 8080, IPv4 and IPv6
dev-ports status    # inspect the service; inactive status returns a nonzero exit
dev-ports close     # sudo stops the service and removes its rules
```

The rules allow inbound traffic from any source while open. They are removed on
stop or reboot. An active service follows firewall restarts and reloads so state and rules
remain consistent. Socks has neither the command nor the development port rules.
The module explicitly requires the iptables firewall backend. This does not
launch web/Strata services; start the required listener separately.

Lythir's monitor EDID and 1.25 scaling live in `hosts/lythir/home.nix`. Shared Niri
configuration contains no monitor-specific output rule; add a Socks home module
if it needs a display override later.

## Codex

`roles/development.nix` selects `modules/nixos/codex.nix`: the CLI comes from the
pinned `numtide/llm-agents.nix`, and the desktop from
[ilysenko/codex-desktop-linux](https://github.com/ilysenko/codex-desktop-linux).
The desktop retains its version-matched bundled app-server. The standalone CLI
keeps the build-time `RUST_MIN_STACK=134217728` workaround for the previously
observed rustc failure. `CODEX_OZONE_PLATFORM=auto` lets the pinned launcher choose
Wayland when available. Update the desktop pin with
`nix flake update codex-desktop-linux`, then build both hosts.

## TMOG and local toolchains

Checked on 2026-11-14: TMOG was not found in the pinned nixpkgs package sources,
the current [nixpkgs TM namespace](https://github.com/NixOS/nixpkgs/tree/master/pkgs/by-name/tm),
or as an upstream-maintained Nix package. Its [official project](https://tmog.org/)
distributes Linux binaries; the [upstream feedback repository](https://github.com/PlummersSoftwareLLC/tmog-feedback)
is an issue tracker, not a Nix package source. A third-party personal NixOS config
found in search wraps an official AppImage, which does not establish a maintained
package suitable for adding as a dependency here.

The existing launcher is retained and expects
`~/.local/opt/tmog/tmog.AppImage`. Install it from the official site; this binary
is not downloaded or pinned by the system flake. Revisit when a reputable Nix
package is available. The launcher now derives the path from the user's home.

Development shell compatibility exports still refer to manually installed SDKs.
These are documented in the development profile and should migrate into the
respective projects as their requirements become clear. The obsolete apt-based
`pico_setup.sh` has been deleted; cloning Pico libraries remains available.

## Helper scripts and OneDrive

Personal helper scripts live in `users/ivan/scripts/` and are packaged by
`packages/helper-scripts.nix` using `writeShellApplication`. Build-time ShellCheck
and syntax checks run automatically, and the wrappers supply their runtime tools
such as rclone, rsync, git/SSH and mnamer. The development Home Manager profile
installs all five commands, retaining their `.sh` names. The three previously
managed `~/.local/bin` paths point to the packaged versions for compatibility.

`home-to-onedrive.sh` deliberately retains **bidirectional `rclone bisync`** because
OneDrive is updated by multiple applications and devices. Its filters and transfer
settings are unchanged. `immich-to-onedrive.sh` retains its media-only sync behavior;
it does not create a database dump. Backup and rename commands are available but
are never run by builds or activation.

## Scratch environment

[Workbench](../environments/workbench/README.md) is copied to
`~/projects/workbench`, with Python/venv/uv, Rust/Cargo and Go, plus common shell
and native build tools. Enter it with `cd ~/projects/workbench && devenv shell`.
Its own `devenv.lock` pins the toolchains. Real projects retain their own devenv
shells; Git worktrees stay under `~/worktrees`.

## Continuous integration

`.github/workflows/validate.yml` runs on main pushes, pull requests, and weekly.
It evaluates both supported hosts, checks formatting, builds the ShellCheck-checked
helper scripts, and asserts that GNOME stays off, monitor settings are host-specific,
and development ports are closed by default and controllable only on Lythir.
Actions are pinned to commit IDs and the workflow has read-only repository access.

Full builds remain available locally with `nix flake check`. To run both host
builds on GitHub, select **Run workflow** and enable **Build both complete systems**.
Those builds require substantially more runner time and disk than routine checks.
The workflow must be pushed to GitHub before it can run.
