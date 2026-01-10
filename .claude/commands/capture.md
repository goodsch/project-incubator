---
name: capture
description: Phase 1 - Get the core idea out with zero friction. Guided capture session.
---

# /capture - Phase 1

Get the idea out of your head with zero friction.

## Prerequisites

- Phase 0 complete (or skipped)
- status.json shows Phase 1

## Before Starting: Load Incubation Context

**If Phase 0 was completed**, load the cognitive context before capture:

```
1. Check Serena memory: mcp__serena__read_memory("incubation-{project-name}.md")
2. Read local file: braindump/dream-journal.md (if exists)
3. Load Notion INCUBATION INSIGHTS section
```

This context informs your questions but **doesn't constrain** what gets captured. The goal is smarter, more personalized probing—not leading the user.

**If Phase 0 was skipped**, proceed directly to capture.

---

## Process

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

**Incubation-informed prompts (when Phase 0 completed):**

Use your loaded cognitive context to ask smarter questions:

- Reference related projects: *"In Signal Garden you explored voice-to-structure patterns. Is this building on that or going a different direction?"*
- Surface personal patterns: *"I notice you gravitate toward tools that reduce cognitive load—how central is that here?"*
- Probe creative seeds: *"One thread from incubation was X—does that resonate or is it a tangent?"*
- Test tensions: *"There seemed to be a tension between simplicity and power—how do you think about that balance?"*

**Key:** These are informed probes, not leading questions. You're excavating the user's idea more deeply, not steering them toward incubation outputs.

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
