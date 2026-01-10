# AI Creative Contribution System

How the AI contributes creative and technical thinking throughout the project workflow—without imposing or locking anything in.

## Philosophy

The AI is a **creative collaborator**, not just a facilitator. It brings:
- Novel ideas and perspectives
- Research on prior art and patterns
- Technical and design considerations
- Alignment checks with your goals
- **Deep understanding of you as a person** (patterns, motivations, style)

But everything it offers is **conceptual**. Nothing becomes a requirement unless you confirm it through the Design Doc.

---

## The Cognitive Incubation Model

Phase 0 isn't about extracting structured data from materials—it's about the AI developing **genuine understanding** before formal capture begins.

### Three Sources of Understanding

```
┌─────────────────────────────────────────────────────────────────┐
│                    Cognitive Incubation                         │
└─────────────────────────────────────────────────────────────────┘
                              │
        ┌─────────────────────┼─────────────────────┐
        ▼                     ▼                     ▼
   Braindump             Previous              Personal
   Materials             Projects              Analysis
   │                     │                     │
   │ Voice memos         │ Notion Design Docs  │ Patterns
   │ Transcripts         │ Past decisions      │ Motivations
   │ AI conversations    │ Lessons learned     │ Values
   │ Screenshots         │ Transferable ideas  │ Style
   └─────────────────────┼─────────────────────┘
                         ▼
              ┌─────────────────────┐
              │  Soft Contextual    │
              │  Layer (informs     │
              │  but doesn't lock)  │
              └─────────────────────┘
```

### What This Enables

- **Personalized questions** during capture—based on who you are, not generic prompts
- **Cross-project awareness**—patterns that worked before, lessons to avoid repeating
- **Deeper excavation**—getting to the essence, not just surface features
- **Tension surfacing**—noticing contradictions before they become problems

---

## Types of Dream Cycles

### 1. Cognitive Incubation (`/incubate`)

**When:** Phase 0, when you have materials to process.

**What it does:**
- Absorbs all braindump materials
- Queries personal analysis for relevant patterns
- Searches for and deep-reads related projects (with user confirmation)
- Extended thoughtbox synthesis (15-20+ steps)
- Persists insights to memory, local file, and Notion

**Output:** AI enters enriched cognitive state. Insights stored in:
- Serena memory (project-local)
- `braindump/dream-journal.md` (human reference)
- Notion INCUBATION INSIGHTS section (canonical record)

**Key:** This is the AI building intuition, not producing documents.

---

### 2. Full Dream (`/dream`)

**When:** On request, when you want AI's creative input at any point.

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
| Phase 0 | Incubation | Build cognitive context from materials + related projects + personal analysis |
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
- `/incubate` - Full cognitive incubation (Phase 0)
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
- "Skip incubation" - go directly to capture
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

## Persistence & Cross-Session Continuity

### Storage Locations

| Location | Purpose | When Used |
|----------|---------|-----------|
| **Serena memory** | Project-local, detailed | Incubation synthesis, per-project |
| **claude-mem** | Global, queryable | Cross-project patterns |
| **Notion** | Canonical record | INCUBATION INSIGHTS section |
| **Local file** | Human reference | `braindump/dream-journal.md` |

### Session Resumption

When starting a new session on an existing project:
1. Load Serena memory for the project
2. Load INCUBATION INSIGHTS from Notion
3. AI recovers cognitive context automatically

---

## Related Projects Integration

### Discovery

During `/incubate`, the AI:
1. Identifies themes from braindump materials
2. Searches Notion Design Docs for matching projects
3. Presents candidates to user for confirmation
4. Only deep-reads confirmed related projects

### What Gets Pulled

From related projects:
- THE IDEA section (essence of the project)
- Key decisions from DECISIONS LOG
- Lessons learned (what worked, what didn't)
- Transferable patterns and features

### Notion Integration

Design Doc template includes:
- **Related Projects** - Relation field to link projects
- **INCUBATION INSIGHTS** - Section for storing cognitive context

---

## Anti-Lock-In Guarantees

1. **Incubation is CONCEPTUAL** - explicitly marked, not specification
2. **Dream output is OFFERED** - framed as possibilities, not requirements
3. **Design Doc is truth** - only what appears there (and user confirms) is real
4. **User picks** - AI proposes, user disposes
5. **Journal is reference** - past ideas don't become future constraints
6. **Related projects inform, not constrain** - patterns are suggestions, not mandates

---

## The Creative Collaboration Contract

**AI commits to:**
- Bringing genuine creative and technical perspective
- Understanding the person, not just the project
- Connecting to past work and personal patterns
- Researching when useful
- Checking alignment with your goals
- Framing everything as offerings
- Not imposing or locking in

**User keeps control of:**
- What becomes part of the Design Doc
- What ideas to explore
- What to ignore
- Which related projects are actually relevant
- When to dream and when to just move forward

---

## Tools Used

**Thoughtbox:** Multi-step reasoning with branching, revision, and synthesis.

**Mental Models:**
- Pre-mortem (risks)
- First principles (essence)
- Abstraction laddering (level check)
- Adversarial thinking (critique)

**Memory Systems:**
- Serena memory (project-local)
- claude-mem (global search)
- Personal analysis data

**Notion MCP:** Design Doc access, related project discovery.

**Research:** Web search, prior art discovery (when useful).
