# AI Creative Contribution System

How the AI contributes creative and technical thinking throughout the project workflow—without imposing or locking anything in.

## Philosophy

The AI is a **creative collaborator**, not just a facilitator. It brings:
- Novel ideas and perspectives
- Research on prior art and patterns
- Technical and design considerations
- Alignment checks with your goals

But everything it offers is **conceptual**. Nothing becomes a requirement unless you confirm it through the Design Doc.

## Types of Dream Cycles

### 1. Marination (Phase 0)

**When:** Before formal capture, if you have accumulated materials.

**What it does:**
- Absorbs raw materials (notes, transcripts, etc.)
- Builds intuition and feel
- Develops questions and vocabulary
- Notices patterns and tensions

**Output:** `braindump/marination-log.md` - explicitly marked CONCEPTUAL

**Key:** Context for exploration, not specification.

---

### 2. Full Dream (`/dream`)

**When:** On request, when you want AI's creative input.

**What it does:**
- 15-20+ thoughtbox iterations
- Divergent exploration (possibilities, prior art, risks, alignment)
- Mental model application (pre-mortem, first principles)
- Research if useful
- Comprehensive synthesis

**Output:** Offered as "Noticing / Wondering / Discovered / Ideas / Alignment"

**Key:** User picks what resonates. Nothing imposed.

---

### 3. Transition Dream (`/advance`)

**When:** At phase transitions, before moving forward.

**What it does:**
- 5-10 thoughtbox iterations
- Checks phase completeness
- Verifies alignment with goals
- Identifies gaps to watch
- Notes what to carry forward

**Output:** Brief transition check before advancing

**Key:** Quick sanity check, skippable with "just advance"

---

### 4. Quick Dream (automatic)

**When:** AI detects stuckness, complexity, or hesitation.

**What it does:**
- 3-5 thoughtbox iterations
- Quick step-back to think
- Offers fresh perspective

**Output:** Brief insight or question

**Key:** Offered, not forced. "Want me to think about this?"

---

## Trigger Points Throughout Workflow

| Point | Dream Type | Purpose |
|-------|------------|---------|
| Phase 0 (if used) | Marination | Build context from materials |
| After Phase 1 | Transition | Ensure capture is solid |
| After Phase 2 | Transition | Check scope before specifying |
| During Phase 3 | Quick (if stuck) | Help with PRD decisions |
| After Phase 4 | Transition + Full | Architecture is critical decision point |
| During Phase 5 | Quick (if complex) | Configuration choices |
| User requests | Full | Whenever you want AI input |
| Stuckness detected | Quick | Unstick the conversation |

---

## How to Trigger

**Explicit:**
- `/dream` - Full dream cycle
- "Think about this"
- "What do you think?"
- "Give me your ideas"
- "Dream on it"

**Automatic (offered, not forced):**
- Stuckness detected → "Want me to step back and think about this?"
- Complexity growing → "This is getting complex. Should I reflect on it?"
- Phase transition → Built into `/advance`

**Skip:**
- "Just advance" - skip transition dream
- "No, keep going" - decline offered dream

---

## Output Framing

All dream output is framed as **offerings**, not conclusions:

```
🌙 Dream Cycle Complete

**Noticing:** [Observations, patterns, tensions]

**Wondering:** [Questions, curiosities]

**Discovered:** [Prior art, tools, research]

**Ideas (take or leave):** [Features, approaches, possibilities]

**Alignment Check:** [On track? Drifting? Missing something?]

Which of these should we explore?
```

The user picks what resonates. Everything else is just context.

---

## Dream Journal

Significant insights can be logged to `braindump/dream-journal.md`:

```markdown
## Dream Cycle - {date}

**Phase:** {current phase}
**Trigger:** {why dream happened}

**Key Insights:**
- ...

**Ideas Offered:**
- ...

**User Picked:**
- ...
```

This creates a record of AI creative contributions without making them requirements. You can reference it later if ideas become relevant.

---

## Anti-Lock-In Guarantees

1. **Marination log is CONCEPTUAL** - explicitly marked, not validated
2. **Dream output is OFFERED** - framed as possibilities, not requirements
3. **Design Doc is truth** - only what appears there (and user confirms) is real
4. **User picks** - AI proposes, user disposes
5. **Journal is reference** - past ideas don't become future constraints

---

## The Creative Collaboration Contract

**AI commits to:**
- Bringing genuine creative and technical perspective
- Researching when useful
- Checking alignment with your goals
- Framing everything as offerings
- Not imposing or locking in

**User keeps control of:**
- What becomes part of the Design Doc
- What ideas to explore
- What to ignore
- When to dream and when to just move forward

---

## Tools Used

**Thoughtbox:** Multi-step reasoning with branching, revision, and synthesis.

**Mental Models:**
- Pre-mortem (risks)
- First principles (essence)
- Abstraction laddering (level check)
- Adversarial thinking (critique)

**Research:** Web search, prior art discovery (when useful).
