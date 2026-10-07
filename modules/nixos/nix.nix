# Nix daemon settings and store maintenance, shared by every host.
{
  nix.settings = {
    # Allow experimental settings so I can use flakes.
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    # Automatically hard-link identical files in the store to save space
    # (runs continuously in the background for new derivations).
    auto-optimise-store = true;
  };

  # Enable automated weekly garbage collection.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    # Prunes profiles older than 7 days, freeing up space without massive I/O loops.
    options = "--delete-older-than 7d";
  };
}
