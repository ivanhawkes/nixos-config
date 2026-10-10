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

## Getting Started

We need to establish a foothold first, bring in some useful commands and
this repository as well.

```bash
# Give yourself access to a Nix shell with flakes enabled. This requires the
# extra experimental features flag to be set.
nix --extra-experimental-features "nix-command flakes" shell nixpkgs#git nixpkgs#vscodium nixpkgs#brave
```

## Getting my SSH keys.

```bash
# Start in the home folder. Grab my SSH keys from a local machine.
cd ~ && scp $USER@{HOST_WITH_SSH_KEYS}:/home/$USER/.ssh/* ~/.ssh
```

## Git config

The next step is usually to set some defaults for Git. These will be overridden
once the full Nix flake setup is installed, but it's best to have these for
pulling the repository from Github.

```bash
git config --global user.email "ivan.hawkes@gmail.com"
git config --global user.name "Ivan Hawkes"
git config --global init.defaultBranch main
```

## Get this repository

Clone a copy of [this repository](https://github.com/ivanhawkes/nixos-config).

```bash
git clone git@github.com:ivanhawkes/nixos-config.git
```

## Adding a new machine.

```bash
# Set the new machine name in the environment to save some cut and paste - default
# to using the host name set on installation.
export MACHINE=$HOST

# These next commands should be executed from a local copy of the repository.
cd ~/nixos-config

# Make a new config folder for the new machine.
mkdir -p hosts/$MACHINE

# Backup the config Nixos generated during the install process.
cp /etc/nixos/configuration.nix /etc/nixos/configuration.nix.backup
cp /etc/nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix.backup

# You should have a good working hardware-configuration.nix file from the installation.
# If you need to regenerate it at any time you can run:
sudo nixos-generate-config --force

# Take a copy of the generated hardware config as our base.
cp /etc/nixos/hardware-configuration.nix hosts/$MACHINE/

# By default, use the first config 'lythir' as a template for other machines.
# You may wish to change this, for example, 'socks' for a server installation.
cp hosts/lythir/configuration.nix hosts/$MACHINE/
```

### Make sure you...

- Change 'networking.hostName', and adjust the hardware sections (NVIDIA/AMD, root device UUID, etc.).
- Register the new machine in `flake.nix` under `nixosConfigurations`.

You will likely need to make changes to the following files:

- flake.nix
- home.nix
- hosts/$MACHINE/configuration.nix

If your machine is a laptop, be sure to check it has the right drivers available,
especially for wifi, power control, and screen control.

## Adding Home Comforts

You can do this while the OS is building, or before, or after - the choice is yours.

Login is a brutal cycle of second factor authentication and other assorted bullshit.
Make sure you have your phone on hand.

- [primary mail provider](https://mail.google.com/)
- [secrets manager](https://bitwarden.com/)

Now get BitWarden extension working in your browser. It provides passkey implementation.

- [BitWarden Downloads](https://bitwarden.com/download/)

On with the hustle:

- [your main repository](https://github.com/ivanhawkes)
- [bookmarks](https://app.raindrop.io/)
- [to-do list](https://app.todoist.com/)

## Building

With the config files in place it's time to pray to the outer gods. They will neither
hear your prayers, nor acknowledge them if they do, and they will certainly never intercede
on your behalf. The universe is a cold, dark, uncaring place...best of luck.

```bash
# Only build the configuration, no testing, no adding to the boot menu.
sudo nixos-rebuild build --flake .#$MACHINE

# Optionally, try it without making it the default boot.
sudo nixos-rebuild test --flake .#$MACHINE

# Build and apply this configuration.
sudo nixos-rebuild switch --flake .#$MACHINE
```

## Updating

The Nixos package are pinned using flake.lock - a lockfile with version numbers within.
If you are feeling brave you might want to try and upgrade to a newer version of the
packages. It is recommended you do this on a machine that is easy to control and revert
if needed.

Nixos is a fast moving target that does break things, so be advised you are taking a risk
every time you perform an update.

```bash
# Update nixpkgs and switch if it all looks good.
nix flake update
sudo nixos-rebuild build --flake .#$MACHINE
sudo nixos-rebuild switch --flake .#$MACHINE
```

## Home Manager

I don't normally need to rebuild Home Manager on it's own, but it's useful to have
the command available just in case:

```bash
home-manager rebuild
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

## Pi Coding Harness

This folder doubles as a workspace for the [Pi Coding Harness](https://pi.dev/). 
The shell will launch automatically if you have direnv enabled on your system.

You can launch it manually by executing:

```bash
devenv shell
```

The `.pi/` folder is local-only and gitignored. The agent isn't sandboxed, so use with caution.

I use the harness to connect to my local LLM inference server. With full access to the working
directory it's able to suggest fixes and improvements to the configuration and has been invaluable
in getting this whole project customised to my preferences and machine.

## AI Disclosure

I have tried on at least two other occasions to switch my desktop to Nixos. Each time I hit a wall
and eventually caved in to the tempting comfort of my old Ubuntu and Debian distributions. When I
accidentally tanked my Debian 13 Trixie desktop with a botched install of Hyprland and a mix
of 'Unstable', 'Testing' and 'Backports', I knew it was time to give Nixos another shot.

I started from my last build, which I kept in a git repository for safe keeping. It was a fast
way to get a lot of my environment ready, but was pretty rough and didn't have any style to it.
I wanted something fast, sleek, reproducible and stylish. If I'm putting in this level of work
again the results need to bring joy.

Lucky, I had just been experimenting with AI to evaluate it for general purpose work. The
evaluation used a mix of publicly available 'free' AI from Google, and the Qwen 3.8 27B model
that I could run locally.

Installing the [Pi Coding Harness](https://pi.dev/) into the project folder gave it unfettered
access to both the project and my machine. I fed it vital machine information from Fastfetch,
which I also supplied to Google, along with my complete configuration so Google could assist
with the edits, which were sometimes a little vague thanks to the way the files are broken out.

Step by step, sometimes with extremely frustrating build breaking issues to deal with, I made
it work and feel the way I wanted.

At many points both AIs failed. Some of the more common failures were:

- outdated information from the fast pace of change in Nixos + Niri + Noctalia. This was typically
  felt in the form of settings, parameters, flags, etc all being deprecated, switched to a 
  new name, or their signature being changed.
- Local AI often stuttered as it found Nixos and Niri not accepting scripts it wrote, with the
  apostrophe character often being at fault. Quoting would cause unusual failure points, but
  the model would persist and usually get to the end goal.
- going off on wild tangents. Watching the local AI open the Nix packages, start reading source
  code, and build python programs to execute arbitrary code was both thrilling and chilling.
- running out of context and needing to compact. The AI would spend so long on reasoning
  that it would need to stop and hit itself in the head with a hammer before it could
  continue.

### Findings

The local AI has a huge advantage because it runs in a harness which gives it **intimate knowledge
of my system** and **can run arbitrary code of it's own design**.

You can level the playing field for Google AI by feeding it a tarball of your configuration,
a copy of the output from fastfetch, and the error messages that inevitably litter your screen
as you run through the fine tuning process. But that's still a lot of stop and start, and
cut and paste.

Google AI was multiple times faster, and has the benefit of decades of scraping the internet
for backfill. Local AI keeps Google from having a permanent record of your configuration
and hardware specifications.

They both fed me wrong answers at times. Google like to pair it with a line like
"You're completely right, I did...". Having to iterate three or more times to get it to
finally provide the actual current and correct information was far more common that
I would prefer.

## Results

I am weary, and the struggle was far longer than I anticipated, but the result is
spectacular.

My new desktop is very responsive. Memory use is sitting at 6.8gb with Codium, Brave, Nautilus
and three Alacritty windows open.

The infinite scrollbar workspace idea is phenomenal. Nixos opens up my most used software on the
desktops I designated as I log into the desktop. I went with a 3x grid setup, with Alacritty
taking up three slots on workspace 1 - each window taking exactly half the screen real estate.
Brave and Codium sit side-by-side at full screen in the middle, on workspace 2. Nautilus leaps
into life on workspace 3 when I launch it. Everything else just launches on the workspace I
am currently using.

This places my development environment front and centre. A quick keypress and I've switched to
the browser. Pressing <CTRL> Up / Down takes me to my terminals, or  the file management tools.
The setup is intuitive, and reduces keystrokes. I never have to guess where my tools are or
drag overlapping windows around the screen, or <ALT> Tab through a list of 10 windows to reach
the one I want, only to discover it is shadowing a window I also need to complete my task.

The whole thing looks beautiful. It's easy to switch between a generous selection of wallpapers
to suit my mood. Everything I need for daily work is right there.

Bonus round:

- a clipboard widget that stores all of the cut and copy operations
- a screen capture widget
- a network widget for switching VPN's on and off
- a unified theme, Cattpuccin, for my desktop, Codium, and Alacritty

I'm finally home.
