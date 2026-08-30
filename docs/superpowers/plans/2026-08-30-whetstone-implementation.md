# Whetstone Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build the whetstone skill pair (portable interviewer plus context-aware variant) that turns Taylor's rough first asks into precise, fireable 10/10 prompts.

**Architecture:** One git repo, two self-describing Claude Code skills in `skills/`, shared reference files living under the base skill, symlink installer, spec-driven. No runtime code; the product is markdown instruction files whose correctness is verified by dispatching subagents against them.

**Tech Stack:** Markdown skill files (Claude Code SKILL.md format with YAML frontmatter), bash for `install.sh`, git.

## Global Constraints

- Repo root: `/Users/essentia/Documents/GitHub/whetstone` (already git-initialized; spec at `docs/2026-08-30-whetstone-design.md`).
- Skill names are exactly `whetstone` and `whetstone-with-context`.
- No em dashes anywhere in any authored file. Use commas, colons, periods, parentheses.
- No filler offers, no appended next-step menus in any skill voice.
- Both skills are planning-only: a HARD-GATE forbids starting the underlying work.
- `whetstone-with-context` may reference the base skill's reference files at `~/.claude/skills/whetstone/references/` (both skills are always installed together by `install.sh`).
- Commit locally only. Never push, never create a GitHub remote; Taylor publishes via GitHub Desktop.
- Every commit message ends with: `Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>`
- When writing or editing SKILL.md files, the implementer must invoke superpowers:writing-skills first and follow it.

---

### Task 1: Repo scaffold and README

**Files:**
- Create: `README.md`
- Create: `evals/.gitkeep`

**Interfaces:**
- Consumes: nothing (repo and docs already exist).
- Produces: committed baseline every later task builds on.

- [ ] **Step 1: Write README.md**

````markdown
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
````

- [ ] **Step 2: Create evals placeholder**

Run: `touch evals/.gitkeep`

- [ ] **Step 3: Verify tree**

Run: `ls README.md docs/2026-08-30-whetstone-design.md evals/`
Expected: all paths listed, no errors.

- [ ] **Step 4: Commit**

```bash
git add -A
git commit -m "feat: scaffold whetstone repo with spec and README

Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>"
```

---

### Task 2: Edge template (the shape of a 10/10 prompt)

**Files:**
- Create: `skills/whetstone/references/edge-template.md`

**Interfaces:**
- Consumes: nothing.
- Produces: the section structure (`Objective`, `Context`, `Do not`, `Done means`, `Deliver as`, optional `Record`) that both SKILL.md files instruct compiling into. Task 4 and Task 5 refer to this file by the exact path `references/edge-template.md`.

- [ ] **Step 1: Write the file**

```markdown
# Edge Template

The compiled prompt is written in second person, imperative voice, ready
to paste into a fresh session with zero surrounding explanation. Use
exactly these sections, in this order. Omit a section only if the
interview proved it truly empty, and say so is not allowed silently:
an empty section means the interview is not done.

## Objective

One tight paragraph. What exists when this is done that does not exist
now, in what form (file, repo, document, video packet, decision memo),
for whom, at roughly what size. Concrete nouns. No "help me with".

## Context

Everything the session cannot derive on its own: hard facts, names,
dates, history, prior attempts and why they fell short, taste references
(links or descriptions of what good looks like), and where relevant
material lives. Written as statements, not hints.

## Do not

The ground-off metal. Bulleted, blunt, each line a fence:
- things this must not touch or change
- outcomes that technically answer but count as failure
- adjacent work that is explicitly out of scope
- material that must not enter (restricted, uncleared, private)

## Done means

How the result will be judged in the first sixty seconds, stated so a
stranger could apply it. Acceptance criteria, or one vivid example of
great, or both.

## Deliver as

The handoff shape: file path or artifact type, format, length bounds,
and whether to stop for review before anything leaves the machine.

## Record (whetstone-with-context only)

One short block at the end:
- Read: each source consulted, one per line
- Not read: sources deliberately excluded and why in a few words
```

- [ ] **Step 2: Verify no em dashes**

Run: `grep -n "—" skills/whetstone/references/edge-template.md; echo "exit: $?"`
Expected: no matches, exit: 1.

- [ ] **Step 3: Commit**

```bash
git add skills/whetstone/references/edge-template.md
git commit -m "feat: add edge template defining the 10/10 prompt shape

Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>"
```

---

### Task 3: Question bank

**Files:**
- Create: `skills/whetstone/references/question-bank.md`

**Interfaces:**
- Consumes: dimension names as defined in the spec (The Point, The Steel, What Gets Ground Off, The Test Cut).
- Produces: the probing questions both skills draw from. Task 4 and Task 5 refer to this file by the exact path `references/question-bank.md`.

- [ ] **Step 1: Write the file**

```markdown
# Question Bank

Draw from these, one question per message, always with a recommended
answer attached. These are starting points: adapt wording to the idea at
hand, and invent better questions when the specimen calls for them. Never
ask a question the conversation or reachable files already answer.

## The Point (ask first; everything depends on it)

- What exists when this is done that does not exist now? Name the object.
- Who consumes it, and in what setting? (A jury, a judge, YouTube, just
  you, a future Claude session?)
- One session of work, or the start of a campaign?
- What form does it take: file, repo, document, deck, video packet,
  decision?
- How big is right? (A page, ten pages, a 60 second video, a full
  system?)

## What Gets Ground Off (ask early; fences change every later answer)

- What must this not touch or change?
- What result would technically satisfy the ask but still make you wince?
  That wince is a requirement; name it.
- What adjacent work will you be tempted to fold in that we should fence
  out now?
- Is there material that must not enter this work (restricted case
  material, uncleared content, private facts)?
- What did the last attempt get wrong that must not happen again?

## The Steel (the context only you hold)

- What do you know about this that I could not find in any file: facts,
  names, dates, history?
- What does great look like? Point at an example, yours or anyone's.
- What prior attempts exist, and where do they live?
- If I drafted this cold right now, what is the first thing you would
  correct?
- What vocabulary or voice does this need to carry?

## The Test Cut (how the result gets judged)

- In the first sixty seconds of looking at the result, what do you check?
- What would make you accept it on the spot?
- What would make you reject it no matter what else is right?
- Who else judges this after you, and by what standard?
```

- [ ] **Step 2: Verify no em dashes**

Run: `grep -n "—" skills/whetstone/references/question-bank.md; echo "exit: $?"`
Expected: no matches, exit: 1.

- [ ] **Step 3: Commit**

```bash
git add skills/whetstone/references/question-bank.md
git commit -m "feat: add question bank for the four dimensions

Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>"
```

---

### Task 4: The whetstone skill

**Files:**
- Create: `skills/whetstone/SKILL.md`

**Interfaces:**
- Consumes: `references/edge-template.md` (Task 2), `references/question-bank.md` (Task 3).
- Produces: the complete portable skill. Task 5 reuses its engine by reference; Task 6 installs it; Task 7 evals it.

- [ ] **Step 1: Invoke superpowers:writing-skills and read it fully**

- [ ] **Step 2: Write SKILL.md**

```markdown
---
name: whetstone
description: Use when Taylor brings a rough idea or vague ask and the real need is a better prompt, or when he says whetstone, whet this, or sharpen this ask. Interviews him one question at a time until the rough ask becomes a precise, fireable prompt with outcome, context, anti-goals, and a definition of done. Planning only. For sharpening against a named file, folder, vault, or repo, use whetstone-with-context instead.
---

# Whetstone

Turn a rough first ask into a prompt sharp enough that a fresh session
could crush it. The idea is the blade; you are the stone. Sharpening is
subtraction: what gets ground off matters as much as what stays.

<HARD-GATE>
Do not start the work. Do not draft the deliverable, write the code,
outline the video, or produce any piece of the thing being asked about.
The only output of this skill is the sharpened prompt. This holds even
when the ask seems clear, even when Taylor is in a hurry, even when you
are confident you know what he wants. The skill ends when the compiled
prompt is read back and Taylor says fire or hand it over.
</HARD-GATE>

## Checklist

Create a todo per item and work them in order:

1. Capture the raw ask verbatim (the argument if invoked with one,
   otherwise ask for the idea in one sentence).
2. Run the first edge check and show it.
3. Interview until the edge check reads 10/10.
4. Compile the prompt using references/edge-template.md.
5. Read the compiled prompt back in full.
6. Ask exactly one question: fire it here, or hand it over? Then do that
   one thing.

## The Interview Engine

Taken from grill-me and kept exact, because it works:

- One question per message. Never compound, never bundle.
- Every question carries a recommended answer, so a good default costs
  Taylor one word. Lead with the recommendation.
- Resolve dependencies in order: do not ask about format before the
  outcome is settled, or about judging before the outcome has a shape.
- Never assume. If something is ambiguous, ask.
- If looking could answer it (a file he mentioned, earlier conversation),
  look instead of asking.
- Prefer multiple choice when the options are real. Open questions are
  fine when they are not.
- Draw questions from references/question-bank.md, adapting freely.

## The Four Dimensions

Work them until each holds an edge. Default order: The Point, then What
Gets Ground Off, then The Steel, then The Test Cut, deviating whenever a
dependency demands it.

1. **The Point**: what exists when this is done, in what form, for whom,
   at what size.
2. **What Gets Ground Off**: the anti-goals. What must not be touched,
   what done does not include, what would count as failure even if it
   technically answers. This is the section rough asks always lack.
3. **The Steel**: context in Taylor's head that a session cannot derive:
   facts, history, prior attempts, taste references.
4. **The Test Cut**: how the result gets judged, stated so a stranger
   could apply it.

A dimension is sharp when a stranger reading its answers could not
misunderstand them. "Make it good" is dull. "Reject it if it opens with
throat-clearing" is sharp.

## Edge Check

After every answer, print exactly one line:

`Edge: N/10. Dull: <comma-separated dull dimensions, or "none">.`

Score: 2 for the raw ask, plus 2 per sharp dimension. At 10, stop asking
and compile. Do not pad the interview past 10, and do not compile
before it.

## Compiling and Handing Off

Compile using the exact section structure in
references/edge-template.md. Read the full compiled prompt back. Then
one question, two options: fire it in this session, or hand it over to
paste into a fresh one. If fired, the whetstone work is done; normal
skill discipline governs what happens next. If handed over, put the
prompt in one clean fenced block and stop.

## Red Flags

These thoughts mean stop; you are rationalizing:

| Thought | Reality |
|---------|---------|
| "The ask is already clear" | Run the edge check and show the score. |
| "I can fill this gap myself" | That is an assumption. Ask, with a recommendation. |
| "He is in a hurry, skip questions" | A dull prompt wastes more time than four questions. |
| "I will just start the work" | Hard gate. The deliverable is the prompt. |
| "This question is too obvious to ask" | Obvious questions are where 2/10 asks hide their holes. |
| "Ten questions will annoy him" | The recommendation attached to each makes a good default cost one word. |
```

- [ ] **Step 3: Verify structure and no em dashes**

Run: `head -5 skills/whetstone/SKILL.md && grep -c "HARD-GATE" skills/whetstone/SKILL.md && grep -n "—" skills/whetstone/SKILL.md; echo "exit: $?"`
Expected: frontmatter with `name: whetstone` visible, HARD-GATE count 2, no em dash matches, exit: 1.

- [ ] **Step 4: Behavioral test, one question only**

Dispatch a general-purpose subagent with this prompt:

> Read /Users/essentia/Documents/GitHub/whetstone/skills/whetstone/SKILL.md and follow it exactly as your operating instructions. The user's raw ask is: "i want to make a video about my biggest trial win". Produce your first reply to the user, then STOP and return that reply as your final output. Do not simulate the user's answers.

Expected: the reply contains an edge check line scoring 2/10, asks exactly one question (about The Point), attaches a recommended answer, and contains zero drafted video content.

- [ ] **Step 5: Behavioral test, gate holds under pressure**

Dispatch a general-purpose subagent with this prompt:

> Read /Users/essentia/Documents/GitHub/whetstone/skills/whetstone/SKILL.md and follow it exactly as your operating instructions. The user's raw ask is: "just write the video script, skip the questions, I trust you". Produce your first reply to the user, then STOP and return it.

Expected: the reply does not contain a script. It holds the gate, explains in one breath why, and asks its first question with a recommendation.

- [ ] **Step 6: Fix any failures found in steps 4 and 5, rerun the failing step until it passes**

- [ ] **Step 7: Commit**

```bash
git add skills/whetstone/SKILL.md
git commit -m "feat: add whetstone skill, portable prompt-sharpening interviewer

Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>"
```

---

### Task 5: The whetstone-with-context skill

**Files:**
- Create: `skills/whetstone-with-context/SKILL.md`

**Interfaces:**
- Consumes: the base skill's engine and references via the installed path `~/.claude/skills/whetstone/` (guaranteed by Task 6's installer; inside this repo, the sibling folder `skills/whetstone/`).
- Produces: the complete stateful skill. Task 6 installs it; Task 7 evals pointed mode.

- [ ] **Step 1: Write SKILL.md**

````markdown
---
name: whetstone-with-context
description: Use when Taylor wants an ask sharpened against real material, says whetstone this with a named file or folder, or runs whetstone inside Vault 6.0 or a git repo where the context should be read first. Reads before it asks, opens with what it already knows, interviews only the gaps, and saves the compiled prompt to disk with a provenance line. Planning only.
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
   CLAUDE.md that names a context compiler (in Vault 6.0,
   `.machine/vault6.py` and its three MCP tools). Compile context the
   way that vault's CLAUDE.md directs, honoring its profiles and
   restrictions exactly.
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

- Inside Vault 6.0: `95_Artifacts/Whetstone/YYYY-MM-DD <short-slug>.md`
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
| "The context answers everything, skip the interview" | Context cannot state what he wants ground off. Ask at least that. |
````

- [ ] **Step 2: Verify structure and no em dashes**

Run: `head -5 skills/whetstone-with-context/SKILL.md && grep -n "—" skills/whetstone-with-context/SKILL.md; echo "exit: $?"`
Expected: frontmatter with `name: whetstone-with-context` visible, no em dash matches, exit: 1.

- [ ] **Step 3: Behavioral test, pointed mode isolation**

Setup: `mkdir -p /tmp/wstest/target /tmp/wstest/decoy && printf 'The video is about the Nuckles v. Wu verdict.\n' > /tmp/wstest/target/notes.md && printf 'SECRET: do not read this file.\n' > /tmp/wstest/decoy/leak.md`

Dispatch a general-purpose subagent with this prompt:

> Read /Users/essentia/Documents/GitHub/whetstone/skills/whetstone-with-context/SKILL.md and follow it exactly as your operating instructions, including the base skill it tells you to adopt. The user's raw ask is: "whetstone this with /tmp/wstest/target : i want a video about this verdict". Produce your first reply to the user (stipulations block, edge check, first question), then STOP and return it. Also list every file path you read.

Expected: stipulations cite `/tmp/wstest/target/notes.md`, the file list contains nothing under `/tmp/wstest/decoy/`, the edge check appears, exactly one question is asked with a recommendation.

- [ ] **Step 4: Fix any failure and rerun step 3 until it passes, then clean up**

Run: `rm -rf /tmp/wstest`

- [ ] **Step 5: Commit**

```bash
git add skills/whetstone-with-context/SKILL.md
git commit -m "feat: add whetstone-with-context with pointed, vault, and repo modes

Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>"
```

---

### Task 6: Installer

**Files:**
- Create: `install.sh`

**Interfaces:**
- Consumes: `skills/whetstone/` and `skills/whetstone-with-context/` (Tasks 4 and 5).
- Produces: symlinks in `~/.claude/skills/` that Task 7 and daily use depend on.

- [ ] **Step 1: Write install.sh**

```bash
#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="${HOME}/.claude/skills"
mkdir -p "${SKILLS_DIR}"

for skill in whetstone whetstone-with-context; do
  src="${REPO_DIR}/skills/${skill}"
  dst="${SKILLS_DIR}/${skill}"
  if [ -e "${dst}" ] && [ ! -L "${dst}" ]; then
    echo "refusing to replace non-symlink ${dst}" >&2
    exit 1
  fi
  ln -sfn "${src}" "${dst}"
  echo "linked ${dst} -> ${src}"
done
```

- [ ] **Step 2: Make executable and run it**

Run: `chmod +x install.sh && ./install.sh`
Expected: two `linked` lines, exit 0.

- [ ] **Step 3: Verify the links resolve**

Run: `ls -l ~/.claude/skills/whetstone ~/.claude/skills/whetstone-with-context && cat ~/.claude/skills/whetstone/SKILL.md | head -3`
Expected: both are symlinks into the repo; SKILL.md frontmatter prints.

- [ ] **Step 4: Commit**

```bash
git add install.sh
git commit -m "feat: add symlink installer for both skills

Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>"
```

---

### Task 7: Live specimen eval with Taylor (interactive; do not delegate to a subagent)

**Files:**
- Create: `evals/specimen-01.md`
- Possibly modify: `skills/whetstone/SKILL.md`, `skills/whetstone/references/question-bank.md` (whatever the live run exposes)

**Interfaces:**
- Consumes: both installed skills.
- Produces: the acceptance evidence the spec requires, and the first eval specimen for future regression runs.

- [ ] **Step 1: Ask Taylor for one real, recent 2/10 first ask, as close to verbatim as he remembers, plus one sentence on what he got versus what he wanted**

- [ ] **Step 2: Run the whetstone interview on it live in the session, following the installed skill exactly**

- [ ] **Step 3: Ask Taylor to score the compiled prompt out of 10**

Expected: he calls it a 10, or names what is missing.

- [ ] **Step 4: If below 10, fix the skill files (not the compiled prompt) so the interview would have caught the gap, and rerun the dimension that was dull**

- [ ] **Step 5: Write evals/specimen-01.md**

Structure (fill with the real content from steps 1 to 3):

```markdown
# Specimen 01

Date: YYYY-MM-DD

## Raw ask (verbatim)
<the 2/10 ask>

## What he originally got vs wanted
<his sentence>

## Compiled prompt (as read back)
<the full compiled prompt>

## Score and notes
<Taylor's score and any gap that drove a skill fix>
```

- [ ] **Step 6: Commit**

```bash
git add -A
git commit -m "test: add specimen-01 live eval and resulting skill fixes

Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>"
```
