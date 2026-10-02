# dash-skogai

`/skogai`: the shared multi-agent workspace and source of truth (see
`skogai-routing/references/dash-skogai.md`). Owned by `skogix`, group `skogai`,
setgid so everything inherits the group.

## Layout

| Path            | Tracked | Purpose |
|-----------------|---------|---------|
| `admin/`        | yes     | setup/maintenance scripts. Several run via sudo, so only the owner may write here (`755`) |
| `bin/`          | no      | generated launchers for gptme core and every gptme-contrib package (incl. `gptme-coordination`) |
| `tools/`        | no      | shared runtimes (`tools/mise`: uv, python) backing `bin/` |
| `gptme-contrib/`| yes     | submodule: `skogai2/gptme-contrib` fork, pinned to the tag `scripts/gen-bin.py` installs from |
| `scripts/`      | yes     | `gen-bin.py` generates `bin/`; pins live at its top |
| `mise.toml`     | yes     | runtimes (uv, python) and `bin/` on PATH |
| `coordination/` | no      | live `gptme-coordination` SQLite DB (`coord.db`, must stay `0664`) |

## Bootstrap a machine

```bash
sudo bash admin/create-agents.sh [names...]   # group + agent users (default: claude dot amy goose)
sudo bash admin/setup-coordination.sh         # /skogai perms, coordination dir, 0664 DB
bash admin/install-tools.sh                   # shared runtimes + bin/ launchers (replaces install-coordination.sh)
sudo bash admin/test-coordination.sh          # cross-user smoke test
export PATH=/skogai/bin:$PATH   # launchers default COORDINATION_DB to /skogai/coordination/coord.db
```

`install-tools.sh` works from any checkout path, so a container can clone this
repo anywhere, run it, and add `<clone>/bin` to PATH (or use `mise.toml`'s
`_.path` from a workspace). Packages install on first run via
`uv tool run --from <pinned git spec>`, cached per user. To bump: tag a commit on
the fork, then set `CONTRIB_TAG` (label) and `CONTRIB_REF` (the tag's full commit SHA) and
the submodule to match, and rerun `install-tools.sh`. The launchers install from the SHA,
not the tag: uv re-fetches tags on every call (~20 s, no offline use), SHAs are cached.
`COORDINATION_DB` defaults to `<install>/coordination/coord.db` in every launcher.

## Gotchas

- mise's `pipx:` backend drops `#subdirectory=` and installs the repo root, so
  packages come from uv, not `[tools]`.
- Packages that depend on `mcp` get `mcp<2` (mcp 2.x removed `FastMCP`).

- SQLite creates DBs as `0644`; umask/ACLs cannot add group-write. The DB is
  pre-created `0664` by `setup-coordination.sh`; `-wal`/`-shm` inherit its mode.
- `gptme-coordination` does not sign messages from the CLI. Sender identity is
  unauthenticated, so isolation is Unix permissions, not HMAC.
- Agents can't use binaries under another user's home. Install into `bin/`/`tools/`.
