---
name: snapshot
description: Capture current working context for session continuity.
---

# /snapshot - Context Capture

Save the current working state so you or a future session can resume exactly where you left off. This is your "save game" command.

## When to Use

- Before ending a session
- Before switching to another project
- When you've made significant progress
- Before clearing context
- When you say "let's pause here"

## The Process

### 1. Gather Current State

Collect from conversation and Design Doc:
- Current phase and progress
- Recent decisions made
- Active threads of thought
- Open questions or blockers
- Momentum/direction

### 2. Write Snapshot

Create or update `CONTEXT.md` in project root:

```markdown
# Context Snapshot

**Captured:** {timestamp}
**Phase:** {current phase}
**Session:** {brief session description}

## Current State

{2-3 sentences on where things stand}

## Recent Progress

- {decision or action 1}
- {decision or action 2}
- {decision or action 3}

## Active Threads

{What we were thinking about, directions being explored}

## Next Session Should

1. {First thing to do}
2. {Second priority}
3. {If time permits}

## Open Questions

- {Question 1}
- {Question 2}

## Notes

{Any context that would be lost - ideas mentioned,
concerns raised, preferences expressed}
```

### 3. Confirm

```
📸 Snapshot saved to CONTEXT.md

Captured: Phase 2 progress, component decisions, user journey thread

Next session: Start with `/resume` to pick up where we left off.
```

## Example Snapshot

```markdown
# Context Snapshot

**Captured:** 2024-01-15 3:45pm
**Phase:** 2 - EXPAND
**Session:** Component breakdown and initial user journey mapping

## Current State

Core idea is solid - a therapist-facing homework tracker with minimal
client friction. We've defined 4 components and started on user journeys.

## Recent Progress

- Decided on "passive capture" model for client check-ins
- Chose SMS-first over app-first for client interface
- Identified therapist dashboard as the key view
- Named it "PracticeLoop" (working title)

## Active Threads

Exploring whether real-time notifications are worth the complexity.
Leaning toward daily digest instead. Also thinking about what happens
when clients don't respond - compassionate language vs. streak pressure.

## Next Session Should

1. Complete macro question 4 (user journeys)
2. Decide on notification strategy
3. Start macro question 5 (what could go wrong)

## Open Questions

- How do therapists currently track homework completion?
- Is there HIPAA concern with SMS?
- What's the minimum viable therapist view?

## Notes

User mentioned they have a therapist friend who might give feedback.
Strong preference for "invisible to client" - they shouldn't feel tracked.
```

## Snapshot vs. Design Doc

| Aspect | Design Doc | CONTEXT.md |
|--------|------------|------------|
| Purpose | Canonical project state | Session working memory |
| Persistence | Permanent | Ephemeral (overwritten) |
| Content | What's decided | What we're thinking |
| Formality | Structured | Conversational |
| Updates | When things are confirmed | Every snapshot |

The Design Doc is your **source of truth**.
CONTEXT.md is your **session scratchpad**.

## Auto-Snapshot Triggers

Consider running /snapshot:
- Before `/advance` (capture pre-transition state)
- After significant decisions
- When session is winding down
- When asked to pause

## Related Commands

- `/resume` - Use snapshot to quickly re-enter
- `/status` - Formal state from Design Doc
- `/handoff` - More detailed session end (if available)
