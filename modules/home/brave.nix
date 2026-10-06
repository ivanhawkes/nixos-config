{ pkgs, ... }:

{
  # ── Declarative Brave Hardware Acceleration Configuration ──
  programs.brave = {
    enable = true;
  };
}
