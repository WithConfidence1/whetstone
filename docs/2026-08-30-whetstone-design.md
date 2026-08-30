# Whetstone Design

Date: 2026-08-30. Approved by Taylor in session.

## Purpose

Taylor has tons of ideas and opens with rough asks (his words: "a 2/10 prompt"). Whetstone interviews him, one question at a time, until the rough ask becomes a 10/10 prompt: precise on what he wants, precise on what he does not want, carrying enough context for a fresh Claude session to crush it. Conceptual fork of Matt Pocock's grill-me / grill-with-docs pair (github.com/mattpocock/skills), retargeted at the opening ask instead of a project plan.

## The pair

Two skills in this repo, installed together on every machine.

### whetstone (portable)

Works anywhere, on anything, no repo needed. Stateless: hands the compiled prompt back in chat.

- Interview engine from grill-me, unchanged: one question at a time, never compound, never assume, every question carries a recommended answer, dependencies resolved in order, look instead of asking when looking can answer.
- Four dimensions worked until each holds an edge:
  1. The Point: what exists when this is done, in what form, for whom, at what size.
  2. The Steel: context in Taylor's head that Claude cannot derive (facts, history, taste references, prior attempts).
  3. What Gets Ground Off: anti-goals. What not to touch, what done does not include, what would make the result a failure even if it technically answers. Sharpening is subtraction.
  4. The Test Cut: how Taylor will judge it. Acceptance criteria or an example of good.
- Edge check after every answer: one line with current score out of 10 and which dimensions are still dull.
- At 10: compile the finished prompt from the edge template, read it back, then exactly two options: fire it in this session, or hand it over to paste into a fresh session.
- Hard gate: the skill never starts the work itself. Its only deliverable is the prompt.

### whetstone-with-context (stateful)

Everything above, plus three context modes picked by invocation:

1. Pointed mode: Taylor names a file or folder (argument or plain speech). Read only what he named. Nothing else enters the record. This is the isolation guarantee: pointing at a case folder means no restricted material bleeds in from elsewhere.
2. Vault mode: inside Vault 6.0 with no target named, compile through the profile machinery (.machine/vault6.py or the three MCP tools).
3. Repo mode: any other project, sweep the repo, CLAUDE.md, git history, memory files.

Behavior additions:

- Opens with Stipulations: a short list of what it already knows and will not spend questions on, each with its source.
- Only asks what the swept context cannot answer.
- The compiled prompt ends with a Record line: exactly which sources were read and which were deliberately not.
- Saves the compiled brief to disk so a dated library of asks accumulates: in Vault 6.0, `95_Artifacts/Whetstone/`; in a git repo, `docs/whetstone/`; otherwise hand back in chat and offer to save wherever Taylor says.

## Quality enforcement

Both SKILL.md files carry superpowers-grade discipline: a HARD-GATE block, a checklist, and a red-flags table for rationalizations ("I have enough to proceed", "this question is too obvious to ask").

## Distribution

Skills are per-machine files. This repo is the single source of truth; `install.sh` symlinks both skill folders into `~/.claude/skills/`. Taylor publishes via GitHub Desktop; each machine clones and runs install once, then `git pull` updates both.

## Acceptance

The build is done when a real specimen passes: Taylor supplies an actual recent 2/10 first ask, `/whetstone` runs on it live, and the session produces a prompt he calls a 10. The specimen and result become `evals/specimen-01.md`.
