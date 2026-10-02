#!/usr/bin/env bash
# Run as a human admin (no sudo needed if you own /skogai):
#   bash admin/install-coordination.sh [path-to-gptme-coordination-source]
# (Re)builds the shared gptme-coordination install used by all agents:
#   /skogai/tools/coordination-venv  (non-editable, system python)
#   /skogai/bin/gptme-coordination   (symlink; put /skogai/bin on PATH)
# Agents cannot use binaries in a human's home dir, hence the shared install.
set -euo pipefail
SRC=${1:-$HOME/claude/gptme-contrib/packages/gptme-coordination}
VENV=/skogai/tools/coordination-venv
[ -f "$SRC/pyproject.toml" ] || { echo "no pyproject.toml in $SRC" >&2; exit 1; }
mkdir -p /skogai/tools /skogai/bin
chmod 2775 /skogai/tools /skogai/bin
uv venv --clear --python /usr/bin/python3 "$VENV"
uv pip install --python "$VENV/bin/python" "$SRC"
ln -sf "$VENV/bin/gptme-coordination" /skogai/bin/gptme-coordination
chmod -R g+rX,o+rX /skogai/tools
"$VENV/bin/gptme-coordination" --help >/dev/null && echo "installed from $SRC"
