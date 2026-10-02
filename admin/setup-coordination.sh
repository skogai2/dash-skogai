#!/usr/bin/env bash
# Run with: sudo bash admin/setup-coordination.sh
# Sets up /skogai as a shared multi-agent workspace (dash-skogai) so
# gptme-coordination can be tested with real separate users.
# Idempotent. Creates: group `skogai`, test users `claude` and `dot`
# (only if missing), and a setgid, group-writable /skogai/coordination.
set -euo pipefail

[ "$(id -u)" -eq 0 ] || { echo "run as root (sudo)" >&2; exit 1; }

HUMANS=(skogix)                  # human members of the group
AGENTS=(claude dot)              # agent system users, created if missing
ROOT=/skogai
COORD=$ROOT/coordination

getent group skogai >/dev/null || groupadd --system skogai

for a in "${AGENTS[@]}"; do
  if ! id "$a" >/dev/null 2>&1; then
    useradd --system --create-home --home-dir "/home/$a" \
            --shell /usr/bin/nologin --gid skogai "$a"
  fi
  usermod -aG skogai "$a"
done
for h in "${HUMANS[@]}"; do usermod -aG skogai "$h"; done

# /skogai: owned by skogix, group skogai, setgid so new files inherit the group
chown skogix:skogai "$ROOT"
chmod 2775 "$ROOT"

# coordination dir: SQLite WAL needs every agent to create/write -wal/-shm files
mkdir -p "$COORD"
chown skogix:skogai "$COORD"
chmod 2775 "$COORD"

# SQLite creates new DB files as 0644 (no umask/ACL can add group-write), and gives
# its -wal/-shm files the same mode as the main DB. So pre-create the DB as 0664.
[ -e "$COORD/coord.db" ] || { : > "$COORD/coord.db"; chown skogix:skogai "$COORD/coord.db"; }
chmod 664 "$COORD/coord.db"
# drop the default ACL an earlier version of this script set: it only produced
# a misleading r-- mask on 0644 files
command -v setfacl >/dev/null && setfacl -k "$COORD" || true

echo "done:"
ls -ld "$ROOT" "$COORD"
id skogix; for a in "${AGENTS[@]}"; do id "$a"; done
echo
echo "NOTE: skogix needs a new login (or 'newgrp skogai') to pick up the group."
echo "Test as an agent, e.g.:"
echo "  sudo -u dot env COORDINATION_DB=$COORD/coord.db gptme-coordination announce dot"
echo "(gptme-coordination is in ~/.local/bin of skogix; the agents may need its full path"
echo " or their own install via 'uv tool install')."
