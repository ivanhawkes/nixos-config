{ config, pkgs, ... }:

let
  # No nixpkgs/upstream Nix package found (2026-11-14); see docs/maintenance.md.
  appImage = "${config.home.homeDirectory}/.local/opt/tmog/tmog.AppImage";
in
{
  # ── Packages & Scripts ────────────────────────────────────
  home.packages = [
    # Fixed script runner using standard Nix formatting and appimage-run
    (pkgs.writeShellScriptBin "tmog" ''
      export APPIMAGE_EXTRACT_AND_RUN=1
      exec ${pkgs.appimage-run}/bin/appimage-run "${appImage}" "$@"
    '')
  ];

  # ── Application Entries ───────────────────────────────────
  xdg.desktopEntries.tmog = {
    name = "TMOG";
    comment = "Task Manager OG";
    exec = "tmog";
    icon = "tmog";
    terminal = false;
    type = "Application";
    categories = [
      "Utility"
      "Office"
    ];
  };
}
