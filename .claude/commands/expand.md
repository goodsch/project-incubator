---
name: expand
description: Socratic expansion session for Phase 2. Works through the 6 macro questions using Clear Thought mental models.
arguments:
  - name: project-name
    description: Name of the project (optional if only one project exists)
    required: false
---

# /expand

Socratic expansion session for Phase 2.

## Prerequisites

- Phase 1 (CAPTURE) must be complete
- CONTEXT.md must contain the raw idea

## Process

1. **Load the phase-expand skill**
   Use Skill tool with skill: "phase-expand"

2. **Review CONTEXT.md**
   Read the captured idea to ground the conversation

3. **Work through the 6 macro questions**

   **Use Clear Thought mental models:**
   ```
   Before starting questions, use:
   mcp__clear-thought__mental_models
   - operation: "get_model"
   - args: { "model": "decomposition" }

   Apply decomposition to identify natural components of the idea.
   ```

4. **Socratic dialogue for each question**

   ### Question 1: Who is the primary user?
   ```
   Let's start with who this is for.

   - Who will use this most?
   - What's their role/situation?
   - How tech-savvy are they?
   - What's their biggest pain point?
   ```

   ### Question 2: What is the core problem?
   ```
   Now let's clarify the problem.

   - What's the single biggest problem this solves?
   - Why do existing solutions fall short?
   - What happens if this problem isn't solved?
   ```

   ### Question 3: What does success look like?
   ```
   How will we know this worked?

   - What changes for the user?
   - What measurable outcomes matter?
   - What would make you say "this was worth building"?
   ```

   ### Question 4: What are the essential features?
   ```
   If you could only build 3-5 things, what would they be?

   - What's the absolute minimum for value?
   - What can wait for later?
   - What's the "killer feature"?
   ```

   ### Question 5: What is out of scope?
   ```
   What are we NOT building?

   - What features are tempting but not essential?
   - What user segments won't we serve?
   - What technical capabilities are deferred?
   ```

   ### Question 6: What does this replace/complement?
   ```
   How does this fit into existing workflows?

   - What do users do today without this?
   - What tools might this integrate with?
   - Is this replacing something or adding to it?
   ```

5. **Use abstraction-laddering as needed**
   ```
   If stuck on why vs how:
   mcp__clear-thought__mental_models
   - operation: "get_model"
   - args: { "model": "abstraction-laddering" }
   ```

6. **Document expansion**
   Create `projects/{name}/expansion.md` with all answers

7. **Validate with user**
   ```
   Here's the expansion summary:

   [Summary of all 6 answers]

   Does this accurately capture your vision?
   Anything to add or correct?
   ```

8. **Confirm expansion complete**
   ```
   Expansion complete! We now have a clear picture of:
   - Who it's for
   - What problem it solves
   - What success looks like
   - Core features
   - Scope boundaries
   - Integration context

   Run /validate to check Phase 2 gate.
   ```

## Clear Thought Integration

**MANDATORY:** Use these tools during expansion:

1. **decomposition** - At start, break down the idea
2. **abstraction-laddering** - When clarifying goals vs implementation
3. **thoughtbox** - For complex multi-step reasoning

## Example Dialogue

```
User: /expand

Claude: Let me review your captured idea first...

        [Reads CONTEXT.md]

        I see you want to build a therapy homework tracker.
        Let me use the decomposition mental model to break
        this down...

        [Uses Clear Thought decomposition]

        I see several natural components:
        - Assignment creation/management
        - Client-facing interface
        - Progress tracking/visibility
        - Notification system

        Let's explore each area. Starting with:

        Question 1: Who is the primary user?

        You mentioned "therapy clients" - tell me more:
        - What age range typically?
        - Individual therapy or group?
        - How comfortable are they with apps generally?

User: Mostly adults, individual therapy, many are anxious
      about technology...

[Dialogue continues through all 6 questions]
```
