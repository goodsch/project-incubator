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
| 0 | **INCUBATE** | (Optional) Cognitive incubation - AI builds deep understanding from materials, prior projects, and personal context |
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

### Creative & Session Commands
| Command | Purpose |
|---------|---------|
| `/dream` | Deep creative ideation cycle - AI reflects, researches, offers ideas |
| `/resume` | Fast re-entry (< 60 sec orientation) |
| `/snapshot` | Save working context for session continuity |

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

## AI Creative Contribution

The AI isn't just a facilitator - it's a **creative collaborator**. Use `/dream` to unlock:

- **Divergent exploration** - possibilities, prior art, risks, alignment
- **Research** - similar tools, terminology, patterns
- **Mental models** - pre-mortem, first principles, abstraction laddering

Everything offered is **conceptual** - nothing becomes a requirement unless you confirm it in the Design Doc.

See [AI Creative Contribution](docs/ai-creative-contribution.md) for full details.

## Anti-Lock-In Guarantees

Project Incubator explicitly prevents premature commitment:

1. **Marination is conceptual** - Phase 0 output is context, not specification
2. **Dream output is offered** - framed as possibilities, not requirements
3. **Design Doc is truth** - only confirmed items are real
4. **User picks** - AI proposes, user disposes
5. **Journal is reference** - past ideas don't constrain future decisions

This reduces decision paralysis by making stakes explicit: exploring an idea doesn't commit you to building it.

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
- Notion MCP server configured in Claude Code:

```json
// Add to ~/.claude/settings.json or project .mcp.json
{
  "mcpServers": {
    "notion": {
      "type": "http",
      "url": "https://mcp.notion.com/mcp"
    }
  }
}
```

First use will prompt Notion authentication.

## Files

```
project-incubator/
├── README.md                 # This file
├── CLAUDE.md.template        # → Becomes CLAUDE.md after setup
├── CONTEXT.md.template       # → Becomes CONTEXT.md (session state)
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
│       ├── whats-next.md     # Directive next step
│       ├── dream.md          # Creative ideation cycle
│       ├── resume.md         # Fast re-entry
│       └── snapshot.md       # Context capture
├── braindump/                # Phase 0 materials
│   ├── README.md
│   └── source-materials/
├── spec/                     # PRD and architecture docs
├── docs/                     # Reference documentation
│   ├── voice-patterns.md
│   ├── notion-integration.md
│   ├── creating-projects.md
│   ├── development-rules.md
│   └── ai-creative-contribution.md
├── notion-template/
│   └── design-doc.md         # Paste-ready Notion template
├── mcp-server-template/      # MCP server for voice/remote access
│   ├── README.md             # Deployment guide
│   ├── pyproject.toml        # Dependencies
│   ├── .env.example          # Notion config
│   └── src/
│       ├── server.py         # FastMCP server with 9 tools
│       └── notion_sync.py    # Notion API integration
└── skill-template/           # Voice skill templates
    └── voice-companion/
        ├── README.md         # Installation guide
        └── SKILL.md.template # Customizable skill template
```

## Mobile Workflow

For Claude web/mobile (no MCP):
1. Setup generates a skill ZIP file
2. Upload to Claude's skill library
3. Say "Let's work on [Project Name]"
4. Claude outputs paste-ready markdown for Notion

## Voice & MCP Infrastructure

For voice-first workflows (Claude mobile app, remote access):

### MCP Server Template

The `mcp-server-template/` provides a FastMCP server exposing incubator tools:

| Tool | Purpose |
|------|---------|
| `incubator_status` | Get phase, progress, and next action |
| `incubator_capture` | Quick capture ideas (queues for Notion sync) |
| `incubator_advance` | Gate-checked phase advancement |
| `incubator_set_project` | Set active project name |
| `incubator_recap` | Voice-friendly 2-3 sentence summary |
| `incubator_next` | Single imperative directive |
| `incubator_gaps` | What's blocking phase advancement |
| `incubator_sync` | Push captures to Notion |
| `incubator_notion_status` | Check Notion connection |

Deploy locally, via systemd, or expose remotely with Cloudflare Tunnel. See [MCP Server README](mcp-server-template/README.md).

### Voice Companion Skill

The `skill-template/voice-companion/` provides a Claude Code skill for voice-optimized responses:

- **10-second rule**: All responses speakable in under 10 seconds
- **Capture flow**: Maintains momentum during idea capture
- **Intent mapping**: Natural language to MCP tool calls
- **Session continuity**: Auto-recaps on resume

Copy and customize the template for your project instance. See [Voice Companion README](skill-template/voice-companion/README.md)

## Documentation

See the `docs/` folder for:
- [Voice Patterns](docs/voice-patterns.md) - Voice command reference
- [iOS Quick Capture](docs/ios-quick-capture.md) - Mobile capture setup with iOS Shortcuts
- [Notion Integration](docs/notion-integration.md) - MCP tools guide
- [Creating Projects](docs/creating-projects.md) - How to use this template
- [Development Rules](docs/development-rules.md) - Design principles
- [AI Creative Contribution](docs/ai-creative-contribution.md) - Dream cycles and creative collaboration

## License

MIT
