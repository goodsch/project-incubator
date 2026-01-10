# Creating New Projects

How to use the Project Incubator template to start a new project.

## Quick Start

1. Use this GitHub template to create a new repo
2. Clone locally and run setup.sh
3. Start planning with `/status` and `/whats-next`

## Step 1: Create Repository from Template

### On GitHub

1. Go to the Project Incubator template repository
2. Click **"Use this template"** → **"Create a new repository"**
3. Name your repository (e.g., `my-awesome-project-planning`)
4. Choose public or private
5. Click **"Create repository"**

### Clone Locally

```bash
git clone https://github.com/YOUR_USERNAME/my-awesome-project-planning.git
cd my-awesome-project-planning
```

## Step 2: Run Setup

```bash
./setup.sh
```

The setup script will:

### 1. Detect Project Name
- Automatically extracts from git remote URL
- Or prompts you to enter manually

### 2. Create Notion Design Doc
- Prompts you to create a new page in Notion
- Provides the template content to paste
- Asks for the page ID (from URL)

### 3. Generate Skill ZIP
- Creates `[project-name]-skill.zip`
- For use with Claude web/mobile app
- Upload to Claude's skill library for voice planning

### 4. Create Local State
- Generates `status.json` with project configuration
- Tracks current phase and Notion page ID
- Used by slash commands for state management

### 5. Install Slash Commands
- Commands already in `.claude/commands/`
- Ready to use in Claude Code

## Step 3: Verify Setup

```bash
./verify-setup.sh
```

Or manually check:
- [ ] `status.json` exists with correct page ID
- [ ] `CLAUDE.md` exists (copied from template)
- [ ] Notion page is accessible
- [ ] Skill ZIP created (if using mobile)

## Step 4: Start Planning

Open Claude Code:

```bash
claude
```

### First Commands

```
/status        # See current state
/whats-next    # Get directive next action
```

### Phase Progression

```
/capture       # Phase 1: Capture the idea
/expand        # Phase 2: Answer 6 macro questions
/specify       # Phase 3: Generate PRD
/architect     # Phase 4: Tech decisions
/configure     # Phase 5: Claude Code setup
/seed          # Phase 6: Generate project
```

### Advancing Phases

```
/advance       # Check gates and advance if ready
```

Each phase has gate criteria that must be met before advancing.

## The 7-Phase Workflow

| Phase | Name | What Happens | Gate Criteria |
|-------|------|--------------|---------------|
| 0 | INCUBATE | Cognitive incubation from materials and prior projects | `incubation-insights.md` exists |
| 1 | CAPTURE | Get core idea out | THE IDEA has one-liner + insight |
| 2 | EXPAND | 6 macro questions | `expansion.md` complete |
| 3 | SPECIFY | PRD generation | PRD approved by user |
| 4 | ARCHITECT | Tech decisions | Architecture approved |
| 5 | CONFIGURE | Claude Code setup | Configuration approved |
| 6 | SEED | Generate scaffold | All files generated |

## Directory Structure After Setup

```
my-project-planning/
├── CLAUDE.md                 # Project instructions (from template)
├── status.json               # Local state tracking
├── [project-name]-skill.zip  # Voice skill for mobile
├── .claude/
│   └── commands/             # 10 slash commands
├── braindump/
│   ├── README.md
│   └── source-materials/     # Put Phase 0 materials here
├── spec/                     # PRD and architecture docs go here
├── docs/                     # Reference documentation
├── notion-template/
│   └── design-doc.md         # Notion template reference
└── skill-template/           # Skill templates (used by setup)
```

## Mobile/Voice Workflow

If you're using Claude on mobile or web (without MCP):

1. **Upload the skill ZIP** to Claude's skill library
2. **Say**: "Let's work on [Project Name]"
3. **Claude outputs** paste-ready markdown
4. **Copy and paste** into your Notion page

The skill maintains the same phase structure and directive UX.

## Multiple Projects

Each project gets its own repository from the template. This keeps:
- State isolated per project
- Git history clean
- Easy archiving when complete

To start another project, simply create a new repository from the template.

## Troubleshooting

### "Page not found" in Claude Code

1. Verify the page ID in `status.json`
2. Check Notion MCP server is configured
3. Run: `mcp__notion__notion-fetch(id="YOUR_PAGE_ID")`

### Slash commands not working

1. Ensure `.claude/commands/` exists
2. Restart Claude Code
3. Commands should appear with `/` prefix

### Setup script fails

1. Ensure you have write permissions
2. Check git remote is configured
3. Run manually: `cat notion-template/design-doc.md` to get template content

## Resetting a Project

To start over:

```bash
# Reset status.json to Phase 0/1
cat > status.json << 'EOF'
{
  "project": "Your Project",
  "slug": "your-project",
  "notion": {
    "designDoc": {
      "id": "YOUR_PAGE_ID",
      "url": "https://www.notion.so/YOUR_PAGE_ID"
    },
    "quickCapture": {
      "id": "",
      "url": "",
      "type": "database"
    },
    "claudeScratch": {
      "id": "",
      "url": ""
    },
    "systemCanvas": {
      "id": "",
      "url": ""
    }
  },
  "framework": "project-incubator",
  "currentPhase": 1,
  "phaseName": "capture",
  "status": "initialized",
  "phases": {
    "0-braindump": { "status": "pending", "optional": true },
    "1-capture": { "status": "in_progress" },
    "2-expand": { "status": "pending" },
    "3-specify": { "status": "pending" },
    "4-architect": { "status": "pending" },
    "5-configure": { "status": "pending" },
    "6-seed": { "status": "pending" }
  },
  "created": "YYYY-MM-DDTHH:MM:SSZ",
  "lastSession": null
}
EOF

# Clear the Notion page and paste template fresh
```

## Next Steps

After setup, run `/whats-next` to get your first directive action. The system will guide you through each phase.
