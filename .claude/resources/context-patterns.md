# Context Patterns Library

Context management patterns from resources to incorporate in output projects.

## Source: CONTEXT.md Repository

### Dual-File Pattern

**Concept:** Separate human-friendly scratchpad from agent-optimized instructions.

**Files:**
- **CONTEXT.md** - Human scratchpad, voice-friendly, unstructured
- **CLAUDE.md** - Agent-optimized, structured, machine-readable

**Key Insight:** "AI agents do best with information that is rigidly organized and stripped of filler, while humans naturally prefer more expressive communication styles."

### Implementation for Output Projects

```
project/
├── CLAUDE.md      # Structured project instructions
├── CONTEXT.md     # User's ongoing notes and thoughts
└── docs/          # Detailed documentation
```

## Source: Claude-Code-Context-Toolkit

### Bidirectional Conversion

**Commands to include:**
- `/context-to-claude` - Convert notes to structured format
- `/claude-to-context` - Extract insights back to notes

**Agents:**
- `context-converter` - Manages format conversion
- `context-manager` - Handles additions, removals, restructuring

### When to Include

Include context management for:
- Projects with evolving requirements
- Long-running development efforts
- Projects where user captures ideas during development

## Source: Claude-Spec-Starter

### Versioned Specifications

**Pattern:** Keep specs versioned, never overwrite.

```
spec/
├── v1.md          # Initial spec
├── v2.md          # First iteration
└── v3.md          # Current version
```

**Key Feature:** Claude Code automatically recognizes version numbers in filenames.

### Voice-Input Friendly

**Consideration:** Users may capture specs via voice-to-text.

- Accept transcription quirks
- Don't require perfect formatting
- Parse intent over exact wording

## Context Patterns for Output Projects

### Basic (All Projects)
```markdown
# Project CLAUDE.md

## Project Overview
[What this project does]

## Key Files
[Important file locations]

## Commands
[Available commands]

## Context
The CONTEXT.md file contains ongoing notes and thoughts.
Update it as you work.
```

### With Context Management
```markdown
## Context Management

### Files
- **CONTEXT.md**: Your scratchpad for ideas and notes
- **CLAUDE.md**: Project instructions (this file)

### Commands
- `/sync-context`: Update CLAUDE.md from CONTEXT.md notes
- `/add-context [note]`: Add note to CONTEXT.md
```

### With Spec Versioning
```markdown
## Specifications

Specs are versioned in `spec/`:
- Edit the latest version
- Never overwrite - create new version for major changes
- Claude reads version numbers automatically

### Commands
- `/new-spec-version`: Create next version from current
- `/compare-specs v1 v2`: Compare two versions
```

## Dev Docs Pattern (Infrastructure Showcase)

For complex, long-running projects:

```
dev/active/[task-name]/
├── [task]-plan.md      # Strategic plan
├── [task]-context.md   # Key decisions and files
└── [task]-tasks.md     # Checklist format
```

**Purpose:** Preserve context across Claude sessions.

**When to Include:** Projects with multi-session development tasks.
