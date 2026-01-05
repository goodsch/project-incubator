# Claude Code Configuration Best Practices

**Curated via discovering-claude-resources skill**
**Date:** 2026-01-05
**Sources:** awesomeclaude.ai, awesome-claude-code (19.2k★), Claude-Code-Everything-You-Need-to-Know (640★), claude-code-tips (411★), awesome-claude-code-subagents (6.8k★)

---

## 1. CLAUDE.md Configuration

### Core Principles

- **Iterate, don't accumulate** - CLAUDE.md becomes part of system prompts; refine like any frequently-used prompt
- **Keep it simple** - Condensed instructions perform better than verbose versions
- **Project-specific** - Only include what genuinely helps achieve project goals

### Recommended Structure

```markdown
# Project Name

## Context
[Brief project description, tech stack, constraints]

## Key Commands
[Build, test, lint commands]

## Conventions
[Coding standards, naming, file organization]

## Workflow
[Preferred development patterns]

## Do NOT
[Explicit anti-patterns to avoid]
```

### Configuration Hierarchy (Priority Order)

1. `.claude/settings.local.json` - Local/machine-specific overrides
2. `.claude/settings.json` - Project-level configuration
3. `~/.claude/settings.json` - User-level defaults
4. Enterprise managed policies - Organization-wide rules

---

## 2. Directory Structure

```
project-root/
├── .claude/
│   ├── agents/           # Subagent configurations
│   ├── commands/         # Custom slash commands (.md files)
│   ├── hooks/            # Event hooks (Python/Bash)
│   ├── skills/           # Agent skills
│   ├── settings.json     # Project config
│   └── settings.local.json  # Local overrides (gitignored)
├── CLAUDE.md             # Project instructions
└── CONTEXT.md            # Human scratchpad (optional)
```

---

## 3. Workflow Patterns

### Pattern A: Explore → Plan → Code → Commit

1. Research and explore relevant files first (don't code yet)
2. Request planning with extended thinking: `think`, `think hard`, `ultrathink`
3. Implement solution with inline verification
4. Commit results and create pull requests

**Toggle via Shift+Tab** between Plan Mode and Accept Edits Mode.

### Pattern B: Test-Driven Development

1. Write tests based on expected inputs/outputs
2. Run tests to confirm failure
3. Commit tests separately
4. Implement code to pass tests
5. Commit code after all tests pass

**Benefit:** Clear targets improve iteration efficiency.

### Pattern C: Visual Iteration

Code → Screenshot → Compare to mock → Iterate → Commit

**Practice:** 2-3 rounds of iteration significantly improves output quality.

---

## 4. Hooks Configuration

### Hook Events

| Event | Purpose |
|-------|---------|
| `PreToolUse` | Intercept before tool execution |
| `PostToolUse` | React after tool completion |
| `UserPromptSubmit` | Validate prompts before processing |
| `Notification` | Custom notification handling |
| `SessionStart/End` | Lifecycle management |

### Exit Code Logic

| Code | Behavior |
|------|----------|
| 0 | Success - stdout shown to user |
| 2 | Blocking - stderr blocks action |
| Other | Non-blocking - shows error, continues |

### JSON Output Control

```python
# PreToolUse - return permission decision
{"permissionDecision": "allow"|"deny"|"ask"}

# PostToolUse/UserPromptSubmit - block or allow
{"decision": "block"}  # or omit to allow

# SessionStart - add context
{"additionalContext": "..."}
```

### Security Best Practices

- Validate all inputs
- Quote variables properly
- Block path traversal attempts
- Use absolute paths
- Skip sensitive files (.env, .git/)

---

## 5. Subagents Configuration

### Tool Assignment by Role

| Role | Recommended Tools |
|------|-------------------|
| Read-only (reviewers) | `Read, Grep, Glob` |
| Code writers | `Read, Write, Edit, Bash, Glob, Grep` |
| Research agents | Add `WebFetch, WebSearch` |
| Full access | All tools |

### Storage Locations

- **Project-level:** `.claude/agents/` (higher precedence)
- **Global:** `~/.claude/agents/` (all projects)

### Best Practices

- Use `/agents` command to create initial configs
- Configure granular tool permissions by role
- Enable inter-agent communication for complex workflows
- Each subagent operates in isolated context windows

### Recommended Subagents

- `code-reviewer` - Quality gates
- `backend-developer` - API/server development
- `devops-engineer` - Infrastructure/deployment
- `typescript-pro` - Language specialist
- `fullstack-developer` - End-to-end features

---

## 6. Custom Slash Commands

### Setup

```bash
mkdir -p .claude/commands
echo "Your prompt instructions here" > .claude/commands/optimize.md
```

### Recommended Commands

| Command | Purpose |
|---------|---------|
| `/handoff` | Create summary before context switch |
| `/pull-request` | Automated PR with logical commit splitting |
| `/optimize` | Performance analysis and improvement |
| `/review` | Code review checklist |

### Namespacing

Use directories for organization:
```
.claude/commands/
├── git/
│   ├── commit.md
│   └── pr.md
└── code/
    ├── review.md
    └── refactor.md
```

---

## 7. MCP Server Integration

### Installation Pattern

```bash
claude mcp add playwright npx '@playwright/mcp@latest'
```

Configuration persists in `~/.claude.json` per-directory.

### Recommended MCP Servers

| Server | Purpose |
|--------|---------|
| Playwright | Web automation, visual testing |
| Sequential Thinking | Extended reasoning workflows |
| Memory | Persistent context management |
| Firecrawl | Web scraping and research |

---

## 8. Context Management

### Fresh Context Matters

- Start new conversations for different topics
- Performance degrades as conversations lengthen
- Context is "best served fresh and condensed"

### Manual Compaction

- Use `/compact` before auto-compaction triggers
- Disable auto-compaction with `/config` for better control
- Create HANDOFF.md summaries before fresh starts

### Token Optimization

- Built-in system prompt uses ~20k tokens
- Skills load only when needed (token-efficient)
- Avoid CLAUDE.md bloat

---

## 9. Git Workflow

### Recommended Permissions

- **Allow:** Commits, branching, pulling automatically
- **Restrict:** Push permissions (require confirmation)
- **Use:** Draft PRs for low-risk exploration

### Parallel Development with Worktrees

```bash
git worktree add -b feature-a ../feature-a
cd ../feature-a && claude
```

- One terminal tab per worktree
- Separate IDE windows for each
- Use Tmux for session management

---

## 10. Productivity Tips

### Terminal Aliases

```bash
alias c='claude'
alias ch='claude --chrome'  # With browser
alias co='code'
```

Combine with flags: `c -c` (continue last), `c -r` (recent list)

### Multitasking Structure

- Manage 3-4 concurrent tasks maximum
- Open new tabs rightward, sweep left-to-right
- Use "cascade" approach for context switching

### Essential Commands

| Command | Purpose |
|---------|---------|
| `/usage` | Check rate limits |
| `/clear` | Fresh conversation |
| `/compact` | Compress with focus |
| `/doctor` | Health check |
| `/cost` | Token statistics |

---

## Sources

- [awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) (19.2k★)
- [Claude-Code-Everything-You-Need-to-Know](https://github.com/wesammustafa/Claude-Code-Everything-You-Need-to-Know) (640★)
- [claude-code-tips](https://github.com/ykdojo/claude-code-tips) (411★)
- [awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents) (6.8k★)
- [awesomeclaude.ai](https://awesomeclaude.ai)
