# Project Incubator (GitHub Template)

A deterministic Claude Code workspace template for transforming project ideas into complete, pre-seeded Claude Code project directories.

## What This Is

**This is a GitHub template repository.** Clone it uniquely for each new project to avoid context bleed between developments.

## What This Does

Project Incubator guides non-coders through a structured workflow:

```
[BRAINDUMP] → CAPTURE → EXPAND → SPECIFY → ARCHITECT → CONFIGURE → SEED
```

Each phase has explicit gate criteria. You cannot skip phases. The system ensures completeness before generating output.

## Output

At the end of the workflow, you get a complete Claude Code workspace with:
- **CLAUDE.md** - Project instructions optimized for "vibe coding"
- **Documentation** - PRD, architecture decisions, workflow guide
- **Skills, commands, agents** - Pre-configured for your tech stack
- **Source scaffolding** - Directory structure ready to build

## Quick Start

### 1. Create a new project from this template

```bash
# Clone template for your project
gh repo create my-new-project --template Project-Incubator --private
cd my-new-project
```

Or use GitHub's "Use this template" button.

### 2. (Optional) Add brain dump materials

If you have accumulated notes, AI transcripts, or reference materials:

```bash
# Add files to braindump/
cp ~/notes/my-idea.md braindump/
cp ~/downloads/claude-chat-export.json braindump/
```

### 3. Initialize the project

```bash
claude
```

Then run:
```
/init my-project-name
```

This will:
- Detect any brain dump materials
- Create CONTEXT.md and status.json
- Create Notion Ideation Canvas (if Notion MCP available)
- Start Phase 0 (braindump processing) or Phase 1 (capture)

### 4. Follow the workflow

```
/status              # See where you are
/validate            # Check if ready to advance
/advance             # Move to next phase
```

### 5. Phase-specific commands

```
/braindump           # Phase 0: Process accumulated materials
/capture             # Phase 1: Guided idea capture
/expand              # Phase 2: Socratic exploration
/specify             # Phase 3: PRD generation
/architect           # Phase 4: Technical design
/configure           # Phase 5: Claude Code config
/seed                # Phase 6: Generate project
```

## The Phases

### Phase 0: BRAINDUMP (Optional)
Process accumulated materials through meta-analysis and AI dream phase. Only runs if you have files in `braindump/`.

### Phase 1: CAPTURE
Get your raw idea into CONTEXT.md. Voice-to-text friendly. No structure required.

### Phase 2: EXPAND
Answer 6 macro questions through Socratic dialogue:
1. Who is the primary user?
2. What is the core problem?
3. What does success look like?
4. What are the essential features?
5. What is out of scope?
6. What does this replace/complement?

Uses Clear Thought: `decomposition`, `abstraction-laddering`

### Phase 3: SPECIFY
Transform expansion into formal PRD with:
- User stories
- Acceptance criteria
- Scope boundaries

Versioned specs (v1.md -> v2.md -> v3.md)

### Phase 4: ARCHITECT
Design technical implementation:
- Project type
- Tech stack
- Directory structure
- Data model
- Deployment approach

Uses Clear Thought: `trade-off-matrix`, `pre-mortem`

### Phase 5: CONFIGURE
Determine Claude Code setup for output project:
- CLAUDE.md content
- Skills to include
- Commands to create
- Agents to configure

### Phase 6: SEED
Generate the complete project directory, ready for "vibe coding".

## Features

### Deterministic Workflow
- Fixed phases with explicit gates
- Cannot skip or rush
- Ensures completeness

### Clear Thought Integration
- Mental models at decision points
- Structured reasoning for trade-offs
- Pre-mortem for risk identification

### Brain Dump Processing
- Process accumulated notes, AI transcripts, reference projects
- Extract explicit and implicit ideas
- AI dream phase for creative synthesis

### Notion Integration (Optional)
- Living Idea Dump List for ongoing capture
- Ideation Canvas for cross-session persistence
- Session Dashboard for "Where was I?" context

### ADHD-Optimized
- Voice-to-text friendly throughout
- Low friction capture
- Visual progress tracking
- External memory via Notion

## Directory Structure

```
{project-name}/              # Cloned from template
├── CLAUDE.md                # Workspace instructions
├── CONTEXT.md               # Raw idea (created by /init)
├── status.json              # Phase tracking (created by /init)
├── README.md                # This file
├── braindump/               # Brain dump materials (before /init)
├── spec/                    # Versioned PRDs
├── decisions/               # Architecture decisions
├── config/                  # Claude Code config
├── output/                  # Generated project
├── templates/               # Project type templates
│   ├── web-app/
│   ├── cli-tool/
│   └── automation/
└── .claude/
    ├── skills/              # Phase skills + rules
    ├── commands/            # Workflow commands
    ├── agents/              # Specialized agents
    └── hooks/               # Auto-activation
```

## Requirements

- Claude Code CLI
- Node.js (for hooks)
- Clear Thought MCP server (recommended)
- Notion MCP (optional, for persistence)

## Setup

Dependencies are installed in `.claude/hooks/`:
```bash
cd .claude/hooks && npm install
```

## Philosophy

- **Friction is intentional** - Gates ensure completeness
- **Non-coder optimized** - Voice-friendly, plain language
- **Vibe coding ready** - Output projects are Claude-friendly
- **Clear Thought enhanced** - Structured reasoning built in
- **Template per project** - No context bleed between projects

## License

MIT
