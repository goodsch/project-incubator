---
name: incubate
description: Phase 0 - Cognitive incubation with visual validation. Creates Notion canvas for user to confirm concepts before crystallization into implementation-ready specs.
---

# /incubate - Phase 0: Cognitive Incubation & Visual Validation

A creative preparation layer where the AI develops genuine understanding, presents it visually in Notion for your validation, then crystallizes confirmed concepts into implementation-ready specifications.

## Philosophy

Phase 0 transforms raw materials and prior art into **validated concepts** through:
1. **Incubation** - AI absorbs and synthesizes understanding
2. **Visualization** - Present concepts visually in Notion for review
3. **Validation** - You confirm which ideas resonate
4. **Crystallization** - Develop confirmed concepts into complete specs

The output is a **mutually-agreed concept** ready for detailed capture.

---

## Sub-Phases Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                    PHASE 0: INCUBATE                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  0a. ABSORB         Read materials, discover prior art         │
│         ↓                                                       │
│  0b. VISUALIZE      Create Notion Concept Canvas               │
│         ↓                                                       │
│  0c. VALIDATE       User reviews, confirms direction           │
│         ↓                                                       │
│  0d. CRYSTALLIZE    Develop into complete concept via ideator  │
│         ↓                                                       │
│  0e. MOCKUP         Generate visual artifacts (optional)       │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Sub-Phase 0a: ABSORB

### Step 1: Material Absorption

Read all files in `braindump/source-materials/`:

```bash
ls braindump/source-materials/
```

For each file:
- Identify themes, keywords, stated goals
- Note questions, uncertainties, tensions
- Extract emotional drivers and underlying motivations

### Step 2: Personal Context Query

```
mcp__plugin_claude-mem_mcp-search__search with themes as query
```

Look for:
- Patterns in how user approaches similar problems
- Motivations and values related to these themes
- Past experiences with similar project types

### Step 3: Local Codebase Discovery

Scan local project directories for prior implementations:

```bash
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

Which feel relevant? [all/none/list specific ones]
```

**Wait for user confirmation before deep-reading.**

### Step 4: Deep Read & Extract Patterns

For each confirmed project:
- Read README.md, CLAUDE.md, docs/
- Extract core purpose, architectural patterns, key innovations
- Identify transferable insights

Also query Notion for related design docs:

```
mcp__notion__API-post-search with theme keywords
```

### Step 5: Creative Synthesis

Extended thoughtbox session:

```typescript
mcp__thoughtbox__thoughtbox({
  thought: "Synthesizing [project] understanding...",
  totalThoughts: 15,
  sessionTitle: "Incubation: [Project]",
  sessionTags: ["incubation", "synthesis"]
})
```

Develop:
- 3-5 concept candidates (not just one)
- The essence each represents
- How prior art informs each
- Tensions/tradeoffs between them

---

## Sub-Phase 0b: VISUALIZE

### Create Notion Concept Canvas

Create a new page under the Design Doc for visual concept presentation:

```typescript
mcp__notion__API-post-page({
  parent: { page_id: "{design-doc-id}" },
  properties: {
    title: { title: [{ text: { content: "🎨 Concept Canvas" } }] }
  },
  children: [
    // Build the visual canvas (see template below)
  ]
})
```

### Concept Canvas Structure

```
🎨 CONCEPT CANVAS - {Project Name}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📍 THE ESSENCE
┌─────────────────────────────────────┐
│ [Callout with core understanding]   │
└─────────────────────────────────────┘

🧬 PRIOR ART DNA
[Toggle blocks showing patterns from each codebase]
  ▸ neurogarden → [pattern and how it applies]
  ▸ fractal → [pattern and how it applies]
  ▸ synapse → [pattern and how it applies]

💡 CONCEPT CANDIDATES
[Each concept as a toggle with checkbox for selection]

  ☐ Concept A: {Name}
    ├─ One-liner: {elevator pitch}
    ├─ Core insight: {what makes this work}
    ├─ Tech approach: {high-level stack}
    └─ Tradeoff: {what you gain/lose}

  ☐ Concept B: {Name}
    ├─ One-liner: {elevator pitch}
    ├─ Core insight: {what makes this work}
    ├─ Tech approach: {high-level stack}
    └─ Tradeoff: {what you gain/lose}

  ☐ Concept C: {Name}
    ├─ ...

🔀 FEATURE MATRIX
[Table comparing concepts on key dimensions]
| Feature | Concept A | Concept B | Concept C |
|---------|-----------|-----------|-----------|
| {key feature 1} | ✅ | ❌ | ✅ |
| {key feature 2} | ✅ | ✅ | ❌ |
| Complexity | Low | Medium | High |
| Novel factor | ⭐⭐ | ⭐⭐⭐ | ⭐ |

⚡ CREATIVE SEEDS
[Callouts with novel ideas that could enhance any concept]
  • "What if {possibility 1}..."
  • "What if {possibility 2}..."

⚖️ TENSIONS TO RESOLVE
[To-do items for decisions needed]
  ☐ {Tension 1}: {options}
  ☐ {Tension 2}: {options}

📊 SYSTEM SKETCH
[Embedded Mermaid diagram - use MindPilot MCP]
```

### Generate Visual Diagrams

Use MindPilot MCP for system sketches:

```typescript
mcp__mindpilot__render_mermaid({
  diagram: `
graph TD
    A[User Input] --> B{Core Engine}
    B --> C[Feature A]
    B --> D[Feature B]
    C --> E[Output]
    D --> E

    classDef coral fill:#ff6b6b,stroke:#c92a2a,color:#fff
    classDef ocean fill:#4c6ef5,stroke:#364fc7,color:#fff
    class A coral
    class B,C,D ocean
  `,
  title: "{Project} System Overview"
})
```

Embed the resulting SVG in Notion.

---

## Sub-Phase 0c: VALIDATE

### Present Canvas to User

```
📋 CONCEPT CANVAS READY

I've created a visual canvas in Notion with:
• 3 concept candidates based on your materials and prior art
• Feature comparison matrix
• System sketch diagram
• Creative seeds to consider

📍 View it here: {Notion URL}

Please:
1. Review the concept candidates
2. Check ☑️ the ones that resonate
3. Resolve any tensions that need decisions
4. Note any creative seeds you want to include

When ready, tell me which concept(s) to crystallize.
```

### Validation Options

Accept user input:

- **"Concept A"** → Proceed to crystallize Concept A
- **"Combine A and C"** → Merge specific concepts
- **"None of these"** → Return to 0a with new direction
- **"Add {feature} to B"** → Modify before crystallizing
- **"More concepts"** → Generate additional candidates

### Update Canvas with Selections

Mark selected concepts in Notion:

```typescript
mcp__notion__API-update-a-block({
  block_id: "{concept-checkbox-id}",
  type: { to_do: { checked: true } }
})
```

---

## Sub-Phase 0d: CRYSTALLIZE

### Invoke Ideator for Complete Concept Development

Once user confirms direction, use ideator skill to develop a complete, implementation-ready concept:

```
Skill(skill: "ideator", args: "crystallize concept: {selected concept summary}")
```

The ideator will:
1. Deep-dive research on the selected concept
2. Validate technical feasibility
3. Score and refine the concept
4. Generate comprehensive requirements

### Crystallization Process

Use Clear Thought for systematic refinement:

```typescript
mcp__clear-thought__mental_models({
  operation: "get_model",
  args: { model: "pre-mortem", tag: "risk-analysis" }
})
```

Develop:
- **Problem statement** - Clear, specific pain point
- **Solution approach** - High-level architecture
- **MVP scope** - What v1 looks like
- **Success criteria** - How we'll know it works
- **Risk mitigations** - What could go wrong and how to handle

### Write Crystallized Concept

Output to `braindump/crystallized-concept.md`:

```markdown
# Crystallized Concept: {Project Name}

*Validated: {timestamp}*

## Selected Direction
{One-liner summary}

## Core Insight
{The non-obvious thing that makes this work}

## Problem Statement
{Clear, specific problem being solved}

## Solution Approach
{High-level architecture description}

## MVP Scope
- [ ] {Feature 1}
- [ ] {Feature 2}
- [ ] {Feature 3}

## Tech Stack (Proposed)
- Frontend: {choice}
- Backend: {choice}
- Storage: {choice}
- Key integrations: {list}

## Success Criteria
1. {Measurable outcome 1}
2. {Measurable outcome 2}

## Risks & Mitigations
| Risk | Impact | Mitigation |
|------|--------|------------|
| {risk 1} | High | {approach} |
| {risk 2} | Medium | {approach} |

## Prior Art Applied
- From {project}: {pattern being used}
- From {project}: {pattern being used}

## Creative Seeds Included
- {Seed that was selected}

## Open Questions (For Capture)
1. {Question to explore with user}
2. {Question to explore with user}
```

---

## Sub-Phase 0e: MOCKUP (Optional)

### Generate Visual Artifacts

If the concept benefits from visual mockups, generate them:

**Option 1: Mermaid Diagrams via MindPilot**

```typescript
mcp__mindpilot__render_mermaid({
  diagram: `
sequenceDiagram
    participant User
    participant App
    participant Backend
    User->>App: Opens app
    App->>Backend: Fetches data
    Backend-->>App: Returns results
    App-->>User: Displays UI
  `,
  title: "{Project} User Flow"
})
```

**Option 2: WiseMapping Mind Maps**

```typescript
mcp__wisemapping__wisemapping_create_map({
  title: "{Project} Feature Map"
})

mcp__wisemapping__wisemapping_update_map_xml({
  id: {map-id},
  xml: `
<map>
  <topic central="true" text="{Project Name}">
    <topic text="Core Features">
      <topic text="Feature A"/>
      <topic text="Feature B"/>
    </topic>
    <topic text="Integrations">
      <topic text="MCP"/>
      <topic text="Notion"/>
    </topic>
  </topic>
</map>
  `
})
```

**Option 3: Architecture Diagrams**

For Claude App users, generate artifact suggestions:

```
📱 MOCKUP SUGGESTIONS FOR CLAUDE APP

To create visual mockups, use Claude App with these prompts:

1. UI Mockup:
   "Create a wireframe mockup of a {project type} with:
   - {feature 1}
   - {feature 2}
   Use a minimal, clean design."

2. System Diagram:
   "Create an architecture diagram showing:
   - {component 1}
   - {component 2}
   - Data flow between them"

3. User Flow:
   "Create a user journey diagram for:
   - {user action 1}
   - {user action 2}
   - {outcome}"
```

### Embed Mockups in Notion

Add generated visuals to the Concept Canvas:

```typescript
mcp__notion__API-patch-block-children({
  block_id: "{canvas-page-id}",
  children: [
    {
      type: "heading_2",
      heading_2: { rich_text: [{ text: { content: "📐 Visual Mockups" } }] }
    },
    {
      type: "image",
      image: { type: "external", external: { url: "{svg-url-or-path}" } }
    }
  ]
})
```

---

## Final Outputs

After completing all sub-phases:

### 1. Structured Context File

Write to `braindump/incubation-context.md`:

```markdown
# Incubation Context: {Project Name}

*Generated: {timestamp}*

## Essence
{1-2 sentences capturing what this project is really about}

## Validated Direction
{Summary of what user confirmed}

## Prior Art DNA
| Source | Pattern | Transferable Insight |
|--------|---------|---------------------|
| {project} | {pattern} | {how it applies} |

## Crystallized Concept Reference
See: braindump/crystallized-concept.md

## Informed Questions for Capture
1. {Context-specific question}
2. {Question from crystallization}
3. {Question exploring edge cases}
```

### 2. Update status.json

```json
{
  "phases": {
    "0-incubate": {
      "status": "complete",
      "completedAt": "{timestamp}",
      "contextFile": "braindump/incubation-context.md",
      "conceptFile": "braindump/crystallized-concept.md",
      "notionCanvas": "{canvas-page-id}",
      "selectedConcept": "{concept name}"
    }
  }
}
```

### 3. Present Summary

```
✅ INCUBATION COMPLETE

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📍 SELECTED DIRECTION
{One-liner of crystallized concept}

🧬 PRIOR ART APPLIED
• {Pattern 1 from project}
• {Pattern 2 from project}

📊 VISUALS CREATED
• Concept Canvas: {Notion URL}
• System Diagram: {embedded/linked}

📁 FILES SAVED
• braindump/incubation-context.md
• braindump/crystallized-concept.md

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

This concept will be loaded by /capture.
Your {N} prepared questions will guide the conversation.

🚀 Ready for /capture when you are.
```

---

## Shortcuts

- `/incubate absorb` - Run only 0a (material absorption)
- `/incubate visualize` - Run 0a + 0b (create canvas)
- `/incubate validate` - Jump to 0c (review existing canvas)
- `/incubate crystallize` - Jump to 0d (develop selected concept)
- `/incubate mockup` - Generate additional visuals

---

## How This Informs Later Phases

| Phase | How Incubation Context Helps |
|-------|------------------------------|
| **1 - CAPTURE** | Smarter questions based on crystallized concept |
| **2 - EXPAND** | Build on validated direction, not from scratch |
| **3 - SPECIFY** | PRD aligned with confirmed architecture |
| **4 - ARCHITECT** | Reference actual implementations from prior art |
| **5 - CONFIGURE** | Apply tech stack from crystallized concept |

---

## ADHD-Friendly Notes

- Interactive confirmations create natural pause points
- Canvas provides visual anchor for discussion
- Can validate asynchronously (review Notion, return later)
- Crystallization prevents scope creep during capture
- "Skip incubation" is always valid
