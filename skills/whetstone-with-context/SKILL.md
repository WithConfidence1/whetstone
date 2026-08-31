---
name: whetstone-with-context
description: Use when Taylor wants an ask sharpened against real material, says whetstone this with a named file or folder, or runs whetstone inside Vault 8.0 or a git repo where the context should be read first. Reads before it asks, opens with what it already knows, interviews only the gaps, and saves the compiled prompt to disk with a provenance line. Planning only.
---

# Whetstone, With Context

The same stone, but the material comes to the table first. Read before
you ask; never spend one of Taylor's answers on something a file already
says.

This skill IS the whetstone skill plus context handling. First read
`~/.claude/skills/whetstone/SKILL.md` and adopt everything in it: the
hard gate, the interview engine, the four dimensions, the edge check,
the red flags. Then apply the additions below. If that path does not
exist, read the sibling folder `../whetstone/SKILL.md` relative to this
file. The question bank and edge template live in that skill's
references folder.

## Context Modes

Pick exactly one, in this order of precedence:

1. **Pointed mode**: Taylor named a file or folder (as an argument or in
   his sentence). Read only what he named, recursively for a folder.
   Nothing else enters the record: no vault sweep, no memory files, no
   sibling folders. This is an isolation guarantee, not a convenience.
   If the named path does not exist, say so and ask for the right one.
2. **Vault mode**: the working directory is inside a vault governed by a
   CLAUDE.md. Read that CLAUDE.md first and let it govern. Follow its
   map to the folders the ask implicates, and obey its physics exactly.
   In Vault 8.0 the map is the numbered folders and the physics are the
   numbered laws under them; `71_The Orrery` is sealed and stays unread
   unless Taylor names it.
   Do not run `.machine/vault6.py` or its MCP tools. That compiler
   predates the V8 reorganization and indexes folders that no longer
   exist, and `.machine/README-V8.md` says to leave it alone until
   Taylor re-points or retires it. If a vault's CLAUDE.md does name a
   working compiler, use it as that CLAUDE.md directs.
3. **Repo mode**: any other git project. Sweep README, CLAUDE.md, the
   directory layout, and recent git log. Read files that the ask
   plainly implicates; do not read the whole tree.

## Stipulations

Open the interview with a short block, before the first question:

```
Stipulated (in the record, will not ask):
- <fact>: <source file or tool>
- ...
```

Keep it under ten lines. Every stipulation must cite where it came from.
Then run the edge check: swept context often starts the score above 2,
and dimensions the context already sharpened are marked sharp.

## Compiling, Provenance, Saving

Compile with the base skill's references/edge-template.md, including the
Record section: every source read, one per line, and what was
deliberately not read. Read the compiled prompt back, then the same one
question: fire here or hand it over.

Either way, save the brief first:

- Inside Vault 8.0: the brief gets no folder of its own, because V8
  physics forbids a separate outputs folder. If the ask belongs to a
  live matter or project, save it beside that work inside `10_Work/`,
  in the case or project folder itself. Otherwise save to `00_Inbox/`,
  the single airlock. Name it `YYYY-MM-DD <short-slug>.md`. Never write
  to the vault root.
- Inside any other git repo: `docs/whetstone/YYYY-MM-DD-<short-slug>.md`
- Anywhere else: do not write to disk unbidden; hand the prompt back and
  save it only where Taylor says.

The saved file is the compiled prompt exactly as read back, nothing
more.

## Extra Red Flags

| Thought | Reality |
|---------|---------|
| "Useful context sits just outside the pointed path" | The point of pointed mode is that it stays outside. Ask Taylor if he wants it in. |
| "I will skim the whole vault to be thorough" | Modes exist because thorough is not the same as safe. Follow the mode. |
| "There is a compiler in `.machine`, I should run it" | Read `.machine/README-V8.md` first. Vault 8.0's compiler is stale and indexes folders that no longer exist. |
| "The context answers everything, skip the interview" | Context cannot state what he wants ground off. Ask at least that. |
