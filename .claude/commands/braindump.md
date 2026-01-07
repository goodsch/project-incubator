---
name: braindump
description: Phase 0 - Process accumulated materials through meta-analysis and creative synthesis (optional phase)
---

# /braindump - Phase 0

Process accumulated materials before formal capture.

## When to Use

- You have materials in `braindump/source-materials/` to process
- You want AI creative input before formal capture
- You've been collecting notes, transcripts, or ideas

## When to Skip

- Fresh idea with no accumulated materials
- Prefer to start with raw capture first
- Just say "skip braindump" or "start with capture"

## Prerequisites

- Materials in `braindump/source-materials/`
- status.json shows Phase 0

## Process

### 1. Gather Materials

Check `braindump/source-materials/` for:
- AI conversation exports (ChatGPT, Claude, etc.)
- Voice memo transcriptions
- Notes and ideas
- Reference projects
- Screenshots with ideas

### 2. Meta-Analysis

**Use Clear Thought for analysis:**
```
mcp__clear-thought__mental_models with:
- decomposition - Break down the material themes
- abstraction-laddering - Find the "why" behind stated "whats"
```

Extract:
- **Explicit elements**: Directly stated ideas, features, goals
- **Implicit elements**: Underlying motivations, unstated needs, patterns

### 3. Dream Phase

**Use extended thinking:**
```
mcp__clear-thought__thoughtbox with high totalThoughts (10+)
```

Explore:
- Novel feature ideas inspired by materials
- Unexpected connections between concepts
- "What if..." scenarios
- Creative directions not explicitly mentioned

### 4. Write Outputs

**braindump/extracted-insights.md:**
```markdown
# Extracted Insights - {Project Name}

## Explicit Ideas
- Features & functionality mentioned
- Goals & objectives expressed
- Technical considerations noted

## Implicit Discoveries
- Underlying motivations
- Unstated needs
- Recurring themes
- Emotional drivers

## Key Tensions
- Contradictions or competing priorities

## Recommended Focus Areas
- Where Phase 1 should focus
```

**braindump/dream-synthesis.md:**
```markdown
# Dream Synthesis - {Project Name}

## Novel Ideas
- Unexpected features
- Surprising connections
- "What If..." possibilities

## Creative Directions
- Design possibilities
- Adjacent opportunities
- Wild cards

## Seeds for Phase 1
- Concrete starting points
```

### 5. Update Notion

Update BRAINDUMP MATERIALS section with summary.
Update PROJECT SNAPSHOT:
- Phase: 0 → 1
- Status: → = Processing braindump

### 6. Transition

```
Braindump complete!

Key themes: [top 3-5]
Novel ideas: [count] generated
Dream seeds: [count] ready

Your materials are processed. Ready for Phase 1 (CAPTURE)?
Run /advance to proceed.
```

## ADHD-Friendly Approach

- Break material processing into chunks
- Celebrate each material processed
- Keep dream phase playful
- This phase can be paused and resumed
