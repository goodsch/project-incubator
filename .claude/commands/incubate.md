---
name: incubate
description: Phase 0 - Cognitive incubation where AI develops deep understanding through braindump materials, related projects, and personal context
---

# /incubate - Phase 0: Cognitive Incubation

A creative preparation layer where the AI develops genuine understanding of what you're trying to create—informed by your materials, previous projects, and personal patterns.

## Philosophy

Phase 0 is NOT about extracting structured data. It's about the AI building a **cognitive context**—a soft understanding that informs everything that follows without becoming rigid specification.

The output is the AI's enriched understanding, stored for persistence but framed as **conceptual, not prescriptive**.

## When to Use

- You have materials in `braindump/source-materials/`
- You want the AI to deeply understand the context before capture
- There are related projects worth connecting to
- You want personalized, informed questions during capture

## When to Skip

- Fresh idea with no accumulated materials
- Prefer raw capture first, explore context later
- Say "skip incubation" or "start with capture"

---

## The Process

### Step 1: Material Absorption

Read all files in `braindump/source-materials/`:

```bash
ls braindump/source-materials/
```

For each file:
- Identify themes, keywords, stated goals
- Note questions, uncertainties, tensions in the material
- Extract the emotional drivers and underlying motivations

### Step 2: Personal Context Query

Based on identified themes, query for relevant personal context:

```
mcp__plugin_claude-mem_mcp-search__search with themes as query
```

Look for:
- Patterns in how user approaches similar problems
- Motivations and values related to these themes
- Past experiences with similar project types

Also check personal-analysis data if available:
- `/home/chris/claude-workspaces/personal-analysis/obsidian_export/` for synthesized insights

### Step 3: Local Codebase Discovery (Prior Implementations)

Scan local project directories for codebases that might inform this project:

```bash
# Scan known project locations
for dir in ~/dev/projects/claude/* ~/dev/projects/codex/*; do
  if [ -f "$dir/README.md" ] || [ -f "$dir/CLAUDE.md" ]; then
    echo "=== $(basename $dir) ==="
    head -20 "$dir/README.md" 2>/dev/null || head -20 "$dir/CLAUDE.md"
  fi
done
```

Present discovered codebases:

```
🔧 Found prior implementations:
   • neurogarden - ADHD-optimized thought capture (n8n, MCP, zero-friction)
   • fractal - Intelligent Exploration System (thinking space continuity)
   • synapse - Neural processing second brain (15-layer pipeline, decay)
   • brain_explore - Therapeutic worldview exploration (guided conversations)

Which feel relevant to this project? [all/none/list specific ones]
```

**Wait for user confirmation before deep-reading.**

### Step 4a: Deep Read Local Codebases

For each confirmed local project:

```
Read: README.md, CLAUDE.md, docs/ folder
```

Extract:
- **Core purpose** - What problem does it solve?
- **Architectural patterns** - Data flow, agent models, storage
- **Key innovations** - What makes it unique?
- **Transferable patterns** - What could apply here?
- **Cognitive metaphors** - What mental models does it use?

This provides **real implementation context**, not just design docs.

### Step 4b: Notion Project Discovery (Design Docs)

Search Notion for potentially related design documents:

```
mcp__notion__API-post-search with theme keywords
mcp__notion__API-query-data-source for Design Docs database
```

Present candidates:

```
📋 Found related design docs:
   • Project A (themes: X, Y)
   • Project B (themes: Y, Z)

Which feel relevant? [all/none/list specific ones]
```

**Wait for user confirmation before proceeding.**

### Step 4c: Deep Read Notion Projects

For each confirmed Notion project:

```
mcp__notion__API-get-block-children to read:
- THE IDEA section (essence)
- Key decisions from PRD
- DECISIONS LOG (what worked, what didn't)
- Any lessons learned
```

Note:
- Transferable patterns
- Features that might apply
- What's different about the new project

### Step 5: Creative Synthesis (The Dream)

Extended thoughtbox session:

```
mcp__thoughtbox__thoughtbox with:
- totalThoughts: 15-20
- Apply mental models: first-principles, abstraction-laddering
- Branch to explore multiple interpretations
- Synthesize at the end
```

Explore:
- What is the user **really** reaching for?
- Unexpected connections across sources
- "What if..." possibilities
- The essence underneath the stated features
- Tensions that need resolution

### Step 6: Persist the Cognitive Layer

**Write to multiple locations for persistence:**

1. **Serena Memory** (project-local):
```
mcp__serena__write_memory with memory_file_name: "incubation-{project-name}.md"
```

2. **Local File** (human reference):
```
Write to: braindump/dream-journal.md
```

3. **Notion** (canonical record):
Update Design Doc with INCUBATION INSIGHTS section (see template)

---

## Output Format

Present insights conversationally:

```
✨ Incubation Complete

**Essence:** [What this project is really about at its core]

**Personal Resonance:** [Why this matters to you specifically—based on patterns]

**Prior Art DNA:** (from local codebases)
- From {neurogarden}: [e.g., "Raw storage first, classify later"]
- From {fractal}: [e.g., "Context resurrection for thinking continuity"]
- From {synapse}: [e.g., "Hebbian strengthening for relationships"]
- From {brain_explore}: [e.g., "Adaptive question taxonomy"]

**Design Doc Lessons:** (from Notion projects)
- From {Project A}: [relevant pattern or lesson]
- From {Project B}: [relevant pattern or lesson]

**Creative Seeds:**
- [Novel idea 1]
- [Novel idea 2]
- ["What if..." possibility]

**Tensions to Explore:**
- [Unresolved question 1]
- [Competing priority to resolve]

**Architectural Suggestions:** (based on prior implementations)
- [Pattern that could apply]
- [Tech stack consideration]

This context is now loaded. It will inform my questions during capture
without constraining what you actually build.

Ready for /capture when you are.
```

---

## How This Influences Later Phases

| Phase | How Incubation Context Helps |
|-------|------------------------------|
| **1 - CAPTURE** | Smarter, personalized questions; probe deeper based on patterns |
| **2 - EXPAND** | Suggest features informed by prior codebases AND design docs |
| **3 - SPECIFY** | Notice when PRD drifts from core essence |
| **4 - ARCHITECT** | Reference **actual implementations** from neurogarden/fractal/synapse/brain_explore |
| **5 - CONFIGURE** | Apply tech stack lessons from projects you've actually built |

The cognitive layer is **background knowledge**—not explicitly referenced in every interaction, but coloring everything.

**Local Codebases as Living Documentation:**
Unlike design docs, prior codebases show what you **actually built**, including:
- Patterns you gravitate toward (agent architectures, decay mechanisms, etc.)
- Tech choices that worked in practice
- Code organization you prefer
- Problems you've already solved

---

## Session Resumption

If starting a new session on an incubated project:

1. Check for Serena memory: `mcp__serena__read_memory("incubation-{project-name}.md")`
2. Check for local file: `braindump/dream-journal.md`
3. Load Notion INCUBATION INSIGHTS section

This restores the cognitive context across sessions.

---

## ADHD-Friendly Notes

- The interactive confirmations create natural pause points
- Break material reading into chunks if overwhelming
- Dream phase should feel playful, not procedural
- Can pause and resume—context persists
- "Skip incubation" is always valid

---

## Commands

- `/incubate` - Full Phase 0 process (this command)
- `/dream` - On-demand dream cycle (can use anytime)
- "skip incubation" - Go directly to /capture
