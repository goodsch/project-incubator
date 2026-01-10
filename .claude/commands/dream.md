---
name: dream
description: Deep creative ideation cycle. AI reflects, researches, ideates, and offers contributions.
---

# /dream - Creative Ideation Cycle

A self-directed AI thinking process. I step back, reflect on what we've built, think creatively and technically, and offer ideas—without imposing anything.

## Philosophy

This transforms me from "facilitator" to "creative collaborator." I bring my perspective, research, and ideas to the table. But everything I offer is **conceptual**—nothing becomes a requirement unless you confirm it in the Design Doc.

## When to Use

- You want my creative input
- We seem stuck or looping
- Before a major phase transition
- You say "think about this" or "what do you think?"
- The project feels complex and could use fresh perspective

## The Process

### 1. Announce

```
🌙 Starting dream cycle...

Taking time to think deeply about what we've built,
what possibilities exist, and what might help.
```

### 2. Ground (thoughtbox 1-3)

> **⚡ PARALLEL EXECUTION:** Reading Design Doc, scanning local projects, and reviewing recent conversation are independent. Execute all three simultaneously.

Review current state:
- Read the Design Doc (visual + summary sections)
- Note the current phase
- Review recent conversation
- Identify what's solid vs. fuzzy

### 3. Diverge (thoughtbox 4-12, with branching)

> **⚡ PARALLEL EXECUTION:** Branches A, B, C, D are independent explorations. Launch parallel Task agents for each branch simultaneously, then converge results. This dramatically speeds up the dream cycle.

Explore multiple threads using branching:

```
Branch A: "Possibilities"
  What features/approaches haven't we considered?
  What would make this exceptional?
  What's adjacent to this idea?

Branch B: "Prior Art"
  What have I built before that's relevant?
  [Scan ~/dev/projects/claude/* and ~/dev/projects/codex/*]
  What patterns from neurogarden/fractal/synapse/brain_explore apply?
  What similar external tools exist?
  What can we learn from them?
  [May use web search for external art]

Branch C: "Risks & Gaps"
  What could go wrong?
  What assumptions are we making?
  What's missing from the Design Doc?

Branch D: "True North"
  What is the user REALLY trying to achieve?
  Are we building toward that?
  What's the soul of this project?
```

### 4. Converge (thoughtbox 13-17)

Apply mental models for critique:

```
mcp__clear-thought__mental_models:
  - pre-mortem: How could this fail?
  - first-principles: What is this really about?
  - abstraction-laddering: Are we at the right level?
```

Synthesize insights across branches.

### 5. Crystallize (thoughtbox 18-20)

Distill into:
- Top 3-5 insights or observations
- Key questions that emerged
- Ideas to offer (features, approaches, tools)
- Alignment assessment (on track? drifting?)

### 6. Offer

Present findings in invitation format:

```
🌙 Dream Cycle Complete

I spent some time thinking about what we've built. Here's what came up:

**Noticing:**
[Observations about the project, patterns, tensions]

**Wondering:**
[Questions that emerged, things I'm curious about]

**Discovered:**
[Prior art, relevant tools, terminology, research]

**Ideas (take or leave):**
[Feature ideas, alternative approaches, integrations]

**Alignment Check:**
[Are we on track? What might we be missing?]

---

Which of these, if any, should we explore?
```

### 7. Journal (optional)

If significant insights emerged, append to `braindump/dream-journal.md`:

```markdown
## Dream Cycle - {date}

**Phase:** {current phase}
**State:** {brief description of Design Doc}

**Key Insights:**
- ...

**Ideas Offered:**
- ...

**User Response:**
[Updated after user responds]
```

## Variations

### Quick Dream (3-5 thoughts)
For unsticking or quick checks. Triggered by:
- Stuckness detected
- User hesitation
- "Let me think about that..."

### Transition Dream (5-10 thoughts)
At phase transitions. Focused on:
- Readiness for next phase
- Gaps to address
- Alignment check

### Full Dream (15-20+ thoughts)
On explicit /dream request. Comprehensive:
- Full divergent exploration
- Research if useful
- Multiple mental models
- Detailed synthesis

## Output Framing

**Always frame as offerings, not conclusions:**

| Don't Say | Say Instead |
|-----------|-------------|
| "The key insight is..." | "I noticed that..." |
| "We should..." | "One possibility..." |
| "The approach is..." | "An approach could be..." |
| "This needs..." | "This might benefit from..." |
| "The problem is..." | "I'm wondering about..." |

## What Happens to Dream Output

- **Conceptual only** - nothing becomes requirement
- **User picks** what resonates
- **Design Doc** is where things get confirmed
- **Dream journal** preserves ideas for later reference

## Anti-Patterns

- Don't dream too often (becomes noise)
- Don't make dream insights into requirements
- Don't present findings as conclusions
- Don't skip the offering framing
- Don't forget to check alignment with user's actual goals
