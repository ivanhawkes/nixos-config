{ config, lib, pkgs, ... }:

{
  imports = [
  ];

  # Allow unfree applications.
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "vscode"
  ];
  

  environment.systemPackages = with pkgs; [
    # IDE.
    vscode
    
    # Compilers.
    gcc
    gcc-arm-embedded
    clang
    llvm

    # Debugging / static analysis.
    valgrind

    # Source control.
    git

    # Build utilities.
    cmake

    # Scripting.
    python3

    # Static web pages.
    nodejs_20
    hugo
    nodePackages.gulp-cli
  ];  
}
