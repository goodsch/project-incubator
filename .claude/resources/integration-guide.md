# External Tool Integration Guide

This guide covers installation and configuration of external tools that enhance the Project Incubator workspace.

## Overview

| Tool | Purpose | Required? |
|------|---------|-----------|
| **claude-mem** | Persistent memory across sessions | Recommended |
| **claude-code-prompt-improver** | Clarify ambiguous prompts | Recommended |
| **Notion MCP** | Async UI layer | Required for full functionality |

---

## claude-mem (Context Priming)

### What It Does

claude-mem provides persistent memory for Claude Code sessions:
- Stores session summaries, decisions, and preferences
- Retrieves relevant context at session start
- Enables "where was I?" continuity across sessions

### Repository

https://github.com/thedotmack/claude-mem

### Installation

```bash
# Clone the repository
git clone https://github.com/thedotmack/claude-mem.git
cd claude-mem

# Install dependencies
npm install

# Build
npm run build

# Make available globally (optional)
npm link
```

### Configuration

1. **Environment Variables**

```bash
# Add to ~/.bashrc or ~/.zshrc
export CLAUDE_MEM_ENABLED=true
export CLAUDE_MEM_STORAGE_PATH="$HOME/.claude-mem"
```

2. **Hook Integration**

The session-start and session-end hooks automatically check for claude-mem:

```bash
# In session-start.sh
if [ "$CLAUDE_MEM_ENABLED" = "true" ] && command -v claude-mem &> /dev/null; then
    claude-mem recall --project "$PROJECT_NAME" --limit 5
fi

# In session-end.sh
if [ "$CLAUDE_MEM_ENABLED" = "true" ] && command -v claude-mem &> /dev/null; then
    claude-mem store --project "$PROJECT_NAME" --summary "$SESSION_SUMMARY"
fi
```

### Usage

**Store context at session end:**
```bash
claude-mem store --project "my-project" --summary "Completed Phase 2, decided on React for frontend"
```

**Recall context at session start:**
```bash
claude-mem recall --project "my-project" --limit 5
```

**List all memories:**
```bash
claude-mem list --project "my-project"
```

### What to Store

| Store | Don't Store |
|-------|-------------|
| Key decisions made | Full conversation transcripts |
| User preferences learned | Sensitive data |
| Current project phase | Temporary debugging info |
| Blockers encountered | Large code blocks |
| Important context | Routine operations |

### ADHD Benefits

- No need to remember where you left off
- Automatic session continuity
- Reduces cognitive load of context switching
- "Welcome back, last time we were working on X"

---

## claude-code-prompt-improver

### What It Does

Analyzes and improves user prompts before execution:
- Clarifies ambiguous requests
- Extracts clear intent from rambling
- Catches voice transcription errors
- Provides "pause before action" safety

### Repository

https://github.com/severity1/claude-code-prompt-improver

### Installation

```bash
# Clone the repository
git clone https://github.com/severity1/claude-code-prompt-improver.git
cd claude-code-prompt-improver

# Install dependencies
npm install

# Build
npm run build

# Make available globally
npm link
```

### Configuration

1. **Environment Variables**

```bash
# Add to ~/.bashrc or ~/.zshrc
export PROMPT_IMPROVER_ENABLED=true
```

2. **Hook Integration**

The prompt-submit hook automatically uses prompt-improver:

```bash
# In prompt-submit.sh
if [ "$PROMPT_IMPROVER_ENABLED" = "true" ] && command -v claude-code-prompt-improver &> /dev/null; then
    improved=$(claude-code-prompt-improver "$prompt")
    # Compare original vs improved
fi
```

### Usage

**Improve a prompt:**
```bash
claude-code-prompt-improver "fix the thing with the buttons that's broken"
# Output: "Fix the onClick handler issue causing double-submission in the Button component"
```

**With confidence score:**
```bash
claude-code-prompt-improver --verbose "maybe add some tests I guess"
# Output:
# Original: "maybe add some tests I guess"
# Improved: "Add unit tests for the main application logic"
# Confidence: 65%
# Ambiguities: Scope unclear - which modules need tests?
```

### When It Triggers Confirmation

The prompt-submit hook creates an Intent Confirmation when:

| Condition | Threshold |
|-----------|-----------|
| Prompt significantly reformulated | >30% word difference |
| Confidence low | <70% |
| Multiple interpretations possible | 2+ valid meanings |
| Destructive action detected | Any match |

### ADHD Benefits

- Catches impulsive, unclear prompts
- "Did you mean X?" before wasting effort
- Voice transcription errors caught early
- Builds in pause for reflection

---

## Notion MCP (Required)

### What It Does

Provides the Notion API integration for:
- Creating/updating Ideation Canvas pages
- Managing Living Idea Dump List
- Creating Input Forms and Intent Confirmations
- Updating Session Dashboard

### Installation

Notion MCP should be configured in your Claude Code MCP settings.

1. **Get Notion API Token**

   - Go to https://www.notion.so/my-integrations
   - Create a new integration
   - Copy the Internal Integration Token

2. **Configure MCP**

   Add to `~/.claude/settings.json`:

```json
{
  "mcpServers": {
    "notionApi": {
      "command": "npx",
      "args": ["-y", "@anthropic/notion-mcp"],
      "env": {
        "NOTION_API_KEY": "your-notion-api-token"
      }
    }
  }
}
```

3. **Share Pages with Integration**

   In Notion, share the pages/databases you want Claude to access with your integration.

### Environment Variables

```bash
export NOTION_MCP_ENABLED=true
export NOTION_WORKSPACE_ID="your-workspace-id"  # Optional
```

### Required Notion Structure

For Project Incubator to work fully, create:

1. **Project Incubator Database** (optional)
   - Contains all project Ideation Canvas pages
   - Properties: Name, Phase, Status, Created, Last Active

2. **Per-Project Pages** (created by /new-project)
   - Ideation Canvas with all sections
   - Living Idea Dump List
   - Session Dashboard (auto-generated)

---

## Environment Setup Script

Create `~/.project-incubator/setup-env.sh`:

```bash
#!/bin/bash
# Project Incubator Environment Setup

# claude-mem
export CLAUDE_MEM_ENABLED=true
export CLAUDE_MEM_STORAGE_PATH="$HOME/.claude-mem"

# prompt-improver
export PROMPT_IMPROVER_ENABLED=true
export COMPLEXITY_THRESHOLD=25  # words before flagging as complex
export REQUIRE_CONFIRMATION_FOR_DESTRUCTIVE=true

# Notion MCP
export NOTION_MCP_ENABLED=true

# Project Incubator
export PROJECT_INCUBATOR_HOME="$HOME/claude-workspaces/Project-Incubator"

echo "Project Incubator environment loaded"
```

Add to shell config:
```bash
# Add to ~/.bashrc or ~/.zshrc
source ~/.project-incubator/setup-env.sh
```

---

## Verification Checklist

After installation, verify each tool:

### claude-mem
```bash
# Should output version info
claude-mem --version

# Should list memories (empty initially)
claude-mem list
```

### prompt-improver
```bash
# Should output improved version
echo "fix stuff" | claude-code-prompt-improver
```

### Notion MCP
```bash
# In Claude Code, test:
# "Search Notion for test"
# Should not error
```

### Hooks
```bash
# Test session-start hook
.claude/hooks/session-start.sh

# Test prompt-submit hook
echo "delete everything" | .claude/hooks/prompt-submit.sh

# Test session-end hook
.claude/hooks/session-end.sh
```

---

## Troubleshooting

### claude-mem not found
```bash
# Ensure it's in PATH
which claude-mem

# If using npm link, check global bin
npm bin -g
```

### prompt-improver not working
```bash
# Check if enabled
echo $PROMPT_IMPROVER_ENABLED

# Test directly
claude-code-prompt-improver "test prompt"
```

### Notion MCP errors
```bash
# Check API key is set
echo $NOTION_API_KEY

# Verify MCP is configured
cat ~/.claude/settings.json | jq '.mcpServers.notionApi'
```

### Hooks not running
```bash
# Check executable permissions
ls -la .claude/hooks/

# Make executable if needed
chmod +x .claude/hooks/*.sh
```

---

## Disabling Features

To disable any feature without uninstalling:

```bash
# Disable claude-mem
export CLAUDE_MEM_ENABLED=false

# Disable prompt-improver
export PROMPT_IMPROVER_ENABLED=false

# Disable destructive action confirmation
export REQUIRE_CONFIRMATION_FOR_DESTRUCTIVE=false
```

---

## Updates

### Checking for Updates

```bash
# claude-mem
cd ~/claude-mem && git pull

# prompt-improver
cd ~/claude-code-prompt-improver && git pull
```

### Reinstalling After Update

```bash
npm install && npm run build && npm link
```
