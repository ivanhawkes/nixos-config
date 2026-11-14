{ ... }: {
  imports = [
    ../../../modules/home/vscode.nix
    ./dotfiles.nix
  ];
  # Compatibility with manually installed toolchains. Prefer project-local
  # devShells for new projects; these paths are not provided by this flake.
  programs.zsh = {
    sessionVariables = {
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

  };
  home.sessionPath = [
    "/usr/local/go/bin"
    "\$GOPATH/bin"
    "\$PNPM_HOME"
    "\$BUN_INSTALL/bin"
    "vendor/bin"
    ".venv/bin"
  ];

}
