{ inputs, pkgs, ... }:

{
  imports = [ inputs.codex-desktop-linux.nixosModules.default ];

  environment.systemPackages = [
    (inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.codex.overrideAttrs (_: {
      # Preserve lythir's rustc stack workaround; the unmodified derivation
      # also has a recorded SIGSEGV building codex-app-server-transport.
      RUST_MIN_STACK = "134217728";
    }))
  ];

  programs.codexDesktopLinux.enable = true;
  # Keep Desktop's bundled app-server matched to its frontend. cliPackage
  # can select the standalone CLI once protocol compatibility is verified.

  # The pinned Nix wrapper defaults to X11; auto detects a live Wayland
  # socket (including Niri) and retains X11 fallback and explicit flags.
  environment.sessionVariables.CODEX_OZONE_PLATFORM = "auto";
}
