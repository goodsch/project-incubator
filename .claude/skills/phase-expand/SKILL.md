---
name: phase-expand
description: Phase 2 of Project Incubator. Socratic expansion of the captured idea. Uses Clear Thought mental models (decomposition, abstraction-laddering). Must answer all 6 macro questions before proceeding. Guardrail enforcement blocks premature specification.
---

# Phase 2: EXPAND

## Purpose

Systematically explore the idea from all angles through Socratic dialogue. Ensure the user has thought through the fundamentals before writing specifications.

## Prerequisites

- Phase 1 (CAPTURE) must be complete
- CONTEXT.md must contain >50 words

## The Six Macro Questions

**ALL must be answered before Phase 2 is complete:**

1. **Who is the primary user?**
   - Demographics, role, technical ability
   - Primary vs secondary users
   - User's current pain points

2. **What is the core problem being solved?**
   - The single most important problem
   - Why existing solutions don't work
   - Impact of the problem remaining unsolved

3. **What does success look like?**
   - Measurable outcomes
   - User behavior changes
   - Business/personal metrics

4. **What are the 3-5 essential features?**
   - Must-have vs nice-to-have
   - MVP scope
   - Feature prioritization rationale

5. **What is explicitly OUT of scope?**
   - Features intentionally excluded
   - User segments not served
   - Technical capabilities deferred

6. **What existing tools/workflows does this replace or complement?**
   - Current state (how users solve this today)
   - Integration requirements
   - Migration considerations

## Clear Thought Integration

**MANDATORY: Use these tools during expansion:**

### For Breaking Down the Problem
```
Use mcp__clear-thought__mental_models with:
- operation: "get_model"
- args: { "model": "decomposition" }
```
Apply decomposition to identify natural components of the idea.

### For Understanding User Needs
```
Use mcp__clear-thought__mental_models with:
- operation: "get_model"
- args: { "model": "abstraction-laddering" }
```
Move between "why" (user goals) and "how" (implementation).

### For Complex Reasoning
```
Use mcp__clear-thought__thoughtbox for multi-step analysis
```

## Process

### Step 1: Review CONTEXT.md
Read the captured idea. Identify what's clear and what's ambiguous.

### Step 2: Socratic Dialogue
Work through each macro question conversationally:
- Ask open-ended questions
- Challenge assumptions gently
- Help user articulate what they mean
- Document answers as you go

### Step 3: Use Mental Models
Apply Clear Thought tools at decision points:
- Use `decomposition` when breaking down features
- Use `abstraction-laddering` when clarifying goals vs implementation

### Step 4: Document Expansion
Update the project with expansion results:

**File: `expansion.md` (at project root)**
```markdown
# Expansion Summary

## 1. Primary User
[Answer with supporting details]

## 2. Core Problem
[Answer with impact analysis]

## 3. Success Criteria
[Measurable outcomes]

## 4. Essential Features
1. [Feature]: [Why essential]
2. [Feature]: [Why essential]
...

## 5. Out of Scope
- [Item]: [Why excluded]
...

## 6. Current State / Integration
[What this replaces or complements]

## Key Insights
[Important realizations from the dialogue]

## Open Questions for Specification
[Questions to resolve in Phase 3]
```

### Step 5: Validate Completeness
Before declaring Phase 2 complete:
- All 6 questions have substantive answers
- User has confirmed the answers reflect their intent
- No critical ambiguities remain

## Gate Criteria

Phase 2 is complete when:
- [ ] All 6 macro questions answered
- [ ] expansion.md created and populated
- [ ] User has validated the expansion summary
- [ ] Clear Thought tools were used at least once

## What NOT to Do

- Don't skip questions because they seem obvious
- Don't answer questions for the user
- Don't move to technical solutions yet
- Don't write PRD sections
- Don't assume - always confirm with user

## Transition to Phase 3

When gate criteria are met:
"Expansion complete! You now have a clear picture of your idea. Ready to formalize this into a specification? Run `/advance` to move to Phase 3 (SPECIFY)."
