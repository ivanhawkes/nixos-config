{ pkgs, ... }: {
  languages = {
    python = {
      enable = true;
      venv.enable = true;
    };
    rust = {
      enable = true;
      channel = "nixpkgs";
    };
    go.enable = true;
  };
  packages = with pkgs; [
    git
    git-lfs
    gh
    openssh
    curl
    wget
    rsync
    coreutils
    findutils
    gnugrep
    gnused
    gawk
    ripgrep
    fd
    fzf
    bat
    eza
    tree
    jq
    yq-go
    gcc
    gnumake
    cmake
    ninja
    pkg-config
    openssl
    uv
    shellcheck
    shfmt
    nixfmt
    unzip
    zip
  ];
  enterShell = ''
    echo "Workbench: Python, Rust, Go and command-line tools ready."
    echo "Git worktrees belong in ~/worktrees; experiments can stay here."
  '';
  enterTest = ''
    python --version
    cargo --version
    rustc --version
    go version
    test_dir=$(mktemp -d)
    python -c 'assert sum(range(5)) == 10'
    printf 'fn main() { println!("rust ready"); }\n' > "$test_dir/main.rs"
    rustc "$test_dir/main.rs" -o "$test_dir/rust-check"
    "$test_dir/rust-check"
    printf 'package main\nimport "fmt"\nfunc main() { fmt.Println("go ready") }\n' > "$test_dir/main.go"
    go run "$test_dir/main.go"
  '';
}
