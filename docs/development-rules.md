# Development Rules

Rules and principles for building and extending Project Incubator.

## Core Design Rules

### 1. Notion is the Source of Truth
- All project state lives in Notion pages
- `status.json` is local cache only - Notion is authoritative
- Claude reads state at session start, writes on sync
- Never rely on conversation history as persistent state

### 2. Use Working MCP Tools
```
✅ Use: mcp__notion__notion-search
✅ Use: mcp__notion__notion-fetch
✅ Use: mcp__notion__notion-update-page
✅ Use: mcp__notion__notion-create-pages

❌ Avoid: mcp__notionApi__ (broken JSON stringification)
```

### 3. Directive, Not Interrogative
- **Wrong**: "What would you like to work on?"
- **Right**: "The next step is to define your core idea. Start with 'It's a...'"

Every interaction should tell the user what to do, not ask what they want.

### 4. Gate-Checked Progression
Phases cannot be skipped. Each phase has explicit gate criteria:

| Phase | Gate Criteria |
|-------|---------------|
| 0 → 1 | Incubation complete OR "skip incubation" |
| 1 → 2 | THE IDEA has one-liner + core insight |
| 2 → 3 | `expansion.md` with 6 questions answered |
| 3 → 4 | PRD exists and user approved |
| 4 → 5 | Architecture doc exists and user approved |
| 5 → 6 | Configuration approved |

### 5. Synthesis Over Transcription
- **Wrong**: Store Q&A transcripts in Notion
- **Right**: Synthesize understanding into structured sections

Example:
```
Wrong: "Q: What's the problem? A: Users can't find their notes"
Right: "The core pain is discoverability - users capture prolifically but can't surface relevant notes."
```

### 6. Always Provide Orientation
Every session start must show:
- Current phase (number and name)
- Phase progress (what's complete, what's current)
- Clear next action

### 7. Confirm Before Updating Notion
Never write to Notion without explicit confirmation:
```
"I'd update THE IDEA section:

Current: [existing text]
Proposed: [new text]

Confirm this update?"
```

### 8. ADHD-Friendly Responses
- Single clear action (not a list of options)
- Specific starting point ("Start with...")
- No cognitive overhead
- Voice-readable (short sentences)

## The 7-Phase Workflow

| Phase | Name | Purpose | Output |
|-------|------|---------|--------|
| 0 | INCUBATE | Cognitive incubation from materials and prior projects | INCUBATION INSIGHTS |
| 1 | CAPTURE | Get core idea with zero friction | THE IDEA section |
| 2 | EXPAND | 6 macro questions via dialogue | `expansion.md` |
| 3 | SPECIFY | Generate PRD | `spec/prd-v*.md` |
| 4 | ARCHITECT | Tech decisions + trade-offs | `spec/architecture.md` |
| 5 | CONFIGURE | Claude Code setup | `config/` folder |
| 6 | SEED | Generate project scaffold | `output/` folder |

## Page Structure Rules

### Required Sections

Every Design Doc must have:

| Section | Purpose | Update Frequency |
|---------|---------|------------------|
| PROJECT SNAPSHOT | Status, phase, progress | Every session |
| THE IDEA | Captured essence | Phase 1, then stable |
| SYSTEM OVERVIEW | Purpose, scope, boundaries | Phase 2 |
| COMPONENTS | The parts and roles | Phase 2-3 |
| CONTEXT | Raw thoughts and notes | Ongoing |
| OPEN QUESTIONS | Unknowns | Ongoing |
| SPECIFICATION | PRD content | Phase 3 |
| ARCHITECTURE | Tech decisions | Phase 4 |
| CONFIGURATION | Claude Code setup | Phase 5 |
| SEED OUTPUT | Generated scaffold | Phase 6 |

### Phase Progress Table

```markdown
| Phase | Name | Status |
|-------|------|--------|
| 0 | INCUBATE | ⏭️ skipped |
| 1 | CAPTURE | ✅ complete |
| 2 | EXPAND | → in_progress |
| 3 | SPECIFY | ○ pending |
| 4 | ARCHITECT | ○ pending |
| 5 | CONFIGURE | ○ pending |
| 6 | SEED | ○ pending |
```

Status symbols:
- ✅ = Complete
- → = Current (in progress)
- ○ = Pending
- ⏭️ = Skipped
- ⏸️ = Paused

## Slash Command Rules

### Location
```
.claude/commands/
├── incubate.md       # Phase 0
├── capture.md        # Phase 1
├── expand.md         # Phase 2
├── specify.md        # Phase 3
├── architect.md      # Phase 4
├── configure.md      # Phase 5
├── seed.md           # Phase 6
├── status.md         # Show status
├── advance.md        # Gate-checked advance
└── whats-next.md     # Directive next step
```

### Command Structure
```yaml
---
name: command-name
description: Brief description shown in help
---

# /command-name - Title

[Instructions for Claude]

## Process
1. Step one
2. Step two

## Output Format
[Expected output structure]

## Gate Criteria (for phase commands)
[What must be true to complete this phase]
```

## Quality Rules

### Push for Specificity

| Vague Input | Push Back |
|-------------|-----------|
| "It handles data" | "What kind of data? From where to where?" |
| "Users interact" | "Which users? Doing what specifically?" |
| "It's connected" | "How? API? Event? Direct call?" |

### Systems Thinking Prompts

Use these to deepen understanding:
- "If I removed [component], what breaks?"
- "What's the boundary between [A] and [B]?"
- "What does [component] need to work? What does it produce?"

### Synthesis Quality
- Write paragraphs, not bullet dumps
- Capture essence, not literal words
- Connect points into coherent understanding
- Preserve specific examples and numbers

## Mobile Workflow Rules

When MCP isn't available, output paste-ready format:

```markdown
📋 UPDATE FOR NOTION

**Add to [SECTION]:**
[Content to paste]

---
Paste into [Project] Design Doc in Notion
```

## Testing Rules

### Before Deploying Changes

1. Test `/status` shows correct phase
2. Test `/whats-next` gives appropriate directive
3. Test `/advance` checks gates correctly
4. Test phase command triggers right workflow
5. Test Notion updates apply correctly

### Notion Update Testing

```python
# Test replace_content_range
mcp__notion__notion-update-page(
    data={
        "page_id": "[id]",
        "command": "replace_content_range",
        "selection_with_ellipsis": "[first ~10 chars]...[last ~10 chars]",
        "new_str": "[replacement text]"
    }
)
```

## Anti-Patterns to Avoid

### ❌ Don't Ask Open Questions
"What would you like?" → Tell them the next step.

### ❌ Don't Skip Gates
Each phase has criteria for a reason. Enforce them.

### ❌ Don't Skip Confirmation
Always show proposed changes and wait for explicit "yes".

### ❌ Don't Overwhelm
One action at a time. Single focus.

### ❌ Don't Forget Mobile Users
Always have a paste-ready fallback format.

### ❌ Don't Use Broken MCP Tools
Stick to `mcp__notion__` namespace.

### ❌ Don't Leave State Ambiguous
PROJECT SNAPSHOT must always be current and actionable.

## File Naming Conventions

### Spec Documents
```
spec/prd-v1.md        # First PRD version
spec/prd-v2.md        # Revised PRD
spec/architecture.md  # Architecture document
```

### Incubation Materials
```
braindump/source-materials/    # Raw input files
braindump/incubation-insights.md # Processed output
braindump/prior-art-dna.md     # Patterns from local codebases
```

### Config Files
```
config/claude-md-content.md    # CLAUDE.md draft
config/skills.md               # Skills list
config/commands.md             # Commands list
config/agents.md               # Agents list
```

### Output (Phase 6)
```
output/
├── CLAUDE.md
├── CONTEXT.md
├── README.md
├── .claude/
├── docs/
└── src/
```
