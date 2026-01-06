---
name: phase-braindump
description: Phase 0 of Project Incubator (Optional). Processes accumulated materials (notes, AI transcripts, reference projects) through meta-analysis to extract explicit and implicit ideas, followed by AI "dream" phase for creative synthesis. Use when user has materials to process before starting formal capture.
---

# Phase 0: BRAINDUMP (Optional)

## Purpose

Process accumulated materials before starting the formal capture phase. This is a two-part process:
1. **Meta-Analysis**: Extract explicit and implicit ideas from source materials
2. **Dream Phase**: AI creative synthesis inspired by the materials

## When This Activates

- User mentions having notes, transcripts, or materials to process
- User wants to "brain dump" before starting
- User has reference projects or inspirations to analyze
- User explicitly requests Phase 0 / braindump processing

## When to Skip

- Fresh idea with no accumulated materials
- User prefers to start with their own raw capture first
- User says "skip braindump" or "start with capture"

## Process

### Step 1: Gather Materials

Ask user to provide or point to their accumulated materials:
- "Do you have notes, transcripts, or materials to process?"
- "Where are your brain dump materials located?"

**Acceptable sources**:
- Text files, markdown, documents
- AI conversation exports (Claude, ChatGPT, etc.)
- Voice memo transcriptions
- Reference project links or descriptions
- Screenshots or images with ideas
- Any unstructured "someday" notes

### Step 2: Braindump Directory Structure

The `braindump/` directory at project root:
```
braindump/
├── source-materials/    # Original files (user adds these)
├── extracted-insights.md
└── dream-synthesis.md
```

### Step 3: Meta-Analysis (Part 1)

Process all materials to extract:

#### Explicit Elements
- Directly stated ideas
- Mentioned features or functionality
- Expressed goals or objectives
- Named technologies or tools
- Specific user needs mentioned

#### Implicit Elements
- Underlying motivations (why do they want this?)
- Unstated needs (what problems keep recurring?)
- Patterns across materials (what themes emerge?)
- Emotional drivers (what excites them?)
- Constraints implied but not stated

**Use Clear Thought for analysis**:
```
mcp__clear-thought__mental_models with:
- decomposition - Break down the material themes
- abstraction-laddering - Find the "why" behind stated "whats"
```

### Step 4: Dream Phase (Part 2)

After meta-analysis, enter creative "dreaming" mode:

**Use extended thinking**:
```
mcp__clear-thought__thoughtbox with high totalThoughts (10+)
```

**Dream explorations**:
- Novel feature ideas inspired by the materials
- Unexpected connections between concepts
- Creative design possibilities not explicitly mentioned
- "What if..." scenarios
- Adjacent possibilities the user hasn't considered
- Surprising combinations of their ideas

**Tone**: Free-form, generative, playful. This is creative exploration, not structured planning.

### Step 5: Write Outputs

#### extracted-insights.md
```markdown
# Extracted Insights - {Project Name}

*Processed: {timestamp}*
*Source materials: {count} files*

## Explicit Ideas

### Features & Functionality
- [Directly stated feature ideas]

### Goals & Objectives
- [Expressed goals]

### Technical Considerations
- [Mentioned technologies, tools, constraints]

## Implicit Discoveries

### Underlying Motivations
- [Why they want this - read between the lines]

### Unstated Needs
- [Problems implied but not directly stated]

### Recurring Themes
- [Patterns across all materials]

### Emotional Drivers
- [What excites them, what frustrates them]

## Key Tensions
- [Contradictions or competing priorities observed]

## Recommended Focus Areas
- [Based on analysis, where should Phase 1 focus?]
```

#### dream-synthesis.md
```markdown
# Dream Synthesis - {Project Name}

*Generated: {timestamp}*
*Inspired by: {source summary}*

## Novel Ideas

### Unexpected Features
- [Ideas that emerged from creative exploration]

### Surprising Connections
- [Links between concepts they hadn't made explicit]

### "What If..." Possibilities
- [Speculative directions to consider]

## Creative Directions

### Design Possibilities
- [Visual, UX, or structural ideas]

### Adjacent Opportunities
- [Related problems this could solve]

### Wild Cards
- [Far-out ideas that might spark something]

## Seeds for Phase 1
- [Concrete starting points for capture phase]
```

### Step 6: Confirm Completion

Present summary to user:
- "I've processed {X} source materials"
- "Key themes: [list top 3-5]"
- "The dream phase generated {Y} novel ideas"
- "Ready to move to Phase 1 (CAPTURE) when you are"

## Gate Criteria

Phase 0 is complete when:
- [ ] All provided source materials have been processed
- [ ] extracted-insights.md exists with explicit and implicit sections
- [ ] dream-synthesis.md exists with creative explorations
- [ ] User confirms braindump processing is complete

## Transition to Phase 1

When gate criteria are met:
"Your materials have been processed! The insights and dream synthesis are in the braindump folder. Ready to capture your own thoughts? Run `/advance` to move to Phase 1 (CAPTURE)."

## What NOT to Do

- Don't skip the implicit analysis - this is where gold is found
- Don't make the dream phase too structured - let it flow
- Don't judge or filter ideas during dream phase
- Don't create a PRD - that's Phase 3
- Don't rush - this phase benefits from depth

## ADHD-Friendly Approach

- Break material processing into chunks if needed
- Celebrate each material processed
- Keep dream phase playful, not pressured
- Visual summaries help with object permanence
- This phase can be paused and resumed
