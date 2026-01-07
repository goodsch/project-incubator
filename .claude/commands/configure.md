---
name: configure
description: Phase 5 - Define tech stack setup and Claude Code configuration for output project
---

# /configure - Phase 5

Configure the development environment and Claude Code setup.

## Prerequisites

- Phase 4 (ARCHITECT) complete
- Architecture approved

## Process

### 1. Review Architecture Decisions

Understand what Claude Code setup will best support development.

### 2. Design CLAUDE.md Content

The output project's CLAUDE.md should include:

1. Project overview (from PRD)
2. Tech stack reference (from architecture)
3. Directory structure guide
4. Development workflow
5. Common commands
6. Code conventions
7. Clear Thought usage guide
8. Quality checklist

### 3. Determine Skills

Based on tech stack and project type:

```
Recommended skills for your project:

From existing libraries:
- [skill]: [why relevant]

Custom skills to create:
- [skill]: [what it would do]

Which of these would be helpful?
```

### 4. Determine Commands

Based on common operations:

```
Recommended commands for your workflow:

Development:
- /dev - Start development server
- /test - Run tests

Quality:
- /lint - Check code quality
- /build - Build for production

Custom for your project:
- /[custom] - [purpose]

What other commands would help?
```

### 5. Determine Agents

Based on complex tasks:

```
Recommended agents:
- documentation-architect: Generate docs

Custom agents:
- [agent]: [purpose]

Do you want any specialized agents?
```

### 6. MCP Server Recommendations

```
MCP servers that would enhance this project:

- clear-thought: For structured reasoning
- [other servers]: [why useful]

Note: These are recommendations - install as needed.
```

### 7. Document Configuration

Create files in `config/`:

**config/claude-md-content.md** - CLAUDE.md draft
**config/skills.md** - Skills list
**config/commands.md** - Commands list
**config/agents.md** - Agents list
**config/mcp.md** - MCP recommendations

### 8. Update Notion

Update CONFIGURATION section with tech stack and setup requirements.
Update PROJECT SNAPSHOT phase status.

### 9. Review with User

```
Configuration Summary:

CLAUDE.md: [summary]
Skills: [count] ([names])
Commands: [count] ([names])
Agents: [count] ([names])
MCP: [recommendations]

Do you approve this configuration?
```

## Clear Thought Prescription

The output project's CLAUDE.md should prescribe Clear Thought usage:

```markdown
## Clear Thought Usage

This project uses Clear Thought MCP for structured reasoning.

### When to Use

| Situation | Tool | Model |
|-----------|------|-------|
| Breaking down tasks | mental_models | decomposition |
| Comparing options | mental_models | trade-off-matrix |
| Identifying risks | mental_models | pre-mortem |
| Complex reasoning | thoughtbox | - |

### Example

When making technical decisions:
1. Use trade-off-matrix to compare options
2. Document the decision and rationale
3. Update decisions/ folder
```

## Gate Criteria for Phase 5

To advance to Phase 6:
- [ ] config/ folder has all configuration files
- [ ] CLAUDE.md content drafted
- [ ] Skills, commands, agents defined
- [ ] User approved configuration

## Context Toolkit Integration

The output project should use the CONTEXT.md pattern:

```markdown
## Context Files

- **CLAUDE.md**: Project instructions (this file)
- **CONTEXT.md**: Your notes and thoughts
- **docs/**: Detailed documentation
```
