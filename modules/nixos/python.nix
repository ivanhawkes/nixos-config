{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (python3.withPackages (
      ps: with ps; [
        pip
        pygments
        pylint # used by the Python VSCode extension
        virtualenvwrapper
      ]
    ))
  ];
}
