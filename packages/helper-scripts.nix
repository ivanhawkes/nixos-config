{ pkgs }:
let
  script =
    name: runtimeInputs:
    pkgs.writeShellApplication {
      inherit name runtimeInputs;
      text = builtins.readFile (../users/ivan/scripts + "/${name}");
    };
in
{
  home-to-onedrive = script "home-to-onedrive.sh" [ pkgs.rclone ];
  immich-to-onedrive = script "immich-to-onedrive.sh" [ pkgs.rclone ];
  clone-pico-libraries = script "clone-pico-libraries.sh" [
    pkgs.coreutils
    pkgs.git
    pkgs.openssh
  ];
  backup = script "backup.sh" [ pkgs.rsync ];
  rename = script "rename.sh" [ pkgs.mnamer ];
}
