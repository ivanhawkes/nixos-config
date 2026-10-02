{ pkgs, lib, config, inputs, ... }:

{
  # 1. Project-wide Metadata & Welcome Text
  env.GREET = "Pi Agent Configuration Workspace";

  # 2. Inject Required Tools (Git, Node.js, and Pi Coding Agent)
  packages = [ 
    pkgs.git 
    pkgs.nodejs_latest
    pkgs.pi-coding-agent
  ];

  # 3. Helper Script to initialize your project harness
  scripts.harness-init.exec = ''
    echo "⚡ Initialising Pi Coding Agent Harness local to this folder..."
    pi install -l npm:@baryonlabs/pi-agent-harness
  '';

  # 4. Interactive Shell Lifecycle Hook (Preserves your Oh My Zsh configuration)
  enterShell = ''
    # Isolate npm paths to prevent NixOS global write permission conflicts
    export NPM_CONFIG_PREFIX="$PWD/.pi/npm"
    export PATH="$PWD/.pi/npm/bin:$PATH"

    # Force shell to evaluate your interactive Oh My Zsh context & aliases
    if [ -n "$ZSH_VERSION" ] && [ -f ~/.zshrc ]; then
      source ~/.zshrc
    fi

    echo "🦾 $GREET Environment Ready!"
    echo "👉 Run 'harness-init' or 'pi' to begin working with the agent."
  '';

  # 5. Core Test Specification
  enterTest = ''
    echo "Verifying environment constraints..."
    node --version
    pi --version
  '';
}
