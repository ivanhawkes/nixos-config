# Dotfiles and helper scripts that home-manager symlinks into the home directory.
{ pkgs, ... }:
let
  scripts = import ../../../packages/helper-scripts.nix { inherit pkgs; };
in

{
  # ── Home directory dotfiles ───────────────────────────────
  home.file = {
    # Login shell setup for sh/bash; zsh gets its PATH from home.sessionPath
    # in users/ivan/home/shell.nix. Kept because ssh logins and getty still read
    # this file.
    ".profile" = {
      source = ../files/profile;
    };

    # C++ formatting rules, read by clang-format and the Codium extension.
    ".clang-format" = {
      source = ../files/clang-format;
    };

  }
  // builtins.listToAttrs (
    map
      (name: {
        name = ".local/bin/${name}.sh";
        value.source = "${scripts.${name}}/bin/${name}.sh";
      })
      [
        "home-to-onedrive"
        "immich-to-onedrive"
        "clone-pico-libraries"
      ]
  );
  home.packages = builtins.attrValues scripts;
}
