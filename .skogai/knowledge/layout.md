---
type: Layout
title: The .skogai layout
description: The one directory tree that dash-skogai defines and every .skogai instantiates, with the glossary term each entry is.
tags: [layout, global, dot-skogai, dash-skogai]
status: draft
generated: { by: "claude-code/claude-opus-5-5", at: "2026-10-10T23:22:13Z" }
verified: { by: "human:skogix", at: "2026-10-10T23:22:13Z" }
sources:
  - id: interview
    resource: https://github.com/skogai2/skogai/blob/master/.skogai/workorders/0020-interview-skogai-glossary-and-layout.md
    title: Interview workorder 0020
  - id: decision-0002
    resource: https://github.com/skogai2/skogai/blob/master/.skogai/knowledge/decisions/0002-orchestration-model.md
    title: Decision 0002 — orchestration model
  - id: decision-0007
    resource: https://github.com/skogai2/skogai/blob/master/.skogai/knowledge/decisions/0007-knowledge-and-memory.md
    title: Decision 0007 — knowledge and memory
---

# The .skogai layout

There is one layout. dash-skogai (`/skogai`) defines it, and every
dot-skogai (`.skogai`) is an instance of it. Everything in a dot-skogai is
by definition also in dash-skogai, if done correctly.[^interview]

```
.skogai/
  SKOGAI.md      router: the entry point
  ROUTES.md      router: the sub-router that skogai manages
  knowledge/     knowledge (an OKF bundle)
  memory/        memory
  bin/           bin
  scripts/       scripts
  config/        config
  state/         state
  workorders/    workorder (to be defined)
  logs/          logs
  worktrees/     worktrees
```

## Entries

Each entry is the [glossary](glossary.md) term in the second column.

| Entry | Term | Holds |
|---|---|---|
| `SKOGAI.md` | router | The entry point of a dot-skogai. |
| `ROUTES.md` | router | A separate sub-router which explicitly is managed by skogai.[^interview] |
| `knowledge/` | knowledge | What lasts. Global in `/skogai/knowledge/`, local elsewhere.[^decision-0007] |
| `memory/` | memory | What expires. Global memory is append-only events; local memory is anything, maintained, with a best-before.[^decision-0007] |
| `bin/` | bin | Meant to be in `PATH`, no file ending, actively used over most other alternatives.[^interview] |
| `scripts/` | scripts | Classic `chmod +x` scripts with a file ending such as `.sh` or `.py`.[^interview] |
| `config/` | config | Configuration files.[^interview] |
| `state/` | state | State, for example the read-marker for `/skogai/memory/`.[^interview] |
| `workorders/` | workorder | To be defined; see the glossary.[^decision-0002] |
| `logs/` | logs | Runtime output, globally ignored.[^interview] |
| `worktrees/` | worktrees | Runtime git worktrees, globally ignored.[^decision-0002] |

## Tools own a slice of each directory

A tool can be given its own name under several of these directories. For
`wt`, the potential things "managed by wt" are:[^interview]

```
./bin/wt
./scripts/wt/
./state/wt/
./config/wt/
```

This is not defined yet. It will be defined under a type such as
`type: tool; name: wt`. See [types](types.md).

[^interview]: Interview workorder 0020
[^decision-0002]: Decision 0002 — orchestration model
[^decision-0007]: Decision 0007 — knowledge and memory
