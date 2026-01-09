# Project Incubator MCP Server Template

MCP server template for project ideation workflow. Exposes tools for status checking, idea capture, and phase management - optimized for both voice (Claude mobile) and CLI (Claude Code) interfaces.

## Quick Start

1. **Copy template to your project:**
```bash
cp -r mcp-server-template your-project-mcp
cd your-project-mcp
```

2. **Configure:**
```bash
# Edit pyproject.toml - change name and description
# Copy .env.example to .env and fill in values
cp .env.example .env
```

3. **Install and run:**
```bash
# Install dependencies
pip install -e .

# Run server
fastmcp run src/server.py

# Or with specific transport for remote access
fastmcp run src/server.py --transport sse --port 3847
```

## Tools

### Core Tools

| Tool | Purpose |
|------|---------|
| `incubator_status` | Get current phase, project, and next action directive |
| `incubator_capture` | Quick capture ideas (queued for Notion sync) |
| `incubator_advance` | Move to next phase (with validation) |
| `incubator_set_project` | Set active project name |
| `incubator_sync` | Sync captures to Notion |
| `incubator_notion_status` | Check Notion integration status |

### Voice-Optimized Tools

| Tool | Purpose |
|------|---------|
| `incubator_recap` | 2-3 sentence spoken summary |
| `incubator_next` | Single next-action directive |
| `incubator_gaps` | What's missing for phase completion |

## Workflow Phases

0. **BRAINDUMP** - Marination of raw materials
1. **CAPTURE** - Visualization-first walkthrough
2. **EXPAND** - Socratic expansion (six macro questions)
3. **SPECIFY** - PRD generation
4. **ARCHITECT** - Technical design and risk analysis
5. **CONFIGURE** - Environment setup
6. **SEED** - Project scaffold generation

## Configuration

### Environment Variables

```bash
# Required for Notion sync
NOTION_API_KEY=secret_xxx

# Quick Capture database ID (create in Notion with: Capture, Type, Created, Processed properties)
NOTION_IDEAS_DB_ID=xxx-xxx-xxx

# Optional
NOTION_PROJECTS_DB_ID=xxx
NOTION_SESSIONS_DB_ID=xxx
```

### Notion Database Schema

Create a "Quick Capture" database in Notion with:
- `Capture` (title) - The idea text
- `Type` (select) - Options: 💡 Idea, 🐛 Issue, ✨ Feature, ❓ Question, 📝 Note
- `Created` (created_time) - Auto-generated
- `Processed` (checkbox) - For workflow tracking

## Deployment

### Local (Claude Code)

Add to `.mcp.json`:
```json
{
  "mcpServers": {
    "incubator": {
      "command": "fastmcp",
      "args": ["run", "/path/to/your-project-mcp/src/server.py"]
    }
  }
}
```

### Remote via Cloudflare Tunnel

1. Run as systemd service:
```ini
[Unit]
Description=Project Incubator MCP Server
After=network.target

[Service]
Type=simple
WorkingDirectory=/path/to/your-project-mcp
ExecStart=/path/to/python -m fastmcp run src/server.py --transport sse --port 3847
EnvironmentFile=%h/.config/incubator-mcp.env
Restart=on-failure

[Install]
WantedBy=default.target
```

2. Add to cloudflared config:
```yaml
ingress:
  - hostname: incubator-mcp.yourdomain.com
    service: http://localhost:3847
```

3. Configure Claude mobile:
```json
{
  "mcpServers": {
    "incubator": {
      "type": "sse",
      "url": "https://incubator-mcp.yourdomain.com/sse"
    }
  }
}
```

## State Management

State is persisted to `state/workflow.json`:
- Active project name
- Current phase
- Phase completion status
- Pending captures (for Notion sync)
- Session count

State survives server restarts and enables session continuity across interfaces.

## Customization

### Renaming Tools

Search and replace `incubator_` with your project prefix in `src/server.py`.

### Adding Phases

Edit the `PHASES`, `PHASE_DIRECTIVES`, and `PHASE_REQUIREMENTS` constants in `src/server.py`.

### Custom Notion Schema

Modify `src/notion_sync.py` to match your Notion database schema.
