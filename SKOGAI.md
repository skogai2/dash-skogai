# dash-skogai

This repo *is* `/skogai`: the shared multi-agent workspace and source of
truth. Every other skogai repo installs shared config and tooling from
here — it's infrastructure, not a project. Owned by `skogix`, group
`skogai`, setgid so everything created under it inherits the group.

## Routes

- @README.md - full layout table, bootstrap steps, permissions, gotchas

## Watch out for

- `bin/`, `tools/`, `coordination/` are generated/live state, not tracked
  (see `.gitignore`). Don't hand-edit them — `admin/install-tools.sh` and
  `admin/setup-coordination.sh` own them.
- `gptme-contrib/` is a submodule pinned to a specific tag/SHA, but the
  pin that actually matters lives in `scripts/gen-bin.py`
  (`CONTRIB_TAG`/`CONTRIB_REF`). Bumping the submodule without updating
  that script (and rerunning it) leaves `bin/` out of sync.
- Most of `admin/` runs via `sudo` and is owner-write only (`755`) —
  expect to need the owner, not just group membership, to change it.
- `config.defaults.json` + `default/` is how this repo ships shared
  defaults (currently just `default/gitignore` → every repo's
  `.gitignore`) out to the rest of skogai. Small and still growing.
