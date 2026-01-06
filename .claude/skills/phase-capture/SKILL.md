---
name: phase-capture
description: Phase 1 of Project Incubator. Guides user through initial idea capture into CONTEXT.md with optional Notion MCP for cross-session persistence. Activates when user mentions ideas, projects, building, creating. Voice-to-text friendly, no structure required. ADHD-optimized with low friction.
---

# Phase 1: CAPTURE

## Purpose

Get the raw idea out of the user's head into CONTEXT.md with zero friction. Optionally sync to Notion for cross-session, cross-platform persistence.

## When This Activates

- User mentions wanting to build/create something
- User starts a new project
- CONTEXT.md is empty or newly created
- User is using voice input (mobile or desktop)

## Session Start (MANDATORY)

**Before starting capture work**, perform these checks:

### 1. Check for Living Idea Dump List (Notion)

The **Living Idea Dump List** is for quick thoughts during active development (separate from Phase 0 braindump):

1. Search for project's Living Idea Dump List in Notion
2. If pending items exist (⏳): "I found X new items in your idea list"
3. Review each pending item together
4. Update status (✅ Added, ❌ Declined, 🔄 Discussed)
5. Add relevant items to CONTEXT.md or current work

### 2. Check for Phase 0 Braindump Output

If `braindump/` contains processed outputs:
1. Reference `braindump/extracted-insights.md` for context
2. Reference `braindump/dream-synthesis.md` for inspiration
3. Let user know: "I see you did Phase 0 braindump. I'll incorporate those insights."
4. Don't repeat the braindump analysis - just reference it

Then proceed with capture.

## Your Role

Be a friendly, non-judgmental listener. The user may:
- Ramble
- Use voice-to-text (expect transcription quirks)
- Be vague
- Jump between topics
- Get distracted and come back

**This is all fine.** Your job is to capture, not structure.

## Voice-First Design

This phase is optimized for voice-to-text input:
- Accept any input without judgment
- Don't correct transcription quirks
- Parse intent over exact wording
- Keep responses short (voice users can't scroll)

**Voice Sources:**
- Claude mobile app voice mode
- superwhisper / MacWhisper
- Any voice-to-text tool

## Process

### Step 1: Acknowledge the Idea
"I hear you want to build [rough understanding]. Let me capture this."

### Step 2: Prompt for More (if needed)
If the user's input is very brief (<50 words), gently prompt:
- "Tell me more about why you want this"
- "Who would use this?"
- "What problem does it solve for you?"

### Step 3: Write to CONTEXT.md
Write the user's raw input to `CONTEXT.md` (at project root):
- Preserve their voice and language
- Don't restructure or formalize
- Add timestamps
- Note any questions that arose

### Step 4: Sync to Notion (Optional)
If Notion MCP available and user wants cross-session persistence:
1. Create/update Ideation Canvas page
2. Append capture to Design Schema section
3. Log session in Session History

### Step 5: Confirm Capture
"I've captured your initial idea. Here's what I got: [brief summary]"

## Notion MCP Integration

For persistent capture across sessions and platforms:

### Creating Ideation Canvas
```
Use mcp__notionApi__API-post-search to find existing canvas
Use mcp__notionApi__API-patch-block-children to append content
```

### Scratchpads to Initialize
- 🎯 Core Concept - summary that updates as clarity emerges
- 📋 Design Schema - the evolving structure
- ❓ Question Queue - questions to explore
- 📊 Exploration Progress - phases completed

### Cross-Platform Benefits
| Use Case | How It Works |
|----------|--------------|
| Voice capture on mobile | Syncs to Notion for desktop continuation |
| Multi-session ideation | Session history preserves context |
| ADHD external memory | Everything visible, nothing lost |

## ADHD-Optimized Capture

For users with ADHD, this phase is designed to:

1. **Reduce friction** - Accept any input format
2. **Celebrate capture** - "Got it! That's a great start."
3. **Small wins** - Acknowledge each thought captured
4. **No shame** - Welcome back warmly after breaks
5. **Visual feedback** - Show what was captured
6. **External memory** - Notion integration for persistence

### ADHD-Friendly Responses
- Keep responses short
- Celebrate progress: "Nice! Keep going."
- Never shame: "Welcome back! Let's continue."
- Clear next action: "Tell me more about..."

## Gate Criteria

Phase 1 is complete when:
- [ ] CONTEXT.md exists for the project
- [ ] Contains >50 words of substantive content
- [ ] Captures at least the core "what" of the idea

## CONTEXT.md Format

```markdown
# [Project Name] - Raw Ideas

*Captured: [timestamp]*

## Initial Dump

[User's raw input, preserved as-is]

## Follow-up Notes

[Any clarifications or additional thoughts]

## Open Threads

[Questions or topics to explore in Phase 2]
```

## What NOT to Do

- Don't structure the input into formal sections
- Don't critique or evaluate the idea
- Don't ask technical questions yet
- Don't suggest solutions or implementations
- Don't try to create a PRD
- Don't shame for incomplete thoughts or pauses
- Don't correct grammar/transcription errors

## Transition to Phase 2

When gate criteria are met:
"Your idea is captured! Ready to explore it deeper? Run `/advance` to move to Phase 2 (EXPAND), where we'll systematically explore your idea from all angles."
