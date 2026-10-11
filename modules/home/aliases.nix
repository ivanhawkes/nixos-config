# Shell shortcuts for the machines and servers ivan logs into, plus the
# environment the login shell used to set up.
#
# These replace the one-line launcher scripts that used to live in
# users/ivan/.local/bin: those scripts resolved the target from `basename $0`,
# so a symlink had to be created for every machine. An alias names the target
# outright, so nothing is installed on PATH and no symlinks need maintaining.
#
# Enabling zsh here also hands ~/.zshrc and ~/.zprofile to home-manager, so
# anything the old hand-written rc files exported has to be declared here too.
{
  pkgs,
  ...
}:

{
  # ── Shell Aliases ─────────────────────────────────────────
  programs.zsh = {
    enable = true;

    # ── Session variables ───────────────────────────────────
    # Ported from the legacy users/ivan/.bashrc, users/ivan/.profile and the
    # previous hand-written ~/.zprofile. Values are emitted as `export NAME="value"`,
    # so $HOME expands at shell time.
    #
    # Deliberately absent: HF_TOKEN. It is a secret and this file is public.
    sessionVariables = {
      # Terminals that don't advertise colour support still need to be told.
      COLORTERM = "truecolor";

      # Default editor for git commit messages and friends.
      EDITOR = "nano";

      # Serial-console access for the Pico and board work.
      MINICOM = "-con";

      # OpenOCD, on-chip debugging. Built from the code version, not the
      # distro-packaged path (the old alternative is left in a comment).
      OPENOCD_SCRIPTS = "/usr/local/share/openocd/scripts/";

      # Intel FPGA Quartus designer. Absolute path: it is version pinned.
      QSYS_ROOTDIR = "/home/ivan/intelFPGA_lite/21.1/quartus/sopc_builder/bin";

      # Hint that CMake should use Ninja as the build system.
      CMAKE_GENERATOR = "Ninja";

      # Raspberry Pi Pico SDK example trees.
      PICO_EXAMPLES_PATH = "$HOME/projects/pico-examples";
      PICO_EXTRAS_PATH = "$HOME/projects/pico-extras";
      PICO_PLAYGROUND_PATH = "$HOME/projects/pico-playground";
      PICO_SDK_PATH = "$HOME/projects/pico-sdk";

      # Scale ALL Qt programs (Qt apps misjudge HiDPI under niri).
      QT_SCALE_FACTOR = "1.25";

      # Go workspace root; also feeds the go/bin entry in sessionPath.
      GOPATH = "$HOME/go";

      # Node version manager, pnpm and bun. Each is only half of a setup: the
      # loader scripts are sourced in profileExtra below.
      NVM_DIR = "$HOME/.nvm";
      PNPM_HOME = "$HOME/.local/share/pnpm";
      BUN_INSTALL = "$HOME/.bun";
    };

    # ── Loader scripts ──────────────────────────────────────
    # Not variables, so they can't go in sessionVariables: these version
    # managers set PATH and aliases themselves, and are only sourced if present.
    profileExtra = ''
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
      [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

      [ -s "/home/ivan/vulkan/1.4.341.1/setup-env.sh" ] && source "/home/ivan/vulkan/1.4.341.1/setup-env.sh"

      [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
    '';

    # ── Fast logins ─────────────────────────────────────────
    # Trailing arguments pass through, so `veronica -Y user@host` works
    # exactly as the old script's `ssh <name> $*` did.
    shellAliases = {
      # Velma and opnsense are root access only.
      velma = "ssh root@velma";
      opnsense = "ssh root@10.0.0.10";

      # Servers.
      veronica = "ssh veronica";
      daphne = "ssh daphne";

      # Clients.
      lythir = "ssh lythir";
      socks = "ssh socks";
      
      # Assorted.
      mister = "ssh mister";
      de10-nano = "ssh de10-nano";
      volumio = "ssh volumio-lounge";
      homeassistant = "ssh root@homeassistant";
    };
  };

  # ── PATH additions ────────────────────────────────────────
  # Not under programs.zsh: home.sessionPath is a top-level option. It prepends
  # to PATH in a double-quoted context, so the $HOME/$GOPATH values set above
  # expand. The old ~/.zprofile appended most of these instead; prepending is
  # what lets a project-local vendor/bin or .venv/bin win over the system PATH.
  home.sessionPath = [
    "\$HOME/.local/bin"
    "/usr/local/go/bin"
    "\$GOPATH/bin"
    "\$PNPM_HOME"
    "\$BUN_INSTALL/bin"
    "vendor/bin"
    ".venv/bin"
  ];

  # The "./" prefix is not a typo: the zsh module keys the entries
  # home.file."${dotDirRel}/.zshrc", and dotDirRel is "." while dotDir is the
  # plain home directory. A different key would register a second file with the
  # same target, which home-manager rejects.
  home.file."./.zshrc".force = true;
  home.file."./.zprofile".force = true;
  home.file."./.zshenv".force = true;
}
