{ pkgs, ... }: {
  imports = [
    ../modules/nixos/nix.nix
    ../modules/nixos/ssh.nix
    ../modules/nixos/cli-tools.nix
    ../modules/nixos/home-manager.nix
    ../users/ivan/account.nix
  ];
  networking.networkmanager.enable = true;
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Australia/Brisbane";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = builtins.listToAttrs (
    map
      (name: {
        inherit name;
        value = "en_AU.UTF-8";
      })
      [
        "LC_ADDRESS"
        "LC_IDENTIFICATION"
        "LC_MEASUREMENT"
        "LC_MONETARY"
        "LC_NAME"
        "LC_NUMERIC"
        "LC_PAPER"
        "LC_TELEPHONE"
        "LC_TIME"
      ]
  );
  environment.systemPackages = [ pkgs.nixfmt ];
}
