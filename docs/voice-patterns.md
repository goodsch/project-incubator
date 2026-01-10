# Voice Patterns Reference

Voice commands and patterns for Project Incubator, optimized for mobile/web Claude usage.

## Core Principle: Directive UX

Project Incubator uses **directive** language, not interrogative:

| Instead of... | Say... |
|---------------|--------|
| "What would you like to do?" | "Here's what we're doing next" |
| "How should we proceed?" | "The next step is..." |
| "What's on your mind?" | "Tell me your idea in one sentence" |

The system tells you what to do - you don't have to decide.

## Session Triggers

These phrases activate a project skill:

| Pattern | Action |
|---------|--------|
| "Let's work on [Project]" | Fetch page, present state |
| "Continue [Project]" | Same |
| "[Project] planning" | Same |
| "Work on [Project]" | Same |
| "What's next for [Project]" | Show next action |

## Phase Commands

When using Claude Code, these map to slash commands:

| Voice Pattern | Slash Command | Phase |
|---------------|---------------|-------|
| "Let's start incubation" | `/incubate` | 0 |
| "Capture my idea" | `/capture` | 1 |
| "Let's expand on this" | `/expand` | 2 |
| "Time to specify" | `/specify` | 3 |
| "Design the architecture" | `/architect` | 4 |
| "Configure the project" | `/configure` | 5 |
| "Generate the project" | `/seed` | 6 |

## Status Queries

| Pattern | Action |
|---------|--------|
| "What's the status?" | Show PROJECT SNAPSHOT |
| "Where are we?" | Show current phase + progress |
| "What phase are we in?" | Show phase number and name |
| "What's next?" | Show next directive action |
| "Can we advance?" | Check gate criteria |

## Phase-Specific Responses

### Phase 0: INCUBATE

**Directive prompts:**
- "Add materials to braindump/source-materials/"
- "Run /incubate to build cognitive context from materials and prior projects"
- "Skip incubation and run /capture to start fresh"

### Phase 1: CAPTURE

**Directive prompts:**
- "Tell me your idea in 2-3 sentences"
- "Complete this: 'It's a [thing] that [does what]'"
- "What triggered this idea?"
- "What's the non-obvious insight?"

### Phase 2: EXPAND

**The 6 Macro Questions:**
1. "Who is the primary user?"
2. "What is the core problem?"
3. "What does success look like?"
4. "What are the boundaries?"
5. "What are the key components?"
6. "What are the main risks?"

**Directive prompts:**
- "Answer question 1: Who is the primary user?"
- "Define 3-5 essential features"
- "What's explicitly OUT of scope?"

### Phase 3: SPECIFY

**Directive prompts:**
- "Review the Overview section"
- "Add acceptance criteria to Feature X"
- "Approve the PRD or note changes"

### Phase 4: ARCHITECT

**Directive prompts:**
- "Choose the project type"
- "Review the trade-off analysis"
- "Approve the architecture or note concerns"

### Phase 5: CONFIGURE

**Directive prompts:**
- "Review the CLAUDE.md draft"
- "Confirm the commands list"
- "Approve the configuration"

### Phase 6: SEED

**Directive prompts:**
- "Run /seed to generate the project"
- "Copy output/ to your projects folder"
- "Start building!"

## Confirmation & Rejection

### Confirmation

| Phrase | Meaning |
|--------|---------|
| "Yes" / "Yeah" / "Yep" | Confirm |
| "Approved" | Strong confirm for documents |
| "That's it" / "Exactly" | Strong confirm |
| "Go ahead" | Confirm action |
| "Looks good" | Approve proposed change |

### Rejection

| Phrase | Meaning |
|--------|---------|
| "No" / "Nope" | Reject |
| "Not quite" | Needs refinement |
| "Let me try again" | Will provide better input |
| "Wait" / "Hold on" | Pause, reconsider |
| "Change X to Y" | Specific correction |

## Refinement Signals

AI detects these as cues to explore or revise:

| Signal | Meaning |
|--------|---------|
| "Actually..." | Revising previous understanding |
| "Wait, what about..." | New consideration |
| "The real problem is..." | Core shift |
| "It's more like..." | Refinement |
| "I just realized..." | New insight |

## Session Management

| Pattern | Action |
|---------|--------|
| "We're done for now" | Save state, end session |
| "Pause here" | Save state, can resume |
| "Sync to Notion" | Force update to Notion |
| "Save that" | Synthesize and save recent discussion |

## Mobile Workflow (No MCP)

When using Claude web/mobile app, the skill outputs paste-ready markdown:

```
📋 UPDATE FOR NOTION

Add to PROJECT SNAPSHOT:
| **Phase** | 2 - EXPAND (in_progress) |

Add to COMPONENTS:
| Auth Layer | Handle authentication | → |

---
Paste into your Design Doc in Notion
```

User then:
1. Opens Notion on mobile
2. Navigates to project page
3. Edits relevant section
4. Pastes the formatted content

## Response Style (For AI)

### Keep It Short
- Voice users can't scroll
- Confirmations: 1 sentence max
- Questions: Question + brief context only

### Always Give Direction
- End every response with a clear next action
- Use imperative mood: "Do X" not "You might want to X"
- Single action, not a list

### ADHD-Friendly
- One thing at a time
- Specific starting point ("Start with...")
- No cognitive overhead
- Can be voice-read easily

## When Stuck

If genuinely blocked, present options clearly:

```
🚧 BLOCKED

[Explain the blocker]

Options to unblock:
1. [Option A - specific action]
2. [Option B - specific action]

Which unblocks you faster?
```

Only ask a question when there's a real decision to make.
