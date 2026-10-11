# Dotfiles and helper scripts that home-manager symlinks into the home directory.
{ ... }:

{
  # ── Home directory dotfiles ───────────────────────────────
  home.file = {
    # Login shell setup for sh/bash; zsh gets its PATH from home.sessionPath
    # in modules/home/aliases.nix. Kept because ssh logins and getty still read
    # this file.
    ".profile" = {
      source = ../../users/ivan/.profile;
    };

    # C++ formatting rules, read by clang-format and the Codium extension.
    ".clang-format" = {
      source = ../../users/ivan/.clang-format;
    };

    # Offsite backup to OneDrive.
    ".local/bin/home-to-onedrive.sh" = {
      source = ../../users/ivan/.local/bin/home-to-onedrive.sh;
      executable = true;
    };

    # Offsite backup to OneDrive.
    ".local/bin/immich-to-onedrive.sh" = {
      source = ../../users/ivan/.local/bin/immich-to-onedrive.sh;
      executable = true;
    };

    ".local/bin/clone-pico-libraries.sh" = {
      source = ../../users/ivan/.local/bin/clone-pico-libraries.sh;
      executable = true;
    };

    ".local/bin/pico_setup.sh" = {
      source = ../../users/ivan/.local/bin/pico_setup.sh;
      executable = true;
    };
  };
}
