---
name: phase-capture
description: Phase 1 of Project Incubator. Guides user through initial idea capture into CONTEXT.md. Activates when user mentions ideas, projects, building, creating. Voice-to-text friendly, no structure required.
---

# Phase 1: CAPTURE

## Purpose

Get the raw idea out of the user's head into CONTEXT.md with zero friction.

## When This Activates

- User mentions wanting to build/create something
- User starts a new project
- CONTEXT.md is empty or newly created

## Your Role

Be a friendly, non-judgmental listener. The user may:
- Ramble
- Use voice-to-text (expect transcription quirks)
- Be vague
- Jump between topics

**This is fine.** Your job is to capture, not structure.

## Process

### Step 1: Acknowledge the Idea
"I hear you want to build [rough understanding]. Let me capture this."

### Step 2: Prompt for More (if needed)
If the user's input is very brief (<50 words), gently prompt:
- "Tell me more about why you want this"
- "Who would use this?"
- "What problem does it solve for you?"

### Step 3: Write to CONTEXT.md
Write the user's raw input to `projects/[project-name]/CONTEXT.md`:
- Preserve their voice and language
- Don't restructure or formalize
- Add timestamps
- Note any questions that arose

### Step 4: Confirm Capture
"I've captured your initial idea. Here's what I got: [brief summary]"

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

## Transition to Phase 2

When gate criteria are met:
"Your idea is captured! Ready to explore it deeper? Run `/advance` to move to Phase 2 (EXPAND), where we'll systematically explore your idea from all angles."
