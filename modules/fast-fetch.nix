{ pkgs, ... }:

{
  xdg.configFile."fastfetch/config.jsonc".text = ''
    {
      "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
      
      "display": {
        "separator": " ➜ ",
        "key": {
          "width": 12
        }
      },

      "logo": {
        "source": "nixos_small",
        "padding": {
          "right": 2
        }
      },

      "modules": [
        "title",
        "separator",
        "os",
        "host",
        "kernel",
        "uptime",
        "packages",
        "shell",
        {
          "type": "display",
          "key": "Display" // 👈 Explicitly overwrites the long label
        },
        "de",
        {
          "type": "wm",
          "key": "WM"      // 👈 Changes "Window Manager" to "WM" to stop the clipping
        },
        "terminal",
        "cpu",
        "gpu",
        "memory",
        "break",
        "colors"
      ]
    }
  '';
}
