# Phase 0: LUCID DREAM - Creative Expansion Process

Transform raw braindump materials into an expanded creative vision through structured imagination using Clear Thought tools.

## Overview

The Lucid Dream process is a 5-phase journey that goes beyond extracting what's in the braindump to discovering what COULD be. It uses Clear Thought's mental models and thoughtbox to guide creative expansion while maintaining structure.

**Named "Lucid" because:** It's structured dreaming with awareness - not random but not rigid.

## When to Use

- Triggered automatically by `/init` when `braindump/` folder has files
- Can be invoked manually with `/dream` command
- Should run BEFORE Phase 1: CAPTURE

## The Phases

### Phase 0.0: META-ANALYSIS (Optional)
**Duration:** 10 min | **Tools:** `mcp__clear-thought__thoughtbox` (forward thinking)

**When to Use:** When braindump materials are ALREADY structured (e.g., ChatGPT conversation outputs, existing specs, prior analysis). Skip this for raw, unstructured braindumps.

**Purpose:** Extract and formalize the existing conceptual architecture before expanding it.

**Process:**
1. Identify the core thesis/vision statement
2. Inventory all frameworks, models, and concepts present
3. Map relationships between concepts
4. Note gaps, contradictions, and unresolved tensions
5. Generate questions for the Dream phase to address

**Key Question:** "What architecture already exists here, and what's missing from it?"

**Output:** `spec/dream/00-meta-analysis.md`

---

### Phase 0.1: DEEP LISTENING
**Duration:** 5-10 min | **Tools:** `mcp__clear-thought__thoughtbox` (forward thinking)

**Purpose:** Truly understand what's in the braindump before expanding.

**Process:**
1. Read all materials in `braindump/` folder
2. Use thoughtbox (5-8 thoughts) to track:
   - Explicit content (what's stated directly)
   - Implicit desires (what's hinted at)
   - Emotional undertones (excitement, frustration, fear)
   - Questions raised (what's unclear or unaddressed)
3. Note what's MISSING - what didn't the user mention that might matter?

**Key Question:** "What is this person actually trying to create?"

**Output:** `spec/dream/01-deep-listening.md`

---

### Phase 0.2: DIGGING DEEPER
**Duration:** 10 min | **Tools:** `mcp__clear-thought__mental_models`

**Purpose:** Uncover root motivations and hidden assumptions.

**Process:**
1. Identify 3 key goals/desires from Deep Listening
2. Apply **five-whys** to each goal:
   - "Why do you want X?"
   - "Why does that matter?"
   - (repeat 5 times to find root motivation)
3. Apply **assumption-surfacing**:
   - List ALL assumptions (technical, user, market, personal)
   - Categorize as: Hard (truly fixed), Soft (changeable), Phantom (may not be real)
4. Find the "underneath story" - the deeper desire

**Key Question:** "What do you REALLY want?"

**Output:** `spec/dream/02-digging-deeper.md`

---

### Phase 0.3: WILD IMAGINATION
**Duration:** 15 min | **Tools:** `mcp__clear-thought__mental_models`

**Purpose:** Generate expansive possibilities without limits.

**Process:**
1. Apply **constraint-relaxation**:
   - "If you had unlimited time, money, and magic..."
   - "If failure was impossible..."
   - "If you could break any rule..."
2. Apply **inversion**:
   - "What would guarantee this project fails?"
   - List 5-7 failure modes
   - Flip each into an opportunity
3. Perspective shifts:
   - "How would a child approach this?"
   - "What would a harsh critic say is missing?"
   - "What would make this make you cry (with joy)?"
4. Random provocations:
   - "What if it was a game?"
   - "What if it was a ritual?"
   - "What if it was a secret?"

**NO JUDGMENT** - capture everything, even absurd ideas.

**Key Question:** "What becomes possible when nothing is impossible?"

**Output:** `spec/dream/03-wild-imagination.md`

---

### Phase 0.4: PARALLEL WORLDS
**Duration:** 15 min | **Tools:** `mcp__clear-thought__thoughtbox` (branching)

**Purpose:** Explore alternative visions in parallel.

**Process:**
Create 4 thoughtbox branches, each with 5 thoughts:

1. **Branch: "minimal"**
   - Smallest version that keeps the soul
   - What's the essence? What can't be cut?

2. **Branch: "maximal"**
   - Biggest, most ambitious version
   - Dream without resource limits

3. **Branch: "lateral"**
   - Unexpected direction, genre shift
   - "What if this was actually a [completely different thing]?"

4. **Branch: "shadow"**
   - What are you avoiding?
   - What scares you about this project?
   - What would happen if you went toward the fear?

**Key Question:** "What other versions of this could exist?"

**Output:** `spec/dream/04-parallel-worlds.md`

---

### Phase 0.5: WEAVING THE DREAM
**Duration:** 10 min | **Tools:** `mcp__clear-thought__thoughtbox` (synthesis) + `mental_models` (trade-off-matrix)

**Purpose:** Integrate explorations into an expanded vision.

**Process:**
1. Review all phase outputs
2. Use **trade-off-matrix** to map tensions between branches:
   - What's gained/lost in minimal vs maximal?
   - What's the cost of playing it safe vs going bold?
3. Find the "golden thread" - what resonates across ALL explorations?
4. Identify **3-5 Dream Seeds** (REQUIRED):
   - Concrete, generative idea fragments
   - Not full features, but sparks
   - Examples: "Onboarding should feel like unwrapping a gift", "Users should feel like wizards"
5. Write expanded vision statement

**Key Question:** "What is the dream that wants to be built?"

**Output:** `DREAM-SYNTHESIS.md` (root level - feeds into Phase 1 CAPTURE)

---

## Abbreviated Mode

For simple ideas (braindump <3 files OR <1000 words), offer abbreviated dream:

1. **Deep Listening** (2-3 thoughts only)
2. **Wild Imagination** (constraint-relaxation only, skip inversion)
3. **Weaving** (direct synthesis, skip branching)

Skip Digging Deeper and Parallel Worlds for simple ideas.

---

## Required Output: Dream Seeds

Every dream process MUST produce **3-5 Dream Seeds**:
- Concrete, actionable idea fragments
- Not full features, but generative sparks
- Carry forward into Phase 1 CAPTURE

**Example Dream Seeds:**
- "The loading state should feel like breathing"
- "What if errors were opportunities for delight?"
- "Users should feel like they're discovering a secret"
- "The export should feel like unwrapping a gift"

---

## Clear Thought Tools Reference

| Phase | Tool | Model(s) |
|-------|------|----------|
| 0.1 Deep Listening | thoughtbox | forward thinking (5-8 thoughts) |
| 0.2 Digging Deeper | mental_models | five-whys, assumption-surfacing |
| 0.3 Wild Imagination | mental_models | constraint-relaxation, inversion |
| 0.4 Parallel Worlds | thoughtbox | branching (4 branches × 5 thoughts) |
| 0.5 Weaving | thoughtbox + mental_models | synthesis, trade-off-matrix |

---

## Output Files

```
spec/dream/
├── 00-meta-analysis.md      (optional - for structured braindumps)
├── 01-deep-listening.md
├── 02-digging-deeper.md
├── 03-wild-imagination.md
└── 04-parallel-worlds.md

DREAM-SYNTHESIS.md  (root level)
```

---

## Transition to Phase 1

When Weaving is complete:
1. Ensure DREAM-SYNTHESIS.md exists with Dream Seeds
2. Update status.json: `currentPhase: 1, phaseName: "CAPTURE"`
3. Prompt user: "Dream complete! Your expanded vision and Dream Seeds are ready. Run `/capture` to begin shaping your idea."
