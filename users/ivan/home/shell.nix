# Shell shortcuts for the machines and servers ivan logs into, plus the
# environment the login shell used to set up.
#
# These replace the one-line launcher scripts that used to live in
# users/ivan/scripts: those scripts resolved the target from `basename $0`,
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

    # ── Shell Integration Hooks ─────────────────────────────
    # This replaces the interactive 'wt config shell install' utility
    # by evaluating its initialization code during Zsh startup.
    initContent = ''
      if command -v wt &>/dev/null; then
        eval "$(wt config shell init zsh)"
      fi
    '';

    # ── Session variables ───────────────────────────────────
    # Ported from the legacy users/ivan/.bashrc, users/ivan/files/profile and the
    # previous hand-written ~/.zprofile. Values are emitted as `export NAME="value"`,
    # so $HOME expands at shell time.
    #
    # Deliberately absent: HF_TOKEN. It is a secret and this file is public.
    sessionVariables = {
      # Terminals that don't advertise colour support still need to be told.
      COLORTERM = "truecolor";

      # Default editor for git commit messages and friends.
      EDITOR = "nano";

    };

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

  # Personal command directory; SDK paths belong to the development profile.
  home.sessionPath = [ "$HOME/.local/bin" ];
  # The "./" prefix is not a typo: the zsh module keys the entries
  # home.file."${dotDirRel}/.zshrc", and dotDirRel is "." while dotDir is the
  # plain home directory. A different key would register a second file with the
  # same target, which home-manager rejects.
  home.file."./.zshrc".force = true;
  home.file."./.zprofile".force = true;
  home.file."./.zshenv".force = true;
}
