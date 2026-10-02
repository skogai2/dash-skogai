#!/usr/bin/env bash
# Stop hook: extract candidate memories from the session transcript into
# ~/claude/.skogai/memory/pending-updates.md for review.
#
# gptme-cc-memory-stop-hook only looks at the CC_TRAJECTORY_FILE env var (it
# doesn't read stdin itself), but Claude Code's Stop hook delivers the
# transcript path via stdin JSON ("transcript_path"), not an env var. This
# wrapper bridges the two: read stdin once, pull transcript_path out with
# Python's stdlib json (no jq dependency), export it, then hand off.
set -euo pipefail

input="$(cat)"

transcript_path="$(python3 -c '
import json, sys
try:
    data = json.loads(sys.stdin.read())
    print(data.get("transcript_path", ""))
except Exception:
    pass
' <<<"$input")"

if [[ -z "$transcript_path" || ! -f "$transcript_path" ]]; then
  exit 0  # graceful degradation — no transcript available
fi

export CC_TRAJECTORY_FILE="$transcript_path"
export GPTME_CC_MEMORY_DIR="/home/skogix/claude/.skogai"

# Prefer the shared dash-skogai install (pinned, portable, see /skogai README),
# fall back to a user-level `uv tool install`. SKOGAI_BIN overrides the location.
bin="${SKOGAI_BIN:-/skogai/bin}/gptme-cc-memory-stop-hook"
[[ -x "$bin" ]] || bin="$(command -v gptme-cc-memory-stop-hook || true)"
if [[ -n "$bin" ]]; then
  exec "$bin"
fi

exit 0  # graceful degradation — tool not installed
