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
