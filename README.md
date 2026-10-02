# dash-skogai

`/skogai`: the shared multi-agent workspace and source of truth (see
`skogai-routing/references/dash-skogai.md`). Owned by `skogix`, group `skogai`,
setgid so everything inherits the group.

## Layout

| Path            | Tracked | Purpose |
|-----------------|---------|---------|
| `admin/`        | yes     | setup/maintenance scripts. Several run via sudo, so only the owner may write here (`755`) |
| `bin/`          | no      | shared executables for agents (`gptme-coordination`) |
| `tools/`        | no      | venvs backing `bin/` |
| `coordination/` | no      | live `gptme-coordination` SQLite DB (`coord.db`, must stay `0664`) |

## Bootstrap a machine

```bash
sudo bash admin/create-agents.sh [names...]   # group + agent users (default: claude dot amy goose)
sudo bash admin/setup-coordination.sh         # /skogai perms, coordination dir, 0664 DB
bash admin/install-coordination.sh            # shared gptme-coordination install
sudo bash admin/test-coordination.sh          # cross-user smoke test
export COORDINATION_DB=/skogai/coordination/coord.db PATH=/skogai/bin:$PATH
```

## Gotchas

- SQLite creates DBs as `0644`; umask/ACLs cannot add group-write. The DB is
  pre-created `0664` by `setup-coordination.sh`; `-wal`/`-shm` inherit its mode.
- `gptme-coordination` does not sign messages from the CLI. Sender identity is
  unauthenticated, so isolation is Unix permissions, not HMAC.
- Agents can't use binaries under another user's home. Install into `bin/`/`tools/`.
