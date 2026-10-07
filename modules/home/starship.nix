{ pkgs, ... }: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true; # Seamlessly hooks into your Zsh shell session
    
    settings = {
      # Appends a clean, modern new line between command inputs
      add_newline = true;

      # See comment about Pi Harness terminal bug. Disabling the module also
      # suppresses its long-command desktop notifications (D-Bus); the explicit
      # show_notifications = false is kept in case the module is re-enabled.
      cmd_duration = {
        disabled = true;
        show_notifications = false;
      };

      # Set a modern looking terminal prompt.
      format = ''
        [](#89b4fa)$directory[](fg:#89b4fa bg:#313244)$git_branch$git_status[](fg:#313244)
        $character
      '';

      # ── Present Working Directory Sizing ──
      directory = {
        format = "[$path]($style)";
        style = "fg:#1e1e2e bg:#89b4fa bold";
        truncation_length = 4; # Keeps paths compact in side-by-side splits
        truncate_to_repo = true; # Smart-truncates to the git root folder
      };

      # ── Git Branch Status Trackers ──
      git_branch = {
        symbol = " ";
        format = "[$symbol$branch(:$remote_branch)]($style)";
        style = "fg:#cdd6f4 bg:#313244 bold";
      };

      git_status = {
        format = "([$all_status$ahead_behind]($style))";
        style = "fg:#f38ba8 bg:#313244 bold";
        conflicted = "🏳";
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        untracked = "";
        stashed = "📦";
        modified = "📝";
        staged = "++\${count}";
        renamed = "🚚";
        deleted = "🗑";
      };

      # ── Input Prompt Character ──
      character = {
        success_symbol = "[❯](bold #cba6f7)"; # Mocha Mauve matching your layout accents
        error_symbol = "[❯](bold #f38ba8)";   # Mocha Red indicating an error exit code
      };
    };
  };
}
