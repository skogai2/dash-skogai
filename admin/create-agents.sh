#!/usr/bin/env bash
# Run with: sudo bash admin/create-agents.sh [name ...]
# Creates the `skogai` group and any missing agent system users, and adds
# them (and the human users in HUMANS) to the group. Idempotent.
# Default agents: claude dot amy goose. Existing users are left untouched
# apart from group membership.
set -euo pipefail
[ "$(id -u)" -eq 0 ] || { echo "run as root (sudo)" >&2; exit 1; }

HUMANS=(skogix)                       # add aldervall here if that user exists
AGENTS=("$@"); [ ${#AGENTS[@]} -gt 0 ] || AGENTS=(claude dot amy goose)

getent group skogai >/dev/null || { groupadd --system skogai; echo "created group skogai"; }

for a in "${AGENTS[@]}"; do
  if id "$a" >/dev/null 2>&1; then
    echo "exists:  $a"
  else
    useradd --system --create-home --home-dir "/home/$a" \
            --shell /usr/bin/nologin --gid skogai "$a"
    echo "created: $a"
  fi
  usermod -aG skogai "$a"
done
for h in "${HUMANS[@]}"; do
  id "$h" >/dev/null 2>&1 && usermod -aG skogai "$h" || echo "skip human (no such user): $h"
done

echo; getent group skogai
