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

Both workstations explicitly select `modules/nixos/development-network.nix` to
retain their existing TCP 80/443/8080 listener policy. A desktop alone does not
open these ports. Move each opening beside a declarative service if those
manually launched development/Strata services are added to this repository.

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

Personal helper scripts are in `users/ivan/scripts/`. Only scripts declared by
`users/ivan/home/dotfiles.nix` are installed. Existing backup scripts retain their
original behavior and need separate restore testing before being relied upon.
