---
name: braindump
description: Start Phase 0 braindump processing. Processes accumulated materials in braindump/ folder through meta-analysis and AI dream phase.
---

# /braindump

Start Phase 0 (optional) braindump processing for this project.

## What This Does

Phase 0 is a two-part process for when you have accumulated materials to process before starting formal capture:

1. **Meta-Analysis**: Extract explicit AND implicit ideas from your materials
2. **Dream Phase**: AI creative synthesis - novel ideas, unexpected connections

## When to Use

- You have notes, thoughts, or AI transcripts about this idea
- You have reference projects or inspirations to analyze
- You want AI creative input before your own capture
- You've been collecting "someday" notes about this concept

## When to Skip

- Fresh idea with no accumulated materials → go straight to `/capture`
- You prefer to start with your own raw thoughts first

## Process

### 1. Provide Materials

You'll be asked to provide your brain dump materials:
- Text files, markdown, documents
- AI conversation exports (Claude, ChatGPT, Gemini)
- Voice memo transcriptions
- Reference project links
- Screenshots or images with ideas
- Any unstructured notes

### 2. Meta-Analysis

Claude processes all materials to extract:

**Explicit**: Directly stated ideas, features, goals, technologies

**Implicit**: Underlying motivations, unstated needs, patterns, emotional drivers

### 3. Dream Phase

Claude enters creative mode:
- Novel feature ideas
- Unexpected connections
- "What if..." possibilities
- Creative design directions

### 4. Outputs Created

```
braindump/
├── source-materials/         # Your original files
├── extracted-insights.md     # Meta-analysis results
└── dream-synthesis.md        # AI creative exploration
```

## Prerequisites

Place your brain dump materials in the `braindump/` folder before running this command.

## Example

User: `/braindump`

Claude:
```
Starting Phase 0 (BRAINDUMP) processing.

Found materials in braindump/:
- notes.md (2.3 KB)
- chat-export.json (15 KB)

Beginning meta-analysis...
```

## After Braindump

When Phase 0 is complete, run `/advance` to move to Phase 1 (CAPTURE) where you'll add your own raw thoughts on top of the processed materials.
