---
name: capture
description: Phase 1 - Get the core idea out with zero friction. Guided capture session.
---

# /capture - Phase 1

Get the idea out of your head with zero friction.

## Prerequisites

- Phase 0 complete (or skipped)
- status.json shows Phase 1

## Before Starting: Load Incubation Context (MANDATORY)

**Step 1: Check status.json for incubation state**

```python
# Read status.json
status = read_file("status.json")
incubation_phase = status["phases"]["0-incubate"]
```

**Step 2: If incubation was completed, load the structured context**

```python
if incubation_phase["status"] == "complete":
    # Load the structured incubation context
    context_file = incubation_phase.get("contextFile", "braindump/incubation-context.md")
    incubation_context = read_file(context_file)

    # Parse key sections:
    # - "## Essence" → Core understanding
    # - "## Personal Resonance" → Why this matters
    # - "## Informed Questions for Capture" → MUST ASK these
    # - "## Tensions to Explore" → Probe points

    HAS_INCUBATION = True
else:
    HAS_INCUBATION = False
```

**Step 3: If incubation context exists, use the prepared questions**

The incubation phase prepared specific questions in `## Informed Questions for Capture`.
You MUST incorporate these into your capture flow—they were derived from:
- Prior art analysis (what patterns apply)
- Identified tensions (what needs resolving)
- Personal resonance (what motivates this user)

**Step 4: If incubation was skipped, proceed directly to capture**

---

## Process

### 0. Acknowledge Context Load (if applicable)

If incubation context was loaded, acknowledge it visibly:

```
📦 Loaded incubation context from Phase 0

Essence: {essence from incubation-context.md}
Key prior art: {list sources from Prior Art DNA table}
Prepared questions: {count} informed questions ready

This context will inform my questions without constraining your idea.
```

If no incubation (skipped or pending):

```
Starting fresh capture (no incubation context).
```

### 1. Set the Stage

```
Tell me about your project idea. Don't worry about
structure or completeness - just get it out of your head.

You can talk about:
- What you want to build
- Why you want it
- Who it's for
- What problem it solves
- Anything else on your mind

Just start talking (or typing)...
```

### 2. Accept Everything

- Be a friendly, non-judgmental listener
- Accept rambling, voice-to-text input
- Don't structure or critique
- Preserve the user's voice

### 3. Follow-up Prompts

**Generic prompts (always valid):**
- "What made you think of this?"
- "Who would benefit most from this?"
- "What's frustrating about how you do this now?"

**Incubation-informed prompts (when HAS_INCUBATION == True):**

First, use the **prepared questions** from the incubation context:

```python
# Extract the "Informed Questions for Capture" section
# These are pre-written based on prior art analysis
for question in incubation_context["Informed Questions for Capture"]:
    ask(question)
```

Then probe deeper using other incubation insights:

- Reference prior art: *"In {source from Prior Art DNA} you used {pattern}—is this building on that or going a different direction?"*
- Surface personal resonance: *"Based on your pattern of {resonance}, how central is that here?"*
- Probe creative seeds: *"One thread from incubation was '{seed}'—does that resonate or is it a tangent?"*
- Test tensions: *"There seemed to be a tension between {tension}—how do you think about that balance?"*

**Critical:** You MUST actually read `braindump/incubation-context.md` and reference SPECIFIC content from it. Don't make up generic probes—use the actual patterns, seeds, and tensions discovered.

**Key:** These are informed probes, not leading questions. You're excavating the user's idea more deeply, not steering them toward incubation outputs.

> **⚡ PARALLEL EXECUTION:** Steps 4 and 5 (writing CONTEXT.md and updating Notion) are independent. Execute both simultaneously.

### 4. Capture to CONTEXT.md

Write to CONTEXT.md (project root):
```markdown
# {Project Name}

*Captured: {timestamp}*

## Raw Idea

{User's words, preserved}

## The Spark

{What triggered this idea}

## Core Insight

{The non-obvious thing that makes this work}

---

*Questions that came up:*
- {Any questions noted during capture}
```

### 5. Update Notion

Update THE IDEA section:
- One-liner (synthesized)
- The spark
- Core insight

Update PROJECT SNAPSHOT:
- Phase: 1 - CAPTURE
- Status: → = In Progress

### 6. Confirm Capture

```
I've captured your idea! Here's what I got:

[Brief summary - 2-3 sentences]

One-liner: [synthesized one-liner]

This is saved in CONTEXT.md and synced to Notion.

Run /advance to check if we're ready for Phase 2.
```

## What NOT to Do

- Don't ask technical questions yet
- Don't suggest solutions
- Don't structure into PRD format
- Don't critique the idea
- Don't rush to the next phase

## Gate Criteria for Phase 1

To advance to Phase 2:
- [ ] THE IDEA section has one-liner
- [ ] THE IDEA section has spark
- [ ] THE IDEA section has core insight
- [ ] CONTEXT.md captures raw thoughts

## Example

```
User: /capture

Claude: Tell me about your project idea...

User: So I've been thinking about this thing where I can
      track my therapy clients' homework assignments and
      they could check them off and I could see what they
      did and didn't do but it needs to be simple because
      some of them aren't great with tech

Claude: I hear you want to build a homework tracking tool
        for therapy clients - simple enough for non-tech
        users. Let me capture this.

        [Writes to CONTEXT.md]
        [Updates Notion]

        I've captured your idea! Here's what I got:

        A therapy homework tracker that lets clients check off
        assignments while giving you visibility into completion.
        Simplicity is key for less tech-savvy users.

        One-liner: "Simple therapy homework tracking with
        client and therapist visibility"

        Run /advance to proceed to Phase 2 (EXPAND).
```
