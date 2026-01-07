# Project Incubator

A GitHub template for voice-based project planning with Claude Code and Notion.

**Purpose:** Transform ideas into structured, buildable project scaffolds using natural conversation and AI-assisted synthesis.

## The Problem This Solves

ADHD minds excel at ideation and creative thinking, but struggle with:
- Structuring ideas into actionable plans
- Constraining scope without killing creativity
- Documenting state for later resumption
- Avoiding overwhelm from too many possibilities

Project Incubator provides **executive function as a service** - a structured thinking partner that externalizes cognitive load without adding friction.

## How It Works

1. **Use this template** on GitHub to create a new repo
2. **Run setup.sh** to create your Notion Design Doc and configure the workspace
3. **Start planning** using slash commands or natural voice
4. **Progress through phases** with gate-checked advancement
5. **Generate output** - a complete, buildable project scaffold

Your Design Doc in Notion is the persistent state - always showing where you are, what's decided, and what's next.

## Quick Start

### 1. Use This Template

Click "Use this template" → Create new repository on GitHub, then:

```bash
git clone https://github.com/YOUR_USERNAME/my-project-planning.git
cd my-project-planning
```

### 2. Run Setup

```bash
./setup.sh
```

This will:
- Detect your project name from git remote (or ask you)
- Guide you to create a Notion Design Doc page
- Generate a voice skill ZIP for Claude web/mobile
- Install slash commands for Claude Code
- Create status.json for local state tracking

### 3. Start Planning

Open Claude Code:

```bash
claude
```

Then use slash commands:

```
/status        # See where you are
/whats-next    # Get the next directive action
/capture       # Start Phase 1: Capture your idea
```

## The 7-Phase Workflow

Project Incubator guides you through 7 deterministic phases:

| Phase | Name | Purpose |
|-------|------|---------|
| 0 | **BRAINDUMP** | (Optional) Process accumulated materials |
| 1 | **CAPTURE** | Get the core idea out with zero friction |
| 2 | **EXPAND** | Answer 6 macro questions via Socratic dialogue |
| 3 | **SPECIFY** | Generate PRD with acceptance criteria |
| 4 | **ARCHITECT** | Tech stack decisions with trade-off analysis |
| 5 | **CONFIGURE** | Define Claude Code setup for output project |
| 6 | **SEED** | Generate complete buildable project scaffold |

**Gate-checked progression:** You cannot advance to the next phase until gate criteria are met. This is intentional - friction prevents half-baked outputs.

## Slash Commands

### Phase Commands
| Command | Phase | Purpose |
|---------|-------|---------|
| `/braindump` | 0 | Process source materials through meta-analysis |
| `/capture` | 1 | Capture core idea with minimal friction |
| `/expand` | 2 | Explore via 6 macro questions |
| `/specify` | 3 | Generate product requirements |
| `/architect` | 4 | Design technical architecture |
| `/configure` | 5 | Configure Claude Code for output |
| `/seed` | 6 | Generate the project scaffold |

### Utility Commands
| Command | Purpose |
|---------|---------|
| `/status` | Show current phase and progress |
| `/whats-next` | Get the next directive action |
| `/advance` | Attempt to advance to next phase (gate-checked) |

## Directive UX

Project Incubator acts as a **project manager**, not an assistant:

**Good (Directive):**
- "Describe your core idea in one sentence. Start with 'It's a...'"
- "Add 3 components to the table. Start with the most obvious one."
- "Review the PRD and approve it with 'approved' or note changes."

**Bad (Interrogative):**
- "What would you like to work on?"
- "How should we proceed?"
- "What's on your mind?"

The system tells you what to do next - you don't have to decide.

## The Design Doc Model

Your project gets a structured Notion page with:

| Section | Purpose |
|---------|---------|
| **PROJECT SNAPSHOT** | Status, phase, progress table, next action |
| **THE IDEA** | Core insight captured simply |
| **SYSTEM OVERVIEW** | Purpose, scope, boundaries |
| **COMPONENTS** | The parts and their roles |
| **CONTEXT** | Raw captured thoughts and notes |
| **OPEN QUESTIONS** | What needs answering |
| **SPECIFICATION** | PRD content (Phase 3) |
| **ARCHITECTURE** | Tech decisions (Phase 4) |
| **CONFIGURATION** | Claude Code setup (Phase 5) |
| **SEED OUTPUT** | Generated scaffold details (Phase 6) |

## Session Resilience

100% of project state lives in Notion. You can:
- Close Claude Code mid-session
- Resume days later
- Switch devices
- Use voice on mobile

Run `/status` to instantly see where you are and what's next.

## Requirements

- [Claude Code CLI](https://docs.anthropic.com/claude-code)
- Notion account (free tier works)
- Notion MCP server configured in Claude Code

## Files

```
project-incubator/
├── README.md                 # This file
├── CLAUDE.md.template        # → Becomes CLAUDE.md after setup
├── setup.sh                  # Setup script
├── verify-setup.sh           # Verify installation
├── status.json               # Local state (created by setup)
├── .claude/
│   └── commands/             # Slash commands
│       ├── braindump.md      # Phase 0
│       ├── capture.md        # Phase 1
│       ├── expand.md         # Phase 2
│       ├── specify.md        # Phase 3
│       ├── architect.md      # Phase 4
│       ├── configure.md      # Phase 5
│       ├── seed.md           # Phase 6
│       ├── status.md         # Show status
│       ├── advance.md        # Gate-checked advance
│       └── whats-next.md     # Directive next step
├── braindump/                # Phase 0 materials
│   ├── README.md
│   └── source-materials/
├── spec/                     # PRD and architecture docs
├── docs/                     # Reference documentation
│   ├── voice-patterns.md
│   ├── notion-integration.md
│   ├── creating-projects.md
│   └── development-rules.md
├── notion-template/
│   └── design-doc.md         # Paste-ready Notion template
└── skill-template/           # Voice skill templates
    ├── SKILL.md.template
    └── voice-patterns.md.template
```

## Mobile Workflow

For Claude web/mobile (no MCP):
1. Setup generates a skill ZIP file
2. Upload to Claude's skill library
3. Say "Let's work on [Project Name]"
4. Claude outputs paste-ready markdown for Notion

## Documentation

See the `docs/` folder for:
- [Voice Patterns](docs/voice-patterns.md) - Voice command reference
- [Notion Integration](docs/notion-integration.md) - MCP tools guide
- [Creating Projects](docs/creating-projects.md) - How to use this template
- [Development Rules](docs/development-rules.md) - Design principles

## License

MIT
