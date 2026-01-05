# Project Incubator

A deterministic Claude Code workspace for transforming project ideas into complete, pre-seeded Claude Code project directories.

## What This Does

Project Incubator guides non-coders through a structured 6-phase workflow:

```
CAPTURE → EXPAND → SPECIFY → ARCHITECT → CONFIGURE → SEED
```

Each phase has explicit gate criteria. You cannot skip phases. The system ensures completeness before generating output.

## Output

For each project, you get a complete Claude Code workspace with:
- **CLAUDE.md** - Project instructions optimized for "vibe coding"
- **Documentation** - PRD, architecture decisions, workflow guide
- **Skills, commands, agents** - Pre-configured for your tech stack
- **Source scaffolding** - Directory structure ready to build

## Quick Start

1. **Open this workspace**
   ```bash
   cd ~/claude-workspaces/Project-Incubator
   claude
   ```

2. **Create a new project**
   ```
   /new-project my-idea
   ```

3. **Dump your idea**
   Open `projects/my-idea/CONTEXT.md` and write your raw idea.
   Don't worry about structure - just get it out of your head.

4. **Follow the workflow**
   ```
   /status              # See where you are
   /validate            # Check if ready to advance
   /advance             # Move to next phase
   ```

5. **Phase-specific commands**
   ```
   /capture             # Phase 1: Guided idea capture
   /expand              # Phase 2: Socratic exploration
   /specify             # Phase 3: PRD generation
   /architect           # Phase 4: Technical design
   /configure           # Phase 5: Claude Code config
   /seed                # Phase 6: Generate project
   ```

## The Six Phases

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

Versioned specs (v1.md → v2.md → v3.md)

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

### Auto-Activation
- Skills suggest themselves based on context
- Hooks detect what you're working on
- Guardrails prevent premature advancement

### Multiple Projects
- Work on multiple projects simultaneously
- Each project tracks its own progress
- Independent phase states

### Templates
- Web app (Vue/React/Svelte)
- CLI tool (TypeScript/Python)
- Automation (Python/workflows)

## Requirements

- Claude Code CLI
- Node.js (for hooks)
- Clear Thought MCP server (recommended)

## Setup

Dependencies are installed in `.claude/hooks/`:
```bash
cd .claude/hooks && npm install
```

The workspace is ready to use after cloning.

## Directory Structure

```
Project-Incubator/
├── CLAUDE.md              # Workspace instructions
├── README.md              # This file
├── projects/              # Your projects go here
│   └── {project-name}/
│       ├── CONTEXT.md     # Raw idea
│       ├── status.json    # Phase tracking
│       ├── expansion.md   # Expanded understanding
│       ├── spec/          # Versioned PRDs
│       ├── decisions/     # Architecture decisions
│       ├── config/        # Claude Code config
│       └── output/        # Generated project
├── templates/             # Project type templates
│   ├── web-app/
│   ├── cli-tool/
│   └── automation/
└── .claude/
    ├── skills/            # Phase skills + rules
    ├── commands/          # Workflow commands
    ├── agents/            # Specialized agents
    └── hooks/             # Auto-activation
```

## Philosophy

- **Friction is intentional** - Gates ensure completeness
- **Non-coder optimized** - Voice-friendly, plain language
- **Vibe coding ready** - Output projects are Claude-friendly
- **Clear Thought enhanced** - Structured reasoning built in

## License

MIT
