# Workbench

An independent scratch workspace for Python, Rust and Go experiments, plus common
command-line and native build tools. Configuration is maintained here and copied
to `~/projects/workbench`. Git worktrees remain under `~/worktrees`.

```sh
cd ~/projects/workbench
devenv shell
# Check that Python runs and Rust/Go can compile and execute a small program.
devenv test
```

Python has a devenv-managed local virtualenv; use `uv pip install` for temporary
dependencies. Rust
comes from the locked nixpkgs revision, with Cargo, clippy and rustfmt supplied
by devenv. Each actual project keeps its own devenv shell and dependencies.

To refresh this workspace's toolchain pins, run `devenv update` here, then test.
When changing the template, copy its configuration and lockfile to the workspace;
keep scratch code there rather than in this configuration repository.
