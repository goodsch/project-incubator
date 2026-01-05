---
name: phase-configure
description: Phase 5 of Project Incubator. Determines Claude Code configuration for the output project. References resource libraries for skills, MCP servers, hooks, and context patterns. Guardrail blocks seeding until configuration complete.
---

# Phase 5: CONFIGURE

## Purpose

Determine the complete Claude Code configuration for the output project using the resource libraries. This phase selects and configures:
- Skills (from skill-library.md)
- MCP servers (from mcp-library.md)
- Hooks (from hooks-library.md)
- Context patterns (from context-patterns.md)

## Prerequisites

- Phase 4 (ARCHITECT) must be complete
- All architecture decisions documented
- User has approved the technical design

## Resource Libraries

**IMPORTANT:** Read these files before making recommendations:

- `.claude/resources/skill-library.md` - Available skills from infrastructure-showcase and development-agents
- `.claude/resources/mcp-library.md` - MCP servers by project type
- `.claude/resources/hooks-library.md` - Hooks and when to include them
- `.claude/resources/context-patterns.md` - CONTEXT.md patterns, spec versioning

## Configuration Process

### Step 1: Read Resource Libraries

```
Read all four resource library files to understand available options.
```

### Step 2: Match Project to Resources

Based on architecture decisions:

**Project Type → Skills**
| Type | Skills to Consider |
|------|-------------------|
| Web App (React) | frontend-dev-guidelines |
| Web App (Vue/Svelte) | frontend-dev-guidelines (adapted) |
| API/Backend | backend-dev-guidelines, route-tester |
| CLI Tool | skill-developer (for custom) |
| Full Stack | frontend + backend |
| Any with errors | error-tracking |

**Project Type → MCP Servers**
| Type | MCPs to Recommend |
|------|-------------------|
| All non-trivial | clear-thought |
| Supabase projects | supabase |
| API integrations | fetch |
| Research | brave-search |
| Testing | playwright |

**Project Complexity → Hooks**
| Complexity | Hooks |
|------------|-------|
| Simple | None or minimal |
| 2+ skills | skill-activation-prompt |
| Complex | skill-activation + post-tool-use |

### Step 3: Design CLAUDE.md Content

The output project's CLAUDE.md should include:

```markdown
# [Project Name]

## Overview
[From PRD]

## Tech Stack
[From architecture]

## Project Structure
[Directory layout]

## Development Workflow
[Getting started, common tasks]

## Commands
[Table of slash commands]

## Clear Thought Usage
[When to use mental models - ALWAYS INCLUDE]

## MCP Servers
[Recommended servers with rationale]

## Quality Checklist
[Pre-commit checks]
```

### Step 4: Select Skills

For each potential skill from skill-library.md:

1. Check tech stack compatibility
2. Determine if adaptation needed
3. Decide: include, adapt, or skip
4. Note any custom skills to create

**Document in:** `projects/{name}/config/skills.md`

```markdown
# Skills Configuration

## From Library

### [Skill Name]
**Source:** infrastructure-showcase / development-agents
**Include:** Yes/Adapted/No
**Reason:** [Why this decision]
**Adaptation:** [If adapted, what changes]

## Custom Skills

### [Custom Skill Name]
**Purpose:** [What it does]
**Triggers:** [Activation keywords/patterns]
**Content:** [Brief outline]
```

### Step 5: Select MCP Servers

From mcp-library.md:

**Document in:** `projects/{name}/config/mcp.md`

```markdown
# MCP Server Recommendations

## Required
- **clear-thought**: Structured reasoning
  - Use mental_models for: [specific situations]
  - Use thoughtbox for: [specific situations]

## Recommended
- **[server]**: [Why useful for this project]

## Optional
- **[server]**: [Use case]
```

### Step 6: Determine Hooks

From hooks-library.md:

**Document in:** `projects/{name}/config/hooks.md`

```markdown
# Hooks Configuration

## Include
- **skill-activation-prompt**: [Why included]
  - Files: skill-activation-prompt.sh, .ts, package.json

## Skip
- **[hook]**: [Why not needed]

## settings.json
[The exact settings.json hook configuration]
```

### Step 7: Choose Context Pattern

From context-patterns.md:

**Document in:** `projects/{name}/config/context.md`

```markdown
# Context Pattern

## Pattern: [Dual-File / With Versioning / Dev Docs / Basic]

## Files to Create
- CLAUDE.md: [Purpose]
- CONTEXT.md: [Purpose]
- [Others if applicable]

## Commands
- [Context-related commands if any]
```

### Step 8: Compile Configuration Summary

Create `projects/{name}/config/summary.md`:

```markdown
# Configuration Summary

## CLAUDE.md
- Sections: [List]
- Clear Thought: Prescribed
- Length: ~[estimate] lines

## Skills
- From library: [count] ([names])
- Custom: [count] ([names])
- Adapted: [count] ([names])

## MCP Servers
- Required: clear-thought
- Recommended: [list]

## Hooks
- Include: [list]
- Skip: [list]

## Context Pattern
- Pattern: [name]
- Files: [list]

## Commands
- [List of commands to create]

## Agents
- [List of agents to include]
```

### Step 9: User Review

```
Configuration Summary:

[Show summary.md content]

Does this configuration look right for your project?
Any additions or changes?
```

### Step 10: Get Approval

```
Do you approve this configuration?
This will allow us to proceed to Phase 6 (SEED).
```

## Gate Criteria

Phase 5 is complete when:
- [ ] Resource libraries were consulted
- [ ] CLAUDE.md content specified
- [ ] Skills selected with rationale
- [ ] MCP servers recommended
- [ ] Hooks determined
- [ ] Context pattern chosen
- [ ] Configuration summary created
- [ ] User approved configuration

## Clear Thought Integration

Use `mcp__clear-thought__thoughtbox` when:
- Deciding between multiple valid skill options
- Designing custom skills
- Determining hook complexity

## Optional: Scout Additional Resources

If the prebuilt libraries don't cover the project's needs:

```
Run /scout-resources to discover additional resources.
```

This is **optional** - prebuilt libraries cover most common cases. Only scout when:
- Unusual tech stack requirements
- Specific integrations not in libraries
- User explicitly requests exploration

Scouted resources are documented in `projects/{name}/scouted-resources.md`.

## What NOT to Do

- Don't recommend skills for incompatible tech stacks
- Don't over-complicate with unnecessary hooks
- Don't skip Clear Thought recommendations
- Don't forget the context pattern

## Transition to Phase 6

When gate criteria are met:
"Configuration complete! Ready to generate the project? Run `/advance` to move to Phase 6 (SEED)."
