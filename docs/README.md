# Project Incubator Documentation

A voice-first, AI-assisted project planning system designed as **executive function support** for ADHD brains.

## The Problem It Solves

Creative ADHD minds excel at ideation but struggle with:
- **Structuring** ideas into actionable plans
- **Persisting** state across sessions and context switches
- **Resuming** work without losing momentum
- **Constraining** scope without killing creativity
- **Deciding** what to do next

Project Incubator externalizes these executive functions into a collaborative AI + Notion system that tells you what to do next.

## Core Principles

### 1. Executive Function as a Service
The system acts as a "prosthetic frontal lobe" - handling structure, state, and momentum so you can focus on creative thinking.

### 2. Directive, Not Interrogative
- **Wrong**: "What would you like to work on?"
- **Right**: "The next step is... Start with..."

The system tells you what to do. You don't have to decide.

### 3. Gate-Checked Phases
7 deterministic phases with explicit criteria. You cannot skip ahead. Friction is intentional.

### 4. Session Resilience
100% of state lives in Notion. Close Claude mid-session, resume days later, switch devices - just run `/status`.

### 5. Graceful Degradation
- **Claude Code**: Full MCP - AI reads/writes Notion directly
- **Claude web/app**: Capture mode - AI outputs paste-ready format

## The 7-Phase Workflow

| Phase | Name | Purpose |
|-------|------|---------|
| 0 | BRAINDUMP | (Optional) Process accumulated materials |
| 1 | CAPTURE | Get core idea with zero friction |
| 2 | EXPAND | 6 macro questions via Socratic dialogue |
| 3 | SPECIFY | Generate PRD with acceptance criteria |
| 4 | ARCHITECT | Tech decisions with trade-off analysis |
| 5 | CONFIGURE | Define Claude Code setup for output |
| 6 | SEED | Generate complete buildable project |

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    User (Voice/Text)                     │
└─────────────────────────┬───────────────────────────────┘
                          │
┌─────────────────────────▼───────────────────────────────┐
│                    Claude Code                           │
│  ┌─────────────────────────────────────────────────┐    │
│  │           Slash Commands                         │    │
│  │  /status /whats-next /capture /expand ...        │    │
│  │  - Gate-checked progression                      │    │
│  │  - Directive UX                                  │    │
│  │  - Notion sync                                   │    │
│  └─────────────────────────────────────────────────┘    │
└─────────────────────────┬───────────────────────────────┘
                          │ MCP
┌─────────────────────────▼───────────────────────────────┐
│                    Notion                                │
│  ┌─────────────────────────────────────────────────┐    │
│  │           Project Design Doc                     │    │
│  │  - PROJECT SNAPSHOT (phase, status, next)        │    │
│  │  - THE IDEA (core insight)                       │    │
│  │  - SYSTEM OVERVIEW (scope, boundaries)           │    │
│  │  - COMPONENTS (parts and roles)                  │    │
│  │  - SPECIFICATION (PRD)                           │    │
│  │  - ARCHITECTURE (tech decisions)                 │    │
│  │  - CONFIGURATION (Claude Code setup)             │    │
│  │  - SEED OUTPUT (generated scaffold)              │    │
│  └─────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────┘
```

## Documentation Index

- [Creating New Projects](./creating-projects.md) - How to use the template
- [Voice Patterns](./voice-patterns.md) - Voice command reference
- [Notion Integration](./notion-integration.md) - MCP tools and page structure
- [Development Rules](./development-rules.md) - Design principles and patterns

## Quick Reference

### Slash Commands

| Command | Purpose |
|---------|---------|
| `/status` | Show current phase and progress |
| `/whats-next` | Get directive next action |
| `/advance` | Check gates and advance phase |
| `/braindump` | Phase 0: Process materials |
| `/capture` | Phase 1: Capture idea |
| `/expand` | Phase 2: 6 macro questions |
| `/specify` | Phase 3: Generate PRD |
| `/architect` | Phase 4: Tech decisions |
| `/configure` | Phase 5: Claude Code setup |
| `/seed` | Phase 6: Generate project |

### Phase Status Symbols

| Symbol | Meaning |
|--------|---------|
| ✅ | Complete |
| → | Current (in progress) |
| ○ | Pending |
| ⏭️ | Skipped |
| ⏸️ | Paused |
