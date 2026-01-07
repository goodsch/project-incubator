# Project Incubator

A GitHub template for voice-based project planning with Claude Code and Notion.

**Purpose:** Transform ideas into structured, actionable plans using natural conversation and AI-assisted synthesis.

## The Problem This Solves

ADHD minds excel at ideation and creative thinking, but struggle with:
- Structuring ideas into actionable plans
- Constraining scope without killing creativity
- Documenting state for later resumption
- Avoiding overwhelm from too many possibilities

Project Incubator provides **executive function as a service** - a structured thinking partner that helps externalize what's in your head without adding friction.

## How It Works

1. **Clone this template** for a new project
2. **Run setup** to create your Notion page and voice skill
3. **Start planning** with natural voice commands
4. **Sync to Notion** as understanding crystallizes

Your Design Doc in Notion becomes the persistent state - always showing where you are, what's decided, and what's next.

## Quick Start

### 1. Use This Template

```bash
# From GitHub: Click "Use this template" → Create new repo
# Then clone your new repo:
git clone https://github.com/YOUR_USERNAME/my-project-planning.git
cd my-project-planning
```

### 2. Run Setup

```bash
./setup.sh
```

This will:
- Ask for your project name
- Guide you to create a Notion page
- Create a voice skill for Claude Code
- Configure the workspace

### 3. Start Planning

Open Claude Code in the workspace:

```bash
claude
```

Then just say:

```
"Let's work on [Project Name]"
```

## Voice Commands

| Say This | What Happens |
|----------|--------------|
| "Let's work on [Project]" | Start a planning session |
| "Guide me through it" | Structured phase-by-phase planning |
| "Let's just talk" | Free-form exploration |
| "What's the status?" | See current state |
| "Sync to Notion" | Update the Design Doc |
| "What's next?" | See next actions |
| "We're done for now" | End session with final sync |

## The Design Doc Model

Your project gets a structured Notion page with:

| Section | Purpose |
|---------|---------|
| **PROJECT SNAPSHOT** | Always know status, phase, next action |
| **THE IDEA** | Core insight captured simply |
| **SYSTEM OVERVIEW** | Purpose, scope, boundaries |
| **COMPONENTS** | The parts and their roles |
| **RELATIONSHIPS** | How parts connect |
| **USER JOURNEYS** | How people interact |
| **DECISIONS LOG** | What's locked in and why |
| **OPEN QUESTIONS** | What needs answering |
| **NEXT ACTIONS** | Immediate momentum |

## Two Modes

### GUIDED Mode
Structured questions through 5 phases:
1. **CAPTURE** - Get the idea out
2. **SCOPE** - Define boundaries
3. **DECOMPOSE** - Break into components
4. **CONNECT** - Map relationships
5. **PLAN** - Define next actions

### CONVERSATIONAL Mode
Free exploration with synthesis triggers. Think out loud; Claude tracks which sections relate and proposes updates when understanding crystallizes.

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
├── docs/                     # Reference documentation
│   ├── voice-patterns.md     # Complete voice command reference
│   ├── notion-integration.md # MCP tools guide
│   ├── creating-projects.md  # How to add more projects
│   └── development-rules.md  # Design principles
├── notion-template/          # Paste-ready Notion content
│   └── design-doc.md
└── skill-template/           # Skill files (copied during setup)
    ├── SKILL.md.template
    └── voice-patterns.md.template
```

## Mobile Workflow

When using Claude on mobile (no MCP), Claude outputs paste-ready markdown that you can copy directly into Notion.

## Design Principles

1. **Capture first, structure later** - Don't let structure kill the idea
2. **Always know where you are** - PROJECT SNAPSHOT shows current state
3. **Confirm before updating** - Never update Notion without explicit OK
4. **Keep responses short** - Voice users can't scroll
5. **Systems thinking** - Help visualize whole-to-parts relationships

## Documentation

See the `docs/` folder for:
- Voice command reference
- Notion MCP tool examples
- How to create additional project skills
- Design principles and patterns

## License

MIT
