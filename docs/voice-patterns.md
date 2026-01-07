# Voice Patterns Reference

Comprehensive reference for voice commands across all Project Incubator skills.

## Session Triggers

These phrases activate a project skill:

| Pattern | Action |
|---------|--------|
| "Let's work on [Project]" | Fetch page, present state |
| "Continue [Project]" | Same |
| "[Project] planning" | Same |
| "Work on [Project]" | Same |
| "Open [Project]" | Same |

## Mode Selection

### GUIDED Mode
Structured questions through phases.

| Pattern | Result |
|---------|--------|
| "Guide me through it" | Enter GUIDED mode |
| "Walk me through" | Same |
| "Start from scratch" | GUIDED from Phase 1 |
| "Let's do this step by step" | Same |

### CONVERSATIONAL Mode
Free exploration with synthesis triggers.

| Pattern | Result |
|---------|--------|
| "Let's just talk about it" | Enter CONVERSATIONAL |
| "Let me think out loud" | Same |
| "I've been thinking about..." | Triggers CONVERSATIONAL |
| "Actually..." | Same |

## Phase Navigation

| Pattern | Phase |
|---------|-------|
| "Let's work on the idea" | 1: CAPTURE |
| "What's the core idea?" | Same |
| "Define the scope" | 2: SCOPE |
| "What's in and out?" | Same |
| "Break it into pieces" | 3: DECOMPOSE |
| "What are the components?" | Same |
| "How do the parts connect?" | 4: CONNECT |
| "Show me the relationships" | Same |
| "What's next?" | 5: PLAN |
| "What should I do now?" | Same |

## Status Queries

| Pattern | Action |
|---------|--------|
| "What's the status?" | Show PROJECT SNAPSHOT |
| "Where are we?" | Show current phase + progress |
| "What do we have?" | Summarize all sections |
| "Read back [section]" | Read specific section |
| "Show me the components" | Read COMPONENTS |
| "What's decided?" | Show DECISIONS LOG |
| "What's still open?" | Show OPEN QUESTIONS |
| "What's the next action?" | Show NEXT ACTIONS |

## Sync Commands

| Pattern | Action |
|---------|--------|
| "Sync to Notion" | Force synthesis + update |
| "Update the doc" | Same |
| "Save that" | Synthesize recent discussion |
| "Update [section]" | Synthesize specific section |

### Adding Specific Items

| Pattern | Action |
|---------|--------|
| "Add that as a component" | Add to COMPONENTS table |
| "That's a decision" | Add to DECISIONS LOG |
| "That's a question" | Add to OPEN QUESTIONS |
| "Add that to next actions" | Add to NEXT ACTIONS |
| "Log this session" | Add to SESSION LOG |

## Confirmation & Rejection

### Confirmation

| Phrase | Meaning |
|--------|---------|
| "Yes" / "Yeah" / "Yep" | Confirm |
| "That's it" / "Exactly" | Strong confirm |
| "Perfect" / "Nailed it" | Confirm enthusiastically |
| "Close enough" | Weak confirm, proceed |
| "Go ahead" | Confirm action |

### Rejection

| Phrase | Meaning |
|--------|---------|
| "No" / "Nope" | Reject |
| "Not quite" | Needs refinement |
| "Let me try again" | Will provide better input |
| "That's not what I meant" | Misunderstanding |
| "Wait" / "Hold on" | Pause, reconsider |

## Refinement Signals

AI should detect these as cues to explore further or revise:

| Signal | Meaning |
|--------|---------|
| "Actually..." | Revising previous understanding |
| "Wait, what about..." | New consideration |
| "The real problem is..." | Core shift |
| "It's more like..." | Refinement |
| "I just realized..." | New insight |
| "No wait..." | Correction coming |
| "Let me rephrase..." | Better articulation |

## Session Management

| Pattern | Action |
|---------|--------|
| "We're done for now" | Final sync, end session |
| "That's all for today" | Same |
| "Pause here" | Save state, can resume |
| "Let's stop" | End without final sync |
| "Quick note: [idea]" | Capture to scratchpad |

## Special Commands

| Pattern | Action |
|---------|--------|
| "Start a new project" | Create new Design Doc |
| "Show all projects" | List projects in hub |
| "Archive this" | Move to archive (manual) |
| "What can I say?" | Show voice commands |

## Response Style Guidelines

### Keep It Short (Voice-Optimized)
- Confirmations: 1 sentence max
- Synthesis proposals: Key points only
- Questions: Question + brief context

### Always Confirm Changes
Before any Notion update:
```
"I'd update THE IDEA section:

Current: [existing]
Proposed: [new]

Confirm?"
```

### Handle Uncertainty
- "I want to capture more before updating"
- "Want to keep exploring, or save what we have?"
- "I'm not sure I understood - can you clarify?"

## Context-Aware Behavior

### New Session
```
"[Project] - picking up where we left off.

Status: [status] | Phase: [phase]
Last touched: [date]

Current state:
- THE IDEA: [summary]
- COMPONENTS: [count] defined
- OPEN QUESTIONS: [count]

Next action: [from doc]

Continue with [phase], or explore something else?"
```

### After Long Exploration
```
"We've covered a lot. I'm seeing updates for:
- THE IDEA: refined core insight
- COMPONENTS: 2 new components
- DECISIONS: 1 decision made

Want me to sync these to Notion?"
```

### Phase Completion
```
"THE IDEA section is solid now. Ready to move to SCOPE?

Or we can refine this more - your call."
```
