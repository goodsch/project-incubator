---
name: capture
description: Guided capture session for Phase 1. Helps user articulate their idea into CONTEXT.md with zero friction.
arguments:
  - name: project-name
    description: Name of the project (optional if only one project exists)
    required: false
---

# /capture

Guided capture session for Phase 1.

## Prerequisites

- Project must exist (run /new-project first)
- Must be in Phase 1 (CAPTURE)

## Process

1. **Load the phase-capture skill**
   Use Skill tool with skill: "phase-capture"

2. **Follow the skill instructions**
   - Be a friendly, non-judgmental listener
   - Accept rambling, voice-to-text input
   - Don't structure or critique

3. **Prompt for the idea**
   ```
   Tell me about your project idea. Don't worry about
   structure or completeness - just get it out of your head.

   You can talk about:
   - What you want to build
   - Why you want it
   - Who it's for
   - What problem it solves
   - Anything else on your mind

   Just start talking (or typing)...
   ```

4. **Capture to CONTEXT.md**
   - Write everything to projects/{name}/CONTEXT.md
   - Preserve the user's voice
   - Add timestamps
   - Note any questions that came up

5. **Follow-up prompts** (if input is brief)
   - "What made you think of this?"
   - "Who would benefit most from this?"
   - "What's frustrating about how you do this now?"

6. **Confirm capture**
   ```
   I've captured your idea! Here's what I got:

   [Brief summary - 2-3 sentences]

   This is saved in CONTEXT.md. You can add more
   anytime by editing the file or talking to me.

   Run /validate to check if we have enough to proceed.
   ```

## Example Session

```
User: /capture

Claude: Tell me about your project idea...

User: So I've been thinking about this thing where I can
      track my therapy clients' homework assignments and
      they could check them off and I could see what they
      did and didn't do but it needs to be simple because
      some of them aren't great with tech

Claude: I hear you want to build a homework tracking tool
        for therapy clients - simple enough for non-tech
        users. Let me capture this.

        [Writes to CONTEXT.md]

        I've captured your idea! Here's what I got:

        A therapy homework tracker that lets clients check off
        assignments while giving you visibility into completion.
        Simplicity is key for less tech-savvy users.

        Run /validate to check if we're ready for Phase 2.
```

## What NOT to Do

- Don't ask technical questions yet
- Don't suggest solutions
- Don't structure into PRD format
- Don't critique the idea
- Don't rush to the next phase
