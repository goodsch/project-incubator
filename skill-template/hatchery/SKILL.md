# Hatchery - Multi-Project Ideation Manager

Voice and CLI interface for the Hatchery MCP server. Manages multiple incubation projects through a 7-phase workflow from raw ideas to buildable scaffolds.

## Triggers

Activate when user says:
- "hatchery", "my projects", "incubation projects"
- "list projects", "show projects", "what projects"
- "create project [name]", "new project [name]", "start [name]"
- "work on [name]", "switch to [name]", "select [name]"
- "what's next", "status", "where am I"
- "capture this", "new idea", "I have an idea"

## Quick Reference

| Action | Voice | Tool |
|--------|-------|------|
| List all projects | "list projects" | `hatchery_list_projects` |
| Create new project | "create project [name]" | `hatchery_create(name)` |
| Switch projects | "work on [name]" | `hatchery_select(name)` |
| Check status | "status" or "where am I" | `hatchery_status` |
| Next action | "what's next" | `hatchery_next` |
| Capture idea | "capture: [idea]" | `hatchery_capture(idea)` |
| What's blocking | "what's blocking" | `hatchery_gaps` |
| Advance phase | "advance" | `hatchery_advance(phase)` |
| Voice summary | "recap" | `hatchery_recap` |
| Sync to Notion | "sync" | `hatchery_sync` |

## The 7-Phase Workflow

Every project progresses through these phases:

| # | Phase | What Happens |
|---|-------|--------------|
| 0 | BRAINDUMP | Marinate on raw materials. No requirements yet. |
| 1 | CAPTURE | Visualization-first walkthrough. Describe it as if it exists. |
| 2 | EXPAND | Socratic dialogue. Answer the six macro questions. |
| 3 | SPECIFY | Generate PRD with acceptance criteria. |
| 4 | ARCHITECT | Technical design and pre-mortem risk analysis. |
| 5 | CONFIGURE | Set up development environment. |
| 6 | SEED | Generate project scaffold. |

Phases are gate-checked - you must complete one before advancing to the next.

## Usage Examples

### Starting Fresh
```
User: "Create project called Smart Garden"
→ hatchery_create("Smart Garden")
→ "Created Smart Garden. Starting in braindump phase. What ideas do you have?"

User: "I want automatic watering based on soil moisture"
→ hatchery_capture("automatic watering based on soil moisture")
→ "Got it. Captured as random."

User: "And plant identification from photos"
→ hatchery_capture("plant identification from photos")
→ "Got it. Two ideas captured."
```

### Resuming Work
```
User: "What projects do I have?"
→ hatchery_list_projects()
→ "3 projects. Smart Garden in EXPAND, Voice Journal in SPECIFY, Home Automation in BRAINDUMP."

User: "Work on Voice Journal"
→ hatchery_select("Voice Journal")
→ "Switched to Voice Journal. Phase 3: specify."

User: "What's next?"
→ hatchery_next()
→ "Run /specify to generate the PRD from captured artifacts."
```

### Advancing Phases
```
User: "Advance to capture"
→ hatchery_advance("CAPTURE")
→ "Advanced to CAPTURE. Run /capture to do a visualization-first walkthrough."

User: "What's blocking?"
→ hatchery_gaps()
→ "Missing for CAPTURE: complete visualization walkthrough."
```

## Voice Response Rules

When responding via voice:

1. **Maximum 2-3 sentences** - Keep it speakable
2. **No markdown** - Plain text only
3. **No lists** - Convert to natural speech
4. **End with a prompt** - "What's next?" or "Anything else?"

## Capture Types

When capturing ideas, classify them:

| User Says | Capture Type |
|-----------|--------------|
| "idea", "thought", "maybe" | Random |
| "question", "how do", "wondering" | Research Question |
| "found", "resource", "article" | Resource |
| "connects to", "relates to" | Connection |
| "todo", "follow up", "feature" | Follow-up |

## MCP Server Setup

The Hatchery MCP server manages state in `state/projects.json`. To deploy:

1. **Install dependencies:**
   ```bash
   cd mcp-server-template
   pip install -e .
   ```

2. **Configure Notion (optional):**
   ```bash
   cp .env.example .env
   # Edit .env with your Notion API key and database ID
   ```

3. **Add to Claude Code MCP config:**
   ```json
   {
     "mcpServers": {
       "hatchery": {
         "command": "python",
         "args": ["-m", "src.server"],
         "cwd": "/path/to/mcp-server-template"
       }
     }
   }
   ```

4. **For remote access via Cloudflare Tunnel:**
   See the deployment procedures in server-docs.

## State Management

All project state lives in `state/projects.json`:

```json
{
  "active_project": "smart-garden",
  "projects": {
    "smart-garden": {
      "name": "Smart Garden",
      "slug": "smart-garden",
      "current_phase": "EXPAND",
      "phase_progress": {
        "BRAINDUMP": "complete",
        "CAPTURE": "complete"
      },
      "pending_captures": [],
      "notion_page_id": "abc123..."
    }
  }
}
```

## Notion Integration

When Notion is configured, captures sync to a Quick Capture database. Each project can have:
- A **Design Doc page** for structured project state
- A **Quick Capture database** for rapid idea capture

Set `NOTION_API_KEY` and `NOTION_DATABASE_ID` in `.env` to enable sync.

## Slash Commands

For Claude Code terminal use, these slash commands map to hatchery tools:

| Command | Maps To |
|---------|---------|
| `/status` | `hatchery_status` |
| `/whats-next` | `hatchery_next` |
| `/capture` | Start capture phase workflow |
| `/expand` | Start expand phase workflow |
| `/specify` | Start specify phase workflow |
| `/architect` | Start architect phase workflow |
| `/advance` | `hatchery_advance` |

## Do NOT

- Return raw JSON to voice users
- Give responses longer than 10 seconds spoken
- Ask "what would you like to do?" - be directive
- Mention tool names to users
- Break voice response rules even for errors
