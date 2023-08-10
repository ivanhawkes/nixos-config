{ config, lib, pkgs, ... }:

{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    # IDE.
    vscodium
    
    # Compilers.
    gcc
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
