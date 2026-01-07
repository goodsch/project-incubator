# Project Incubator

A voice-first, AI-assisted project planning system designed as **executive function support** for ADHD brains.

## The Problem It Solves

Creative ADHD minds are excellent at ideation but struggle with:
- **Structuring** ideas into actionable plans
- **Visualizing** systems as a whole with related parts
- **Persisting** state across sessions and context switches
- **Resuming** work without losing momentum
- **Constraining** scope without killing creativity

Project Incubator externalizes these executive functions into a collaborative AI + Notion system.

## Core Principles

### 1. Executive Function as a Service
The system acts as a "prosthetic frontal lobe" - handling structure, state, and momentum so the human can focus on creative thinking.

### 2. Living Documents, Not Transcripts
Notion pages hold **synthesized current understanding**, not conversation logs. AI distills messy exploration into clean, structured sections.

### 3. Two Modes of Operation
- **GUIDED**: Structured questions through phases (for initial capture)
- **CONVERSATIONAL**: Free exploration with synthesis triggers (for refinement)

### 4. State Persistence
Every project page has orientation markers:
- Where am I? (status, phase)
- What's decided? (decisions log)
- What's open? (questions)
- What's next? (actions)

### 5. Graceful Degradation
- **Claude Code**: Full MCP - AI reads/writes Notion directly
- **Claude web/app**: Capture mode - AI outputs paste-ready format

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    User (Voice/Text)                     │
└─────────────────────────┬───────────────────────────────┘
                          │
┌─────────────────────────▼───────────────────────────────┐
│                    Claude Code                           │
│  ┌─────────────────────────────────────────────────┐    │
│  │              Voice Skill                         │    │
│  │  - Recognizes project triggers                   │    │
│  │  - Manages guided phases                         │    │
│  │  - Synthesizes conversation → updates            │    │
│  └─────────────────────────────────────────────────┘    │
└─────────────────────────┬───────────────────────────────┘
                          │ MCP
┌─────────────────────────▼───────────────────────────────┐
│                    Notion                                │
│  ┌─────────────────────────────────────────────────┐    │
│  │           Project Design Doc                     │    │
│  │  - PROJECT SNAPSHOT (orientation)                │    │
│  │  - THE IDEA (captured essence)                   │    │
│  │  - SYSTEM OVERVIEW (the whole)                   │    │
│  │  - COMPONENTS (the parts)                        │    │
│  │  - RELATIONSHIPS (connections)                   │    │
│  │  - DECISIONS LOG (what's locked)                 │    │
│  │  - OPEN QUESTIONS (unknowns)                     │    │
│  │  - NEXT ACTIONS (momentum)                       │    │
│  └─────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────┘
```

## Documentation Index

- [Development Rules](./development-rules.md) - How to build and extend the system
- [Creating New Projects](./creating-projects.md) - How to add new project skills
- [Voice Patterns](./voice-patterns.md) - Command reference
- [Notion Integration](./notion-integration.md) - MCP tools and page structure
