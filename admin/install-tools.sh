#!/usr/bin/env bash
# Run as a human admin (no sudo needed if you own /skogai):
#   bash admin/install-tools.sh
# Installs the shared runtimes (uv, python) under tools/mise and (re)generates
# the bin/ launchers for gptme core and every gptme-contrib package. Agents
# cannot use binaries in a human's home dir, hence the shared install.
# Works from any checkout path, so a container can clone dash-skogai anywhere.
set -euo pipefail
ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
command -v mise >/dev/null || { echo "mise not found (https://mise.run)" >&2; exit 1; }
git -C "$ROOT" submodule update --init gptme-contrib

mkdir -p "$ROOT/tools" "$ROOT/bin"
# 755, not group-writable: bin/ launchers are executed by every user of this
# install (human and agents), so a group-writable bin/ would let any agent plant
# code that runs as another user. Only this admin script writes here.
chmod 755 "$ROOT/tools" "$ROOT/bin" 2>/dev/null || true

export MISE_DATA_DIR="$ROOT/tools/mise"
mise trust -q "$ROOT/mise.toml"
mise -C "$ROOT" install uv python  # named: don't pull in system-config tools
"$(mise -C "$ROOT" which python)" "$ROOT/scripts/gen-bin.py"

# also drop any group/other write left over from older installs (previously 2775)
chmod -R g+rX,o+rX,go-w "$ROOT/tools" "$ROOT/bin"
"$ROOT/bin/gptme-coordination" --help >/dev/null && echo "installed under $ROOT"
