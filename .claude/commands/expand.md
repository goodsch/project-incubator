---
name: expand
description: Phase 2 - Explore scope and possibilities through 6 macro questions using Socratic dialogue
---

# /expand - Phase 2

Explore scope and possibilities through guided Socratic dialogue.

## Prerequisites

- Phase 1 (CAPTURE) complete
- THE IDEA section populated in Notion
- CONTEXT.md has captured raw thoughts

## Process

### 1. Review Captured Idea

Read CONTEXT.md and Notion THE IDEA section to ground the conversation.

### 2. Apply Decomposition

**Use Clear Thought:**
```
mcp__clear-thought__mental_models
- operation: "get_model"
- args: { "model": "decomposition" }
```

Identify natural components of the idea before starting questions.

### 3. Work Through 6 Macro Questions

#### Question 1: Who is the primary user?

```
Let's start with who this is for.

- Who will use this most?
- What's their role/situation?
- How tech-savvy are they?
- What's their biggest pain point?
```

#### Question 2: What is the core problem?

```
Now let's clarify the problem.

- What's the single biggest problem this solves?
- Why do existing solutions fall short?
- What happens if this problem isn't solved?
```

#### Question 3: What does success look like?

```
How will we know this worked?

- What changes for the user?
- What measurable outcomes matter?
- What would make you say "this was worth building"?
```

#### Question 4: What are the essential features?

```
If you could only build 3-5 things, what would they be?

- What's the absolute minimum for value?
- What can wait for later?
- What's the "killer feature"?
```

#### Question 5: What is out of scope?

```
What are we NOT building?

- What features are tempting but not essential?
- What user segments won't we serve?
- What technical capabilities are deferred?
```

#### Question 6: What does this replace/complement?

```
How does this fit into existing workflows?

- What do users do today without this?
- What tools might this integrate with?
- Is this replacing something or adding to it?
```

### 4. Use Abstraction Laddering When Stuck

**If stuck on why vs how:**
```
mcp__clear-thought__mental_models
- operation: "get_model"
- args: { "model": "abstraction-laddering" }
```

### 5. Document Expansion

Create `expansion.md` at project root with all answers.

### 6. Update Notion

Update SYSTEM OVERVIEW section:
- Purpose (from Q2)
- Scope IN (from Q4, Q6)
- Scope OUT (from Q5)
- Key actors (from Q1)

Begin COMPONENTS table with identified pieces.

Update OPEN QUESTIONS with unanswered items.

### 7. Validate with User

```
Here's the expansion summary:

[Summary of all 6 answers]

Does this accurately capture your vision?
Anything to add or correct?
```

### 8. Confirm Expansion Complete

```
Expansion complete! We now have a clear picture of:
- Who it's for
- What problem it solves
- What success looks like
- Core features (3-5)
- Scope boundaries
- Integration context

Run /advance to proceed to Phase 3 (SPECIFY).
```

## Gate Criteria for Phase 2

To advance to Phase 3:
- [ ] SYSTEM OVERVIEW populated (purpose, scope, actors)
- [ ] At least 3 components identified
- [ ] OPEN QUESTIONS has items
- [ ] expansion.md exists with all 6 questions answered

## Clear Thought Integration

**MANDATORY:** Use these tools during expansion:

1. **decomposition** - At start, break down the idea
2. **abstraction-laddering** - When clarifying goals vs implementation
3. **thoughtbox** - For complex multi-step reasoning
