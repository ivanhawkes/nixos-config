# Dotfiles and helper scripts that home-manager symlinks into the home directory.
{ ... }:

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

    # Offsite backup to OneDrive.
    ".local/bin/home-to-onedrive.sh" = {
      source = ../scripts/home-to-onedrive.sh;
      executable = true;
    };

    # Offsite backup to OneDrive.
    ".local/bin/immich-to-onedrive.sh" = {
      source = ../scripts/immich-to-onedrive.sh;
      executable = true;
    };

    ".local/bin/clone-pico-libraries.sh" = {
      source = ../scripts/clone-pico-libraries.sh;
      executable = true;
    };

  };
}
