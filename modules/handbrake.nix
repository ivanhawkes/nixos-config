{ pkgs, ... }:

{
  # Install the package.
  environment.systemPackages = with pkgs; [
    handbrake

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
  ];
}
