# Phase 0.5: Weaving the Dream

## Setup

Use `mcp__clear-thought__thoughtbox` for synthesis, and `mcp__clear-thought__mental_models` to retrieve `trade-off-matrix`.

## Process

### Step 1: Review All Phases

Read through:
- `spec/dream/01-deep-listening.md`
- `spec/dream/02-digging-deeper.md`
- `spec/dream/03-wild-imagination.md`
- `spec/dream/04-parallel-worlds.md`

### Step 2: Apply Trade-off Matrix

Map the tensions between branches and approaches:

| Trade-off | Option A | Option B | What's gained | What's lost |
|-----------|----------|----------|---------------|-------------|
| Scope | Minimal | Maximal | [A gains] / [B gains] | [A loses] / [B loses] |
| Risk | Safe | Bold | ... | ... |
| Audience | Niche | Broad | ... | ... |
| Timeline | Fast | Thorough | ... | ... |

### Step 3: Find the Golden Thread

Thoughtbox synthesis:

"Looking across all phases, what themes appear again and again? What keeps showing up? This is the golden thread - the core truth of this project that transcends any single approach."

Questions to ask:
- What word or phrase captures the essence?
- What emotion is at the center?
- What transformation does this enable?
- What would be lost if this project didn't exist?

### Step 4: Extract Dream Seeds

**REQUIRED: Identify 3-5 Dream Seeds**

Dream Seeds are:
- Concrete, actionable idea fragments
- Not full features, but generative sparks
- Phrases that could guide design decisions
- Things that make you say "yes, THAT"

Examples:
- "The loading state should feel like breathing"
- "Users should feel like they're discovering a secret"
- "Errors are opportunities for delight"
- "The interface should feel like a conversation, not a form"

### Step 5: Write Expanded Vision

Synthesize everything into a cohesive vision statement:
- What is this project at its best?
- What does it feel like to use?
- What change does it create in the world?
- Why does it matter?

## Output Template

Write to `DREAM-SYNTHESIS.md` (root level):

```markdown
# Dream Synthesis: {Project Name}

*Generated from Lucid Dream process on {date}*

## The Golden Thread

> [One sentence that captures the essence]

---

## Expanded Vision

[2-3 paragraphs describing the project at its fullest potential. Not features, but feeling. Not specs, but soul.]

---

## Dream Seeds

These generative sparks should guide all future decisions:

1. **[Seed name]:** "[The phrase]"
   - Implication: [What this means for design/development]

2. **[Seed name]:** "[The phrase]"
   - Implication: [What this means]

3. **[Seed name]:** "[The phrase]"
   - Implication: [What this means]

4. **[Seed name]:** "[The phrase]"
   - Implication: [What this means]

5. **[Seed name]:** "[The phrase]"
   - Implication: [What this means]

---

## Key Tensions to Navigate

| Tension | Pull A | Pull B | Current Lean |
|---------|--------|--------|--------------|
| ... | ... | ... | ... |

---

## From the Parallel Worlds

**What to keep from Minimal:** ...
**What to aspire to from Maximal:** ...
**What's surprising from Lateral:** ...
**What's true from Shadow:** ...

---

## The Underneath Story

[From Digging Deeper - what this project is REALLY about]

---

## Questions to Carry Forward

1. [Open question for Phase 1]
2. [Open question for Phase 1]
3. [Open question for Phase 1]

---

## Ready for Phase 1: CAPTURE

The dream is complete. These seeds and this vision will guide the capture phase, where raw ideas become structured possibilities.

*Next: Run `/capture` to begin shaping your idea.*
```
