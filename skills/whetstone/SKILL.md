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
