---
name: configure
description: Claude Code configuration session for Phase 5. Determines CLAUDE.md content, skills, commands, agents, and MCP recommendations for the output project.
---

# /configure

Claude Code configuration session for Phase 5.

## Prerequisites

- Phase 4 (ARCHITECT) must be complete
- Architecture must be approved

## Process

1. **Load the phase-configure skill**
   Use Skill tool with skill: "phase-configure"

2. **Review architecture decisions**
   Understand what Claude Code setup will best support development

3. **Design CLAUDE.md content**
   ```
   The output project's CLAUDE.md should include:

   1. Project overview (from PRD)
   2. Tech stack reference (from architecture)
   3. Directory structure guide
   4. Development workflow
   5. Common commands
   6. Code conventions
   7. Clear Thought usage guide
   8. Quality checklist

   Let me draft this...
   ```

4. **Determine skills**
   Based on tech stack and project type:
   ```
   Recommended skills for your project:

   From existing libraries:
   - [skill]: [why relevant]
   - [skill]: [why relevant]

   Custom skills to create:
   - [skill]: [what it would do]

   Which of these would be helpful?
   ```

5. **Determine commands**
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

6. **Determine agents**
   Based on complex tasks:
   ```
   Recommended agents:

   - documentation-architect: Generate docs
   - [other relevant agents]

   Custom agents:
   - [agent]: [purpose]

   Do you want any specialized agents?
   ```

7. **MCP server recommendations**
   ```
   MCP servers that would enhance this project:

   - clear-thought: For structured reasoning
   - [other servers]: [why useful]

   Note: These are recommendations - install as needed.
   ```

8. **Document configuration**
   Create files in `config/` (at project root):
   - `claude-md-content.md` - CLAUDE.md draft
   - `skills.md` - Skills list
   - `commands.md` - Commands list
   - `agents.md` - Agents list
   - `mcp.md` - MCP recommendations

9. **Review with user**
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

## Context Toolkit Integration

The output project should use the CONTEXT.md pattern:

```markdown
## Context Files

- **CLAUDE.md**: Project instructions (this file)
- **CONTEXT.md**: Your notes and thoughts
- **docs/**: Detailed documentation
```

## Example

```
User: /configure

Claude: Let me review your architecture...

        Based on your Vue PWA with Supabase backend,
        here's my recommended configuration:

        ## CLAUDE.md Content

        I'll draft a CLAUDE.md that covers:
        - Project overview (therapy homework tracker)
        - Vue 3 + Vite development patterns
        - Supabase integration guide
        - Component conventions
        - Testing approach

        ## Skills

        From libraries:
        - frontend-dev-guidelines (adapted for Vue)

        Custom:
        - supabase-patterns: Supabase-specific patterns

        ## Commands

        - /dev: Start Vite dev server
        - /test: Run Vitest
        - /build: Production build
        - /deploy: Deploy to hosting

        ## Agents

        - documentation-architect: For generating docs

        ## MCP

        - clear-thought: Structured reasoning
        - supabase (if available): Database operations

        Does this configuration look right?
```
