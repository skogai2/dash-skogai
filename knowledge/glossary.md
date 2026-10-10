---
type: Glossary
title: skogai glossary
description: The shared skogai vocabulary — places, knowledge and memory, orchestration — one concise definition per term, with unsettled terms marked.
tags: [glossary, global, vocabulary]
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
  - id: decision-0004
    resource: https://github.com/skogai2/skogai/blob/master/.skogai/knowledge/decisions/0004-knowledge-lifecycle.md
    title: Decision 0004 — knowledge lifecycle
  - id: decision-0005
    resource: https://github.com/skogai2/skogai/blob/master/.skogai/knowledge/decisions/0005-dash-and-dot-skogai.md
    title: Decision 0005 — dash- and dot-skogai
  - id: decision-0006
    resource: https://github.com/skogai2/skogai/blob/master/.skogai/knowledge/decisions/0006-push-on-land.md
    title: Decision 0006 — push on land
  - id: decision-0007
    resource: https://github.com/skogai2/skogai/blob/master/.skogai/knowledge/decisions/0007-knowledge-and-memory.md
    title: Decision 0007 — knowledge and memory
  - id: routing-glossary
    resource: https://github.com/skogai2/skogai-routing/blob/master/SKOGAI-ROUTING-GLOSSARY.md
    title: skogai-routing glossary
  - id: routing-dash
    resource: https://github.com/skogai2/skogai-routing/blob/master/skills/skogai-routing/references/dash-skogai.md
    title: skogai-routing reference — dash-skogai
  - id: routing-dot
    resource: https://github.com/skogai2/skogai-routing/blob/master/skills/skogai-routing/references/dot-skogai.md
    title: skogai-routing reference — dot-skogai
  - id: skogfences
    resource: https://github.com/skogai2/skogai-routing/blob/master/skills/skogai-routing/references/skogfences.md
    title: skogfences — "welcome away from home"
---

# Glossary

One definition per term. Terms marked **to be defined** or **unsolved** are
named but not settled. The page stays `status: draft` while any remain.
The directory each place term names is in [layout](layout.md).

## Places and layers

- **dash-skogai** (`/skogai`): the definition. The template base, the
  globally shared state, the interface: the things skogai shares are
  defined here.[^interview] "dash" is the file-safe name for the leading
  `/`.[^routing-dash]
- **dot-skogai** (`.skogai`): an implementation. An instance of what
  dash-skogai defines. Every `.skogai` directory is one, exactly like every
  other dotfolder: `~/.skogai` and `<repo>/.skogai` alike. Everything in a
  dot-skogai is by definition also in dash-skogai, if done
  correctly.[^interview] "dot" is the file-safe name for the leading
  `.`.[^routing-dot]
- **global**: true-ish whatever the environment, reader or time. Lives in
  dash-skogai.[^decision-0007]
- **local**: like global, but context matters: the project, its owner, its
  state. Lives in a dot-skogai.[^decision-0007]
- **router**: a file that routes instead of teaching: it links, references
  or injects the context it owns. Carries `type: router`. In a dot-skogai
  the routers are `SKOGAI.md` and `ROUTES.md`.[^interview][^routing-glossary]
- **skogfences**: enforcement that is structural, not behavioral: users,
  groups, permissions, separate homes. "The best way to enforce a rule is
  for it not to be an option to begin with."[^skogfences][^decision-0007]
- **bin**: meant to be in `PATH`, no file ending, and should be actively
  used over most other alternatives.[^interview]
- **scripts**: classic `chmod +x` scripts with a file ending such as `.sh`
  or `.py`.[^interview]
- **config**: contains configuration files.[^interview]
- **state**: contains state. Example: a read-marker.[^interview]
- **logs**: runtime output. Globally ignored by git.[^interview]
- **worktrees**: runtime git worktrees, one per workorder branch. Globally
  ignored by git.[^decision-0002]
- **root**: **unsolved.** skogix will redefine it. The skogai-routing
  glossary uses it for both the closest `.git` folder and the one routing
  file there.[^routing-glossary]
- **agent home**: **to be defined.** An agent's own Unix home is an instance
  of a concept that is not defined yet.[^interview][^skogfences]

## Knowledge and memory

- **knowledge**: what lasts.[^decision-0007]
- **memory**: what expires. Writing memory is always okay; the one
  requirement is that it is maintained.[^decision-0007]
- **global knowledge**: knowledge in `/skogai/knowledge/`. No
  `stale_after`.[^decision-0007]
- **local knowledge**: knowledge in a dot-skogai's `knowledge/`. May carry
  `stale_after`.[^decision-0007]
- **global memory**: shared once, to be acted on. An append-only list of
  events in `/skogai/memory/`.[^decision-0007]
- **local memory**: anything, in any form, with a best-before date, in a
  dot-skogai's `memory/`.[^decision-0007]
- **event**: one entry in global memory. Never edited.[^decision-0007]
- **read-marker**: a reader's record of the last global memory event it
  read. Only the marker moves.[^decision-0007]
- **best-before**: the date a local memory expires (`stale_after`). On
  expiry it becomes knowledge, state, action, or it is
  forgotten.[^decision-0007]
- **promotion**: the way upward through repetition. A local memory that
  keeps recurring becomes a pattern; a pattern that holds everywhere can
  become a principle.[^decision-0007]
- **rule**: a skogfence, not knowledge. Knowledge may describe a fence; it
  never stands in for one.[^decision-0007]
- **principle**, **pattern**, **decision**, **list**, **tool**: **to be
  defined.** See [types](types.md).

## Orchestration

- **orchestrator**: the main session. It writes workorders, dispatches
  them, checks results and lands them.[^decision-0002]
- **worker**: an agent that implements exactly one
  workorder.[^decision-0002]
- **land**: merge a finished workorder and push it to an origin we own. A
  change counts once it reaches origin.[^decision-0006]
- **workorder**: **to be defined.** Three words are in use for the same
  place, `workorders/`:
  - "workorder", a file with `status: open|done|blocked`;[^decision-0002]
  - "raw layer", the immutable record that knowledge pages
    summarize;[^decision-0004]
  - "action", an append-only list, in the orchestrator's layout draft and
    as one of the best-before outcomes.[^interview][^decision-0007]

## Deferred

- **ownership**, **leaf**: defined in the skogai-routing glossary, not
  adopted here yet. skogai-routing is left as it is for
  now.[^interview][^routing-glossary]

[^interview]: Interview workorder 0020
[^decision-0002]: Decision 0002 — orchestration model
[^decision-0004]: Decision 0004 — knowledge lifecycle
[^decision-0006]: Decision 0006 — push on land
[^decision-0007]: Decision 0007 — knowledge and memory
[^routing-glossary]: skogai-routing glossary
[^routing-dash]: skogai-routing reference — dash-skogai
[^routing-dot]: skogai-routing reference — dot-skogai
[^skogfences]: skogfences — "welcome away from home"
