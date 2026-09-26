{ pkgs, ... }:

{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    arduino
    gcc
    clang
    valgrind
  ];
}