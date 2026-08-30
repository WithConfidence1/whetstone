# Whetstone

Bring a dull ask, leave with an edge.

Two Claude Code skills that interview you, one question at a time, until a
rough idea becomes a precise prompt: what you want, what you do not want,
the context a fresh session needs, and how you will judge the result.

A conceptual fork of Matt Pocock's grill-me and grill-with-docs
(github.com/mattpocock/skills), retargeted at the opening ask instead of
the project plan.

## The pair

- `whetstone`: portable. Works anywhere, on anything, no repo needed.
  Hands the compiled prompt back in chat.
- `whetstone-with-context`: reads before it asks. Pointed mode (you name a
  file or folder and it reads only that), vault mode, or repo mode. Opens
  with what it already knows, asks only what it cannot answer, saves the
  compiled brief to disk with a provenance line.

## Install

```bash
./install.sh
```

Symlinks both skills into `~/.claude/skills/`. Run once per machine;
`git pull` updates both skills everywhere.

## Design

See `docs/2026-08-30-whetstone-design.md`.
