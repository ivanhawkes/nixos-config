# Steam, plus the pieces a Linux gaming machine needs around it.
#
# Steam is unfree; it is covered by nixpkgs.config.allowUnfree in the host
# configuration. The module needs a 32-bit multilib GL stack, which the host
# already enables for the NVIDIA driver (and which programs.steam forces on
# itself anyway).
{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.steam = {
    enable = true;

    # Steam Input delivers controller events as X11 input. There is no real X
    # server here: niri runs Wayland and xwayland-satellite only translates
    # X11 calls. extest replays Steam's X11 events as kernel uinput events, so
    # without it a controller does nothing inside a game. The uinput kernel
    # module and the /dev/uinput udev rules that extest needs come from
    # hardware.steam-hardware, which programs.steam enables for us.
    extest.enable = true;

    # Proton-GE: upstream Proton builds carrying game fixes that have not
    # landed in Valve's Proton yet. Published to Steam through
    # STEAM_EXTRA_COMPAT_TOOLS_PATHS by the module.
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];

    # Winetricks for Proton prefixes (DLL overrides, fonts, dxvk tweaks).
    # Enabled through the option so it picks up the same compat-tool paths as
    # the Steam package above.
    protontricks.enable = true;

    # Libraries injected into Steam's runtime container, so launch options
    # such as `mangohud %command%` and `gamemoderun %command%` can see them.
    # The gamemode daemon itself is a system service, from programs.gamemode.
    extraPackages = with pkgs; [
      mangohud
      gamemode
    ];
  };

  # GameScope: a micro-compositor that gives one game its own Wayland/X11
  # session. Under niri an X11 game runs on xwayland-satellite; GameScope is
  # the fallback for titles that insist on a real X display or exclusive
  # fullscreen, e.g. the Steam launch option
  # `gamescope -w 2560 -h 1440 -F 60 -- %command%`. enableWsi adds the Vulkan
  # WSI layer (32-bit as well) so Vulkan/DXVK games present through it.
  programs.gamescope = {
    enable = true;
    enableWsi = true;
  };

  # GameMode: raises scheduler priority and CPU governor while a game is in
  # the foreground. gamemoded gets CAP_SYS_NICE by default, so no setuid
  # gamescope wrapper is needed for latency work.
  programs.gamemode.enable = true;

  # LAN streaming is opt-in: the firewall stays shut by default. Turn these on
  # to play games streamed to/from other machines on the network.
  # programs.steam.remotePlay.openFirewall = true;
  # programs.steam.localNetworkGameTransfers.openFirewall = true;
}
