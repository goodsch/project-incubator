# Project Incubator - Claude Code Meta-Workspace

A deterministic system for transforming project ideas into complete, pre-seeded Claude Code workspaces through guided ideation and iteration.

**This is a META-WORKSPACE** - it creates other Claude Code workspaces. The output projects will include skills, commands, agents, hooks, and MCP configurations drawn from production-tested resource libraries.

## Purpose

This workspace helps non-coders develop project ideas into complete Claude Code project directories with:
- Comprehensive PRD documentation
- Pre-configured CLAUDE.md for the output project
- Appropriate skills, commands, and agents
- Human-readable documentation
- Clear "vibe coding" workflow

## How It Works

This is a **deterministic, gated workflow**. You cannot skip phases. Each phase has explicit completion criteria that must be validated before proceeding.

```
CAPTURE → EXPAND → SPECIFY → ARCHITECT → CONFIGURE → SEED
```

## Project Structure

This workspace supports multiple projects simultaneously:

```
projects/
├── project-a/
│   ├── CONTEXT.md      # Human scratchpad (voice-friendly)
│   ├── status.json     # Current phase + gate status
│   ├── spec/           # Versioned specifications
│   │   ├── v1.md
│   │   └── v2.md
│   ├── decisions/      # Architecture decision records
│   └── output/         # Generated project directory
└── project-b/
    └── ...
```

## The Six Phases

### Phase 1: CAPTURE
**Goal**: Get the raw idea out of your head into CONTEXT.md
**Input**: Voice notes, rambling thoughts, bullet points - anything
**Output**: CONTEXT.md with raw idea captured
**Gate**: CONTEXT.md exists and contains substantive content (>50 words)

**What to do**: Just dump your idea. Don't structure it. Talk about:
- What you want to build
- Why you want it
- Who it's for
- What problem it solves

### Phase 2: EXPAND
**Goal**: Systematically explore the idea from all angles
**Input**: Raw CONTEXT.md
**Output**: Expanded understanding via Socratic dialogue
**Gate**: All macro questions answered and documented

**Macro Questions** (must answer ALL):
1. Who is the primary user?
2. What is the core problem being solved?
3. What does success look like?
4. What are the 3-5 essential features?
5. What is explicitly OUT of scope?
6. What existing tools/workflows does this replace or complement?

**Clear Thought Integration**: Use `mcp__clear-thought__mental_models` with:
- `decomposition` - Break down the problem space
- `abstraction-laddering` - Move between "why" and "how"

### Phase 3: SPECIFY
**Goal**: Transform expanded understanding into structured PRD
**Input**: Completed expansion answers
**Output**: Versioned specification (spec/v1.md)
**Gate**: PRD passes completeness checklist (all sections present)

**PRD Structure**:
```markdown
# [Project Name] - Product Requirements Document

## Overview
- Problem statement
- Target user
- Success criteria

## Features
- Feature 1: Description, user story, acceptance criteria
- Feature 2: ...

## User Interaction Model
- How user interacts with the system
- Key workflows
- Input/output formats

## Constraints & Scope
- What's in scope
- What's explicitly out of scope
- Technical constraints
- Non-functional requirements

## Open Questions
- Decisions still needed
```

**Iteration**: Specs are versioned. v1 → v2 → v3 as you refine.

### Phase 4: ARCHITECT
**Goal**: Design technical implementation
**Input**: Validated PRD (spec/vN.md)
**Output**: Architecture decisions + tech stack
**Gate**: All architecture decisions documented with rationale

**Architecture Decisions**:
1. Project type (web app, CLI, workflow, etc.)
2. Tech stack (languages, frameworks, libraries)
3. Directory structure
4. Data model (if applicable)
5. External dependencies/APIs
6. Deployment model

**Clear Thought Integration**: Use `mcp__clear-thought__mental_models` with:
- `trade-off-matrix` - Compare tech stack options
- `pre-mortem` - Identify what could go wrong

### Phase 5: CONFIGURE
**Goal**: Determine Claude Code configuration for output project
**Input**: Architecture decisions
**Output**: Claude Code config specification
**Gate**: All config elements specified

**Config Elements**:
1. CLAUDE.md content for output project
2. Skills needed (from library or custom)
3. Commands needed
4. Agents needed
5. Hooks needed (if any)
6. MCP servers to recommend

### Phase 6: SEED
**Goal**: Generate the complete project directory
**Input**: All previous phase outputs
**Output**: Complete, ready-to-use Claude Code project
**Gate**: Project directory passes validation

**Output Structure**:
```
output/
├── CLAUDE.md           # Project instructions
├── CONTEXT.md          # Initialized with project context
├── README.md           # Human documentation
├── .claude/
│   ├── skills/         # Configured skills
│   ├── commands/       # Configured commands
│   └── agents/         # Configured agents
├── docs/
│   ├── PRD.md          # Final PRD
│   ├── ARCHITECTURE.md # Technical design
│   └── WORKFLOW.md     # Vibe coding guide
└── src/                # Scaffolded source structure
```

## Resource Libraries

During Phase 5 (CONFIGURE), these libraries are consulted to select components for output projects:

| Library | Location | Contents |
|---------|----------|----------|
| **Skill Library** | `.claude/resources/skill-library.md` | Skills from infrastructure-showcase, development-agents |
| **MCP Library** | `.claude/resources/mcp-library.md` | MCP server recommendations by project type |
| **Hooks Library** | `.claude/resources/hooks-library.md` | Auto-activation hooks, guardrails |
| **Context Patterns** | `.claude/resources/context-patterns.md` | CONTEXT.md patterns, spec versioning |
| **Best Practices** | `.claude/resources/claude-code-best-practices.md` | Curated configuration best practices (19.2k★ sources) |

### Source Repositories

These libraries are derived from:
- [Claude Code Infrastructure Showcase](https://github.com/diet103/claude-code-infrastructure-showcase) - Auto-activation hooks, skill patterns
- [Claude Development Agents](https://github.com/danielrosehill/Claude-Development-Agents) - 35 agents, 21 commands
- [Claude-Code-Context-Toolkit](https://github.com/danielrosehill/Claude-Code-Context-Toolkit) - CONTEXT.md pattern
- [Claude-Spec-Starter](https://github.com/danielrosehill/Claude-Spec-Starter) - Versioned specifications
- [CONTEXT.md](https://github.com/danielrosehill/CONTEXT.md) - Dual-file context pattern

### Library Maintenance

**Hybrid Approach**: The prebuilt libraries provide deterministic defaults for most projects. For edge cases:

1. **Default**: Use prebuilt libraries as-is (deterministic, tested)
2. **Optional**: Run `/scout-resources` during Phase 5 if gaps exist
3. **Maintenance**: Run `/update-libraries` monthly/quarterly to refresh from sources

Changes are tracked in `.claude/resources/CHANGELOG.md`.

## Commands

### Phase Commands

| Command | Phase | Purpose |
|---------|-------|---------|
| `/new-project <name>` | - | Initialize new project directory |
| `/status` | Any | Show current phase and gate status |
| `/capture` | 1 | Guided capture session |
| `/expand` | 2 | Socratic expansion dialogue |
| `/specify` | 3 | Generate/refine PRD |
| `/architect` | 4 | Technical design session |
| `/configure` | 5 | Claude Code config session |
| `/seed` | 6 | Generate output project |
| `/validate` | Any | Check gate criteria for current phase |
| `/advance` | Any | Attempt to move to next phase (validates first) |

### Resource Library Commands

| Command | Purpose |
|---------|---------|
| `/scout-resources` | **Optional** - Discover project-specific resources beyond prebuilt libraries |
| `/update-libraries` | Periodic maintenance to refresh resource libraries from sources |

## Clear Thought Tool Usage (MANDATORY)

This workspace prescribes specific Clear Thought tools at decision points:

### When to Use Sequential Thinking
Use `mcp__clear-thought__thoughtbox` for:
- Multi-step reasoning during any phase
- Working through complex trade-offs
- Debugging specification inconsistencies

### When to Use Mental Models
Use `mcp__clear-thought__mental_models` with specific models:

| Situation | Model | Why |
|-----------|-------|-----|
| Breaking down the idea | `decomposition` | Identify natural components |
| Understanding user needs | `abstraction-laddering` | Move between why/how |
| Comparing tech options | `trade-off-matrix` | Structured comparison |
| Risk identification | `pre-mortem` | Anticipate failures |
| Challenging assumptions | `inversion` | What would make this fail? |

### When to Use Notebooks
Use `mcp__clear-thought__notebook` for:
- Prototyping data structures
- Testing code snippets during architecture phase
- Validating technical feasibility

## Context Management

This workspace uses the **Context Toolkit pattern**:

### CONTEXT.md (Human Input)
- Your scratchpad for raw thoughts
- Voice-to-text friendly
- No structure required
- Updated by you throughout the process

### status.json (Machine State)
- Current phase
- Gate validation status
- Timestamps
- Generated automatically, don't edit

### spec/vN.md (Structured Output)
- Versioned specifications
- Structured PRD format
- Machine-parseable sections
- Generated from your input via Claude

## Guardrails

Skills in this workspace use `enforcement: "block"` to prevent:
- Skipping phases
- Proceeding with incomplete gates
- Generating output before validation

This is intentional. The friction ensures completeness.

## Templates

The `templates/` directory contains starter patterns for common project types:
- `web-app/` - React/Vue/etc web applications
- `cli-tool/` - Command-line utilities
- `automation/` - Scripts and workflows
- `research/` - Data analysis projects

Templates provide pre-configured skills and structure for the output project.

## Getting Started

1. Run `/new-project my-idea` to create a project directory
2. Open `projects/my-idea/CONTEXT.md` and dump your raw idea
3. Run `/status` to see where you are
4. Follow the phase workflow using commands
5. The system will guide you and block premature advancement

## Principles

1. **Deterministic**: Same inputs → same outputs. No ambiguity.
2. **Gated**: Cannot skip phases. Must validate before advancing.
3. **Documented**: Every decision recorded with rationale.
4. **Complete**: Output projects are ready for immediate use.
5. **Human-Verified**: You approve each phase before moving on.
