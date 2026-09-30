{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./fonts.nix
  ];

  # Discord is an unfree application.
  #  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  #      "discord"
  #  ];

  environment.systemPackages = with pkgs; [
    # Browsers.
    firefox
    google-chrome
    brave

    # Code editor.
    vscodium

    # Dotfile management.
    stow

    # Communications.
    #discord

    # Shiny new terminal
    alacritty

    # Artwork.
    krita
    inkscape
    blender

    # Video playback.
    vlc

    # Wrap HandBrake so it can find the NixOS NVIDIA drivers at runtime
    (symlinkJoin {
      name = "handbrake-nvenc";
      paths = [ handbrake ];
      buildInputs = [ makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/ghb \
          --prefix LD_LIBRARY_PATH : "/run/opengl-driver/lib"
        wrapProgram $out/bin/HandBrakeCLI \
          --prefix LD_LIBRARY_PATH : "/run/opengl-driver/lib"
      '';
    })

    # Audio production.
    #    jack2
    #    qjackctl
    #    reaper

    # Video production.
    #ffmpeg
    #obs-studio
  ];

  hardware.enableAllFirmware = true;

  services.samba.enable = true;
}
