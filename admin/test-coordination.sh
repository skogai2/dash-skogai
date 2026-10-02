#!/usr/bin/env bash
# Run with: sudo bash admin/test-coordination.sh
# Exercises gptme-coordination across real users (dot, claude, skogix) on /skogai.
set -u
G=/skogai/bin/gptme-coordination
export COORDINATION_DB=/skogai/coordination/coord.db
as() { local u=$1; shift; sudo -u "$u" env COORDINATION_DB=$COORDINATION_DB "$@"; }
step() { echo; echo "== $*"; }

step "binary runnable by agents"
as dot "$G" --help >/dev/null && echo ok-dot
as claude "$G" --help >/dev/null && echo ok-claude

step "announce from each user (first write creates DB + wal/shm as that user)"
as dot    "$G" announce dot
as claude "$G" announce claude

step "claim contention across users: dot first, claude should be DENIED"
as dot    "$G" work-claim dot xuser-1
as claude "$G" work-claim claude xuser-1

step "cross-user messaging"
as claude "$G" send claude "handoff xuser-1 -> dot" --to dot
as dot    "$G" inbox dot

step "concurrent writers: 20 parallel sends from each of dot and claude"
for i in $(seq 20); do
  as dot    "$G" send dot    "burst $i" >/dev/null 2>&1 &
  as claude "$G" send claude "burst $i" >/dev/null 2>&1 &
done; wait
as dot "$G" inbox dot 2>&1 | grep -c burst | sed 's/^/burst messages stored (want 40): /'

step "work-complete by non-holder must fail, holder must succeed"
as claude "$G" work-complete claude xuser-1
as dot    "$G" work-complete dot xuser-1 --result ok

step "file ownership/modes (want group skogai, group rw)"
ls -la /skogai/coordination

step "skogix (human) reads same DB"
as skogix "$G" status

step "cleanup (truncate keeps the 0664 mode)"
read -rp "reset to empty DB? [y/N] " a
if [ "${a:-n}" = y ]; then rm -f /skogai/coordination/coord.db-wal /skogai/coordination/coord.db-shm; : > /skogai/coordination/coord.db; echo reset; fi
