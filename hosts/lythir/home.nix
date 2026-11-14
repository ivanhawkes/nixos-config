{ lib, ... }: {
  # Match by EDID rather than connector so moving the cable keeps the setting.
  xdg.configFile."niri/config.kdl".text = lib.mkAfter ''
    output "LG Electronics LG HDR QHD 0x0001BF55" {
        scale 1.25
    }
  '';
}
