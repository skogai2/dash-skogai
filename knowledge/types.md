---
type: Reference
title: skogai types — named, not yet defined
description: The knowledge types skogai has named so far; none is defined yet, and four carry an older schema wording as the candidate.
tags: [types, global, to-be-defined]
status: draft
generated: { by: "claude-code/claude-opus-5-5", at: "2026-10-10T23:22:13Z" }
verified: { by: "human:skogix", at: "2026-10-10T23:22:13Z" }
sources:
  - id: interview
    resource: https://github.com/skogai2/skogai/blob/master/.skogai/workorders/0020-interview-skogai-glossary-and-layout.md
    title: Interview workorder 0020
  - id: decision-0007
    resource: https://github.com/skogai2/skogai/blob/master/.skogai/knowledge/decisions/0007-knowledge-and-memory.md
    title: Decision 0007 — knowledge and memory
  - id: write-commit-push
    resource: https://github.com/skogai2/skogai/blob/master/.skogai/knowledge/principles/write-commit-push.md
    title: Principle — write, commit, push
---

# Types

**No type is defined yet.**[^interview] This page lists the types that are
named, so that the names are shared while the definitions are open. The
set is not closed: there are many types missing.[^decision-0007]

## To be defined, with a candidate wording

The candidates are skogix's older schemas. They are starting points, not
definitions.[^interview]

| Type | Candidate |
|---|---|
| principle | A defeasible axiom, always in scope until argued out of place. |
| pattern | A recurring "do it like this", timeless, built up from repetition. |
| decision | A past, closed choice, with who decided and why. |
| list | Append-only entries where position carries meaning. |

"Write, commit, push" is an example of an instance of a principle. It stays
staged in skogai's local knowledge until principle itself is
defined.[^interview][^write-commit-push]

## To be defined, name only

| Type | Note |
|---|---|
| tool | Will define what a tool manages across the [layout](layout.md), as in `type: tool; name: wt`. |
| router | In use as `type: router` on `SKOGAI.md` and `ROUTES.md`. |
| event | One entry in global memory. |
| rule | A skogfence, not knowledge. |
| workorder | See the [glossary](glossary.md). |

[^interview]: Interview workorder 0020
[^decision-0007]: Decision 0007 — knowledge and memory
[^write-commit-push]: Principle — write, commit, push
