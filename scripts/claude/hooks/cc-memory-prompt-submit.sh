#!/usr/bin/env bash
# UserPromptSubmit hook: inject relevant memories from ~/claude/.skogai/memory/.
#
# Delegates to gptme-cc-memory-prompt-submit, which reads
# the hook's stdin JSON itself (session_id, transcript_path, prompt). We only
# need to point it at the right memory workspace via GPTME_CC_MEMORY_DIR,
# which it treats as the parent of a "memory/" subdirectory.
set -euo pipefail

export GPTME_CC_MEMORY_DIR="/home/skogix/claude/.skogai"

# Prefer the shared dash-skogai install (pinned, portable, see /skogai README),
# fall back to a user-level `uv tool install`. SKOGAI_BIN overrides the location.
bin="${SKOGAI_BIN:-/skogai/bin}/gptme-cc-memory-prompt-submit"
[[ -x "$bin" ]] || bin="$(command -v gptme-cc-memory-prompt-submit || true)"
if [[ -n "$bin" ]]; then
  exec "$bin"
fi

exit 0  # graceful degradation — tool not installed
