---
okf_version: "0.2"
okf_bundle_name: "dash-skogai"
okf_bundle_purpose: "Global skogai knowledge: the shared vocabulary and the .skogai layout that every skogai repo and agent uses."
---

# dash-skogai Knowledge

Global knowledge for skogai. dash-skogai is installed as `/skogai`, so this
bundle is `/skogai/knowledge/`. What is shared between skogai repos and
agents is defined here; every `.skogai/` is an instance of it.

Global knowledge carries no `stale_after`. An entry marked **to be defined**
or **unsolved** is named but not settled: do not rely on a meaning for it.

## Pages

* [Glossary](glossary.md) - the shared skogai terms, one concise definition each.
* [Layout](layout.md) - the `.skogai/` directories and routers, and the glossary term each one is.
* [Types](types.md) - the named knowledge types; none is defined yet.
* [Log](log.md) - chronological update history.
