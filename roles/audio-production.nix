{
  config,
  lib,
  pkgs,
  ...
}:

{
  # You *must* disable pulseaudio to use pipewire.
  services.pulseaudio.enable = false;

  # Provides RealTimeKit permissions, which lets PipeWire run with high-priority
  # audio threads to prevent pops, clicks, and buffer dropouts.
  security.rtkit.enable = true;

  # Enable PipeWire and its JACK emulation layer
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # This emulates the jack2 server infrastructure
    jack.enable = true;
  };

  imports = [
    ../modules/nixos/reaper.nix
  ];
}
