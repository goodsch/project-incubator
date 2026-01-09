---
name: resume
description: Fast re-entry into project context. Optimized for < 60 second orientation.
---

# /resume - Fast Re-Entry

Get back up to speed in under 60 seconds after any break. This command provides a compressed orientation that respects your working memory.

## When to Use

- Starting a new session
- Returning after a break (hours or days)
- After context was cleared
- When you ask "where were we?"

## The Process

### 1. Read Current State

Pull from Design Doc:
- Current phase
- Last completed action
- Next action
- Any blockers or open questions

### 2. Deliver Compressed Summary

Format optimized for quick absorption:

```
📍 [PROJECT NAME] - Phase [N]: [PHASE NAME]

**Where you left off:**
[One sentence describing last significant action]

**Current state:**
[One sentence describing what's captured/decided]

**Next action:**
[Single imperative directive - what to do right now]

**Open items:** [count] | **Blockers:** [yes/no]
```

### 3. Wait for Acknowledgment

Don't launch into work. Wait for:
- "Got it" / "OK" → proceed with next action
- "Show me more" → provide fuller context
- "What open items?" → list them
- Specific question → answer it

## Example Output

```
📍 THERAPY TRACKER - Phase 2: EXPAND

**Where you left off:**
Completed Component breakdown with 4 core modules

**Current state:**
Core idea captured. System visual shows therapist view,
client check-in, and notification flow. 3 components defined.

**Next action:**
Answer macro question 4: "What are the user journeys?"

**Open items:** 2 | **Blockers:** no
```

## Voice Variant

For voice interfaces, even more compressed:

```
"Picking up Therapy Tracker. You're in Expand phase with 4 components
defined. Next step is mapping user journeys. Ready?"
```

## What This Replaces

Instead of reading through:
- Full conversation history
- Complete Design Doc
- All braindump materials

You get:
- 5-second orientation
- Clear next action
- Permission to dive in or ask questions

## Anti-Patterns

- Don't provide full history unless asked
- Don't list every decision made
- Don't overwhelm with context
- Don't skip the "next action" - that's the whole point

## Related Commands

- `/status` - More detailed current state (for deep review)
- `/whats-next` - Just the next action (when you know context)
- `/snapshot` - Save current state for future resume
