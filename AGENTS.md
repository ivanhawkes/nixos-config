# Project guidelines

## Binary files — do not read or execute
- Never use `read`, `cat`, `head`, or any other tool to dump the contents of binary files.
- Never execute binaries found in this repo (e.g., anything under `.devenv/`, `squashfs-root/`, or nix store paths such as `result`).
- Binary files currently present (all gitignored):
  - `.devenv/nix-eval-cache.db`, `.devenv/nix-eval-cache.db-shm`, `.devenv/nix-eval-cache.db-wal`
  - `.devenv/state/tasks.db`, `.devenv/state/tasks.db-shm`, `.devenv/state/tasks.db-wal`
  - `.devenv/load-exports`
- If you need data from a SQLite database, query it with `sqlite3 <db> ".tables"` / SQL instead of reading the file.
- If a task seems to require inspecting or running a binary, ask the user first.

## Hardware context — read `hardware.json`
- Before proposing changes to this NixOS configuration, read `hardware.json` (a fastfetch JSON dump of the machine: OS, kernel, CPU, GPU, disk, memory, network, DE/WM, etc.).
- Use it as ground truth for hardware-specific decisions (e.g., GPU drivers, disk layout, swap, power management, network interfaces) instead of guessing.
- If `hardware.json` does not exist, create it by running the shell command `fastfetch --format json > hardware.json`.
- If `hardware.json` is older than one week (check its modification time, e.g. `find hardware.json -mtime +7`), run the command to regenerate it before relying on it.

## Improvement suggestions
When asked to review or improve this project, read `hardware.json` first and then suggest concrete improvements in these areas:
1. **Project (NixOS config)** — e.g., missing or outdated hardware-specific options, flake structure, module organization, reproducibility, secrets handling, and CI/evaluation checks (`nix flake check`, `nixos-rebuild dry-activate`).
2. **LLM ability to write code** — e.g., clearer module boundaries, typed/validated Nix expressions, consistent naming conventions, and examples that make generated code easier to verify.
3. **LLM ability to debug** — e.g., better error messages, `nix log`/build-outputs conventions, reproducible failure reproduction steps, and documented known pitfalls.
4. **LLM ability to test** — e.g., nixos-tests for the specific hardware/services in use, unit tests for Nix modules, and a documented way to run them.
5. **LLM ability to document code, documentation, and data definitions** — e.g., per-module doc comments, a README explaining repo layout, and JSON schemas or documented field definitions for data files like `hardware.json` so the model can read and produce them reliably.
