#!/usr/bin/env bash
set -euo pipefail

# Claude Code WorktreeCreate hook: delegates the actual `git worktree add` to
# `wt switch --create` so worktrunk's own pre-start hooks (submodule init,
# docs fetch — see .config/wt.toml) finish before the session starts, instead
# of Claude Code's default git-only worktree creation.
#
# The installed `wt` doesn't have --path yet, so the on-disk layout comes
# from the global worktree-path template in the user's own
# ~/.config/worktrunk/config.toml instead of a flag here — currently
# .skogai/worktrees/<name>, not Claude Code's own .claude/worktrees/ default.
#
# One-time setup: run `wt config approvals add` by hand before this works —
# a hook has no TTY to prompt for approval of .config/wt.toml's commands.

name=$(jq -r '.name')

cd "$CLAUDE_PROJECT_DIR"

result=$(wt switch --create "$name" --no-cd --format json)

echo "$result" | jq -r '.path'
