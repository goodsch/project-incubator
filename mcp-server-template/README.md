# Hatchery MCP Server

Centralized MCP server for multi-project ideation workflows. Manages multiple incubation projects, each with their own phase progression and state.

## Quick Start

```bash
# Install dependencies
cd mcp-server-template
pip install -e .

# Run server
python -m src.server

# Or with FastMCP for remote access
fastmcp run src/server.py --transport sse --port 3847
```

## Tools

### Project Management

| Tool | Purpose |
|------|---------|
| `hatchery_list_projects` | List all projects with phase status |
| `hatchery_create` | Create a new incubation project |
| `hatchery_select` | Switch to a different project |

### Workflow

| Tool | Purpose |
|------|---------|
| `hatchery_status` | Current project phase and next action |
| `hatchery_capture` | Quick capture ideas to active project |
| `hatchery_advance` | Move to next phase (gate-checked) |
| `hatchery_sync` | Sync captures to Notion |
| `hatchery_notion_status` | Check Notion connection |

### Voice-Optimized

| Tool | Purpose |
|------|---------|
| `hatchery_recap` | 2-3 sentence spoken summary |
| `hatchery_next` | Single imperative directive |
| `hatchery_gaps` | What's blocking phase completion |

## The 7-Phase Workflow

| # | Phase | Purpose |
|---|-------|---------|
| 0 | INCUBATE | Cognitive incubation from materials and prior projects |
| 1 | CAPTURE | Visualization-first walkthrough |
| 2 | EXPAND | Socratic expansion (six macro questions) |
| 3 | SPECIFY | PRD generation |
| 4 | ARCHITECT | Technical design and risk analysis |
| 5 | CONFIGURE | Environment setup |
| 6 | SEED | Project scaffold generation |

Phases are gate-checked - complete requirements before advancing.

## State Management

All state persists in `state/projects.json`:

```json
{
  "active_project": "smart-garden",
  "projects": {
    "smart-garden": {
      "name": "Smart Garden",
      "slug": "smart-garden",
      "current_phase": "EXPAND",
      "phase_progress": {"INCUBATE": "complete", "CAPTURE": "complete"},
      "pending_captures": [],
      "notion_page_id": null
    },
    "voice-journal": {
      "name": "Voice Journal",
      "current_phase": "SPECIFY",
      ...
    }
  }
}
```

## Configuration

### Notion Integration (Optional)

```bash
cp .env.example .env
# Edit .env:
NOTION_API_KEY=secret_xxx
NOTION_IDEAS_DB_ID=xxx-xxx-xxx
```

Create a Quick Capture database with:
- `Capture` (title)
- `Type` (select): Idea, Issue, Feature, Question, Note
- `Created` (created_time)
- `Processed` (checkbox)

## Deployment

### Local (Claude Code)

Add to `~/.claude/settings.json` or project `.mcp.json`:

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

### Remote via Cloudflare Tunnel

1. **Run as systemd service:**
```ini
[Unit]
Description=Hatchery MCP Server
After=network.target

[Service]
Type=simple
WorkingDirectory=/path/to/mcp-server-template
ExecStart=/usr/bin/python -m fastmcp run src/server.py --transport sse --port 3847
EnvironmentFile=%h/.config/hatchery.env
Restart=on-failure

[Install]
WantedBy=default.target
```

2. **Add to cloudflared config:**
```yaml
ingress:
  - hostname: hatchery.yourdomain.com
    service: http://localhost:3847
```

3. **Configure Claude mobile:**
```json
{
  "mcpServers": {
    "hatchery": {
      "type": "sse",
      "url": "https://hatchery.yourdomain.com/sse"
    }
  }
}
```

## Skill Installation

Copy the skill to Claude Code:

```bash
cp -r ../skill-template/hatchery ~/.claude/skills/hatchery
```

The skill provides voice-optimized interaction patterns and usage instructions.

## Usage Examples

```
"List projects"           → Shows all projects
"Create project Garden"   → Creates new project, switches to it
"Work on Garden"          → Switches active project
"Status"                  → Shows phase and next action
"Capture: auto watering"  → Captures idea to active project
"What's next"             → Single directive response
"Advance to CAPTURE"      → Gate-checked phase advancement
"Sync"                    → Pushes captures to Notion
```

## Files

```
mcp-server-template/
├── src/
│   ├── server.py        # FastMCP server (12 tools)
│   └── notion_sync.py   # Notion API integration
├── state/
│   └── projects.json    # Multi-project state (created at runtime)
├── .env.example         # Notion config template
├── pyproject.toml       # Package config
└── README.md            # This file
```
