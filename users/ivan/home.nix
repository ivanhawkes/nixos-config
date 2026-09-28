{ pkgs, ... }:

let
  # Absolute path to your AppImage — adjust to match whoami
  appImage = "/home/ivan/.local/opt/tmog/tmog.AppImage";
in {

  # Must match (or be compatible with) your system.stateVersion ("26.05")
  home.stateVersion = "26.05";
  home.username = "ivan";
  home.homeDirectory = "/home/ivan";

  # ── puts `tmog` on your $PATH ──────────────────────────────
  home.packages = [
    (pkgs.writeShellScriptBin "tmog" ''
      # Extract-and-run avoids FUSE entirely (cleaner on NixOS).
      # Delete this line if you prefer native FUSE.
      export APPIMAGE_EXTRACT_AND_RUN=1
      exec ${appImage} "$@"
    '')
  ];

  # ── shows TMOG in your application menu ────────────────────
  xdg.desktopEntries.tmog = {
    name       = "TMOG";
    comment    = "Task Manager OG";
    exec       = "tmog";       # resolved via the wrapper on $PATH
    icon       = "tmog";       # optional: point to a .png/.svg if you have one
    terminal   = false;
    type       = "Application";
    categories = [ "Utility" "Office" ];
  };
}
