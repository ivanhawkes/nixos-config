{ pkgs, lib, config, inputs, ... }:

{
  env.GREET = "Pi Agent Configuration Workspace";

  packages = [ 
    pkgs.git 
    pkgs.nodejs_latest
    pkgs.pi-coding-agent
  ];

  scripts.harness-init.exec = ''
    echo "⚡ Initialising Pi Coding Agent Harness local to this folder..."
    pi install -l npm:@baryonlabs/pi-agent-harness
  '';

  # 🚀 Clean and standard path configuration without shell sourcing
  enterShell = ''
    export NPM_CONFIG_PREFIX="$PWD/.pi/npm"
    export PATH="$PWD/.pi/npm/bin:$PATH"

    echo "🦾 $GREET Environment Ready!"
    echo "👉 Run 'harness-init' or 'pi' to begin working with the agent."
  '';

  enterTest = ''
    node --version
    pi --version
  '';
}
