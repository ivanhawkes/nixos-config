# Dotfiles and helper scripts that home-manager symlinks into the home directory.
#
# This replaces users/ivan/.local/bin/install-scripts.sh, which used to `rm -f`
# each target and then `ln -s` it. force = true here is that same "clobber what's
# already there" behaviour, and it is needed because a home coming from the old
# hand-symlinked setup has real files (or links into another repo) at these
# paths, which home-manager would otherwise refuse to overwrite.
{ ... }:

{
  # ── Home directory dotfiles ───────────────────────────────
  # This pinned home-manager revision has no `files` alias yet; `home.file`
  # is the option name.
  home.file = {
    # Login shell setup for sh/bash; zsh gets its PATH from home.sessionPath
    # in modules/home/aliases.nix. Kept because ssh logins and getty still read
    # this file.
    ".profile" = {
      source = ../../users/ivan/.profile;
      force = true;
    };

    # C++ formatting rules, read by clang-format and the Codium extension.
    ".clang-format" = {
      source = ../../users/ivan/.clang-format;
      force = true;
    };

    # ── Helper scripts ──────────────────────────────────────
    # Executable bit is inherited from the repository copy, but is stated
    # explicitly so a checkout on a filesystem that lost the bit still works.
    ".local/bin/backup.sh" = {
      source = ../../users/ivan/.local/bin/backup.sh;
      executable = true;
      force = true;
    };

    ".local/bin/clone-pico-libraries.sh" = {
      source = ../../users/ivan/.local/bin/clone-pico-libraries.sh;
      executable = true;
      force = true;
    };

    ".local/bin/pico_setup.sh" = {
      source = ../../users/ivan/.local/bin/pico_setup.sh;
      executable = true;
      force = true;
    };

    # Only useful on the media server, but harmless everywhere else.
    ".local/bin/rename.sh" = {
      source = ../../users/ivan/.local/bin/rename.sh;
      executable = true;
      force = true;
    };
  };
}
