# Development Rules

Rules and principles for building and extending Project Incubator.

## Core Design Rules

### 1. Notion is the Source of Truth
- All project state lives in Notion pages
- Claude Code reads state at session start, writes state on sync
- Never rely on conversation history as persistent state

### 2. Use Working MCP Tools
```
✅ Use: mcp__notion__notion-search
✅ Use: mcp__notion__notion-fetch
✅ Use: mcp__notion__notion-update-page
✅ Use: mcp__notion__notion-create-pages

❌ Avoid: mcp__notionApi__ (broken JSON stringification - issue #3084)
```

### 3. Synthesis Over Transcription
- **Wrong**: Store Q&A transcripts in Notion
- **Right**: Synthesize understanding into structured sections

Example:
```
Wrong: "Q: What's the problem? A: Users can't find their notes"
Right: "The core pain is discoverability - users capture prolifically but can't surface relevant notes when needed."
```

### 4. Always Provide Orientation
Every session start must show:
- Current status/phase
- Summary of what exists
- Clear next action

### 5. Confirm Before Updating
Never write to Notion without explicit confirmation:
```
"Based on our discussion, I'd update THE IDEA section:

Current: [existing text]
Proposed: [new text]

Confirm this update?"
```

### 6. Support Both Modes

**GUIDED Mode** (structured phases):
- Ask one question at a time
- Wait for answer before next question
- Synthesize after each phase

**CONVERSATIONAL Mode** (free exploration):
- Follow user's train of thought
- Track which sections apply
- Propose synthesis when understanding crystallizes

### 7. Graceful Degradation for Mobile
When MCP isn't available (Claude web/app), output paste-ready format:
```markdown
## Session Capture: [Project]
📅 [Date]

**NEW COMPONENT:**
| Component | Role | Status |
|-----------|------|--------|
| [name] | [role] | idea |

---
*Paste into [Project] Design Doc in Notion*
```

## Page Structure Rules

### Required Sections
Every project Design Doc must have:

| Section | Purpose | Update Frequency |
|---------|---------|------------------|
| PROJECT SNAPSHOT | Orientation | Every session |
| THE IDEA | Captured essence | Early, then stable |
| SYSTEM OVERVIEW | The whole | After scoping |
| COMPONENTS | The parts | Progressive |
| RELATIONSHIPS | Connections | After components |
| DECISIONS LOG | What's locked | When decisions made |
| OPEN QUESTIONS | Unknowns | Ongoing |
| NEXT ACTIONS | Momentum | Every session |
| SESSION LOG | Audit trail | Every session |

### Table Formats
Use consistent table structures for AI parseability:

**Components:**
```markdown
| Component | Role | Inputs | Outputs | Status |
|-----------|------|--------|---------|--------|
```

**Decisions:**
```markdown
| Decision | Options | Chosen | Rationale | Date |
|----------|---------|--------|-----------|------|
```

## Skill File Rules

### Location
```
~/.claude/skills/incubator-[projectname]/
├── SKILL.md           # Main skill definition
├── voice-patterns.md  # Voice command reference
└── notion-template.md # Backup template for manual creation
```

### SKILL.md Structure
```yaml
---
name: incubator-[projectname]
description: Voice-based project planning for [Project]. Use when user says "let's work on [Project]"...
---

# [Project] - Project Design Doc

## Project Configuration
project_name: "[Project]"
hub_page_id: "[parent page id]"
project_page_id: "[design doc page id]"

## The Project Design Doc Model
[Explanation of approach]

## Guided Phases
[Phase definitions with questions]

## Two Modes of Operation
[GUIDED vs CONVERSATIONAL]

## Notion MCP Tools
[Tool reference]

## Session Start
[What to do when skill triggers]

## Synthesis Triggers
[When to propose updates]

## Quality Standards
[Push for specificity, systems thinking prompts]

## Mobile Capture Format
[Paste-ready output template]
```

## Quality Rules

### Push for Specificity
| Vague Input | Push Back |
|-------------|-----------|
| "It handles data" | "What kind of data? From where to where?" |
| "Users interact" | "Which users? Doing what specifically?" |
| "It's connected" | "How? API? Event? Direct call?" |
| "Sometimes" | "How often? Daily? Weekly?" |

### Systems Thinking Prompts
Use these to deepen understanding:
- "If I removed [component], what breaks?"
- "What's the boundary between [A] and [B]?"
- "Where does this fit in the bigger picture?"
- "What does [component] need to work? What does it produce?"

### Synthesis Quality
- Write paragraphs, not bullet dumps
- Capture essence, not literal words
- Connect points into coherent understanding
- Preserve specific examples and numbers

## Testing Rules

### Before Deploying a New Skill
1. Test search: Can AI find the page?
2. Test fetch: Can AI read the page structure?
3. Test update: Can AI modify a section?
4. Test session start: Does orientation display correctly?
5. Test synthesis: Does the update confirmation flow work?

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

### ❌ Don't Store Conversation History
The page should reflect current understanding, not how you got there.

### ❌ Don't Skip Confirmation
Always show proposed changes and wait for explicit "yes".

### ❌ Don't Overwhelm with Questions
GUIDED mode: One question at a time.
CONVERSATIONAL mode: Listen, then synthesize.

### ❌ Don't Forget Mobile Users
Always have a paste-ready fallback format.

### ❌ Don't Use Broken MCP Tools
Stick to `mcp__notion__` namespace, avoid `mcp__notionApi__`.

### ❌ Don't Leave State Ambiguous
PROJECT SNAPSHOT should always be current and actionable.
