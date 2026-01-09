#!/bin/bash
#
# Project Incubator Setup
# Transforms this template into a project-specific planning workspace
#
# Features:
# - Auto-detects project name from git repo
# - Auto-creates Notion Design Doc via Claude CLI
# - Creates voice skill (+ ZIP for web upload)
# - Installs slash commands for phase workflow
# - Sets up braindump folder for materials
# - Creates status.json for progress tracking
#

set -e

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

manual_notion_setup() {
    echo -e "${CYAN}Manual setup:${NC}"
    echo "   1. Create a page titled '$PROJECT_NAME - Design Doc'"
    echo "   2. Copy contents from notion-template/design-doc.md"
    echo "   3. Replace {{PROJECT_NAME}} with '$PROJECT_NAME'"
    echo "   4. Replace {{DATE}} with '$TODAY'"
    echo ""
    read -p "Press Enter when the Notion page is created..."
    echo ""
    echo "Enter the Notion page ID."
    echo "(Find it in the URL: notion.so/Page-Title-XXXXXXXX)"
    read -p "Page ID: " PAGE_ID

    if [ -z "$PAGE_ID" ]; then
        echo -e "${RED}❌ Page ID is required${NC}"
        exit 1
    fi
}

echo ""
echo "🌱 Project Incubator Setup"
echo "=========================="
echo ""

# Check for Claude CLI
if ! command -v claude &> /dev/null; then
    echo -e "${RED}❌ Claude CLI not found${NC}"
    echo "   Install from: https://docs.anthropic.com/claude-code"
    exit 1
fi

# Check for jq (needed for JSON escaping)
if ! command -v jq &> /dev/null; then
    echo -e "${RED}❌ jq not found${NC}"
    echo "   Install with: sudo apt install jq (Ubuntu) or brew install jq (Mac)"
    exit 1
fi

# Check if already set up
if [ -f "CLAUDE.md" ] && [ ! -f "CLAUDE.md.template" ]; then
    echo -e "${YELLOW}⚠️  This workspace appears to already be set up.${NC}"
    echo "   CLAUDE.md exists and CLAUDE.md.template is gone."
    read -p "   Continue anyway? (y/N): " CONTINUE
    if [ "$CONTINUE" != "y" ] && [ "$CONTINUE" != "Y" ]; then
        echo "Exiting."
        exit 0
    fi
fi

# ============================================
# STEP 1: Project Name
# ============================================
echo -e "${BLUE}Step 1: Project Name${NC}"
echo "--------------------"

# Try to detect from git remote
DETECTED_NAME=""
if git remote get-url origin &>/dev/null; then
    REPO_URL=$(git remote get-url origin)
    DETECTED_NAME=$(basename "$REPO_URL" .git | sed 's/-/ /g' | sed 's/_/ /g')
    # Title case
    DETECTED_NAME=$(echo "$DETECTED_NAME" | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1')
fi

if [ -n "$DETECTED_NAME" ]; then
    echo "   Detected from git: $DETECTED_NAME"
    read -p "   Use this name? (Y/n): " USE_DETECTED
    if [ "$USE_DETECTED" != "n" ] && [ "$USE_DETECTED" != "N" ]; then
        PROJECT_NAME="$DETECTED_NAME"
    fi
fi

if [ -z "$PROJECT_NAME" ]; then
    read -p "Enter your project name (e.g., 'Signal Garden'): " PROJECT_NAME
fi

if [ -z "$PROJECT_NAME" ]; then
    echo -e "${RED}❌ Project name is required${NC}"
    exit 1
fi

# Generate slug (lowercase, spaces to dashes)
PROJECT_SLUG=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')
echo -e "   ${GREEN}✓${NC} Project: $PROJECT_NAME"
echo "   Slug: $PROJECT_SLUG"
echo ""

# ============================================
# STEP 2: Create Notion Page via API
# ============================================
echo -e "${BLUE}Step 2: Creating Notion Design Doc${NC}"
echo "-----------------------------------"
echo ""

TODAY=$(date +%Y-%m-%d)

# Check for Notion API token
NOTION_TOKEN="${NOTION_API_KEY:-}"

# Try to load from .env if not set
if [ -z "$NOTION_TOKEN" ] && [ -f "$HOME/.notion-token" ]; then
    NOTION_TOKEN=$(cat "$HOME/.notion-token")
fi

if [ -z "$NOTION_TOKEN" ]; then
    echo -e "${YELLOW}No Notion API token found.${NC}"
    echo ""
    echo "To enable auto-creation, set up a Notion integration:"
    echo "   1. Go to https://www.notion.so/my-integrations"
    echo "   2. Create a new integration (Internal)"
    echo "   3. Copy the API token"
    echo "   4. Save it: echo 'your-token' > ~/.notion-token"
    echo ""
    echo "Or set NOTION_API_KEY environment variable."
    echo ""

    # Fall back to manual
    manual_notion_setup
else
    PARENT_PAGE_ID="${NOTION_HUB_PAGE_ID:-}"
    if [ -z "$PARENT_PAGE_ID" ]; then
        echo -e "${YELLOW}No NOTION_HUB_PAGE_ID set.${NC}"
        echo "Set NOTION_HUB_PAGE_ID to auto-create the Design Doc under a parent page."
        echo ""
        manual_notion_setup
    else
        # Default hub page - set yours here or override with NOTION_HUB_PAGE_ID env var
        PARENT_PAGE_ID_CLEAN=$(echo "$PARENT_PAGE_ID" | tr -d '-')

        echo -e "${CYAN}   Creating page via Notion API...${NC}"

        # Build the API request with blocks for the template
        API_RESPONSE=$(curl -s -X POST "https://api.notion.com/v1/pages" \
            -H "Authorization: Bearer $NOTION_TOKEN" \
            -H "Content-Type: application/json" \
            -H "Notion-Version: 2022-06-28" \
            -d @- << PAYLOAD
{
  "parent": {"type": "page_id", "page_id": "$PARENT_PAGE_ID_CLEAN"},
  "properties": {
    "title": {
      "title": [{"type": "text", "text": {"content": "$PROJECT_NAME - Design Doc"}}]
    }
  },
  "children": [
    {"object": "block", "type": "heading_1", "heading_1": {"rich_text": [{"type": "text", "text": {"content": "🎯 PROJECT SNAPSHOT"}}]}},
    {"object": "block", "type": "paragraph", "paragraph": {"rich_text": [{"type": "text", "text": {"content": "Status: Ideating | Phase: 0 - BRAINDUMP | Last touched: $TODAY"}}]}},
    {"object": "block", "type": "paragraph", "paragraph": {"rich_text": [{"type": "text", "text": {"content": "Next action: Add materials to braindump/ or skip to Phase 1"}}]}},
    {"object": "block", "type": "divider", "divider": {}},
    {"object": "block", "type": "heading_1", "heading_1": {"rich_text": [{"type": "text", "text": {"content": "💡 THE IDEA"}}]}},
    {"object": "block", "type": "paragraph", "paragraph": {"rich_text": [{"type": "text", "text": {"content": "One-liner: [Not yet defined - complete in Phase 1]"}}]}},
    {"object": "block", "type": "paragraph", "paragraph": {"rich_text": [{"type": "text", "text": {"content": "The spark: [What triggered this idea?]"}}]}},
    {"object": "block", "type": "paragraph", "paragraph": {"rich_text": [{"type": "text", "text": {"content": "Core insight: [The non-obvious thing that makes this work]"}}]}},
    {"object": "block", "type": "divider", "divider": {}},
    {"object": "block", "type": "heading_1", "heading_1": {"rich_text": [{"type": "text", "text": {"content": "🏗️ SYSTEM OVERVIEW"}}]}},
    {"object": "block", "type": "paragraph", "paragraph": {"rich_text": [{"type": "text", "text": {"content": "Purpose: [What problem does this solve? For whom?]"}}]}},
    {"object": "block", "type": "paragraph", "paragraph": {"rich_text": [{"type": "text", "text": {"content": "Scope IN: [What's included] | OUT: [What's explicitly NOT part of this]"}}]}},
    {"object": "block", "type": "divider", "divider": {}},
    {"object": "block", "type": "heading_1", "heading_1": {"rich_text": [{"type": "text", "text": {"content": "🧩 COMPONENTS"}}]}},
    {"object": "block", "type": "paragraph", "paragraph": {"rich_text": [{"type": "text", "text": {"content": "[Components will be added during Phase 2-3]"}}]}},
    {"object": "block", "type": "divider", "divider": {}},
    {"object": "block", "type": "heading_1", "heading_1": {"rich_text": [{"type": "text", "text": {"content": "❓ OPEN QUESTIONS"}}]}},
    {"object": "block", "type": "to_do", "to_do": {"rich_text": [{"type": "text", "text": {"content": "What's the MVP scope?"}}], "checked": false}},
    {"object": "block", "type": "to_do", "to_do": {"rich_text": [{"type": "text", "text": {"content": "Who's the primary user persona?"}}], "checked": false}},
    {"object": "block", "type": "to_do", "to_do": {"rich_text": [{"type": "text", "text": {"content": "What's the key differentiator?"}}], "checked": false}},
    {"object": "block", "type": "divider", "divider": {}},
    {"object": "block", "type": "heading_1", "heading_1": {"rich_text": [{"type": "text", "text": {"content": "📜 SESSION LOG"}}]}},
    {"object": "block", "type": "paragraph", "paragraph": {"rich_text": [{"type": "text", "text": {"content": "$TODAY - Page created with Design Doc template"}}]}}
  ]
}
PAYLOAD
    )

        # Parse the response
        PAGE_ID=$(echo "$API_RESPONSE" | jq -r '.id // empty')

        if [ -z "$PAGE_ID" ] || [ "$PAGE_ID" = "null" ]; then
            ERROR_MSG=$(echo "$API_RESPONSE" | jq -r '.message // .code // "Unknown error"')
            echo -e "${RED}❌ Failed to create Notion page${NC}"
            echo "   Error: $ERROR_MSG"
            echo ""

            # Fall back to manual
            manual_notion_setup
        fi
    fi
fi

PAGE_ID_CLEAN=$(echo "$PAGE_ID" | tr -d '-')
PAGE_URL="https://www.notion.so/${PAGE_ID_CLEAN}"

echo -e "   ${GREEN}✓${NC} Created: $PROJECT_NAME - Design Doc"
echo -e "   ${GREEN}✓${NC} Page ID: ${PAGE_ID_CLEAN:0:8}..."
echo "   URL: $PAGE_URL"
echo ""

# ============================================
# STEP 2b: Create Quick Capture Database
# ============================================
# Using a database (not a page) enables:
# - iOS Shortcuts integration ("Create Document Without Opening")
# - Siri voice capture ("Hey Siri, capture idea")
# - Structured properties (type, processed status)
# - Easy filtering of unprocessed items

CAPTURE_DB_ID=""
CAPTURE_DB_URL=""

if [ -n "$NOTION_TOKEN" ]; then
    echo -e "${CYAN}   Creating Quick Capture database...${NC}"

    CAPTURE_RESPONSE=$(curl -s -X POST "https://api.notion.com/v1/databases" \
        -H "Authorization: Bearer $NOTION_TOKEN" \
        -H "Content-Type: application/json" \
        -H "Notion-Version: 2022-06-28" \
        -d @- << PAYLOAD
{
  "parent": {"type": "page_id", "page_id": "$PAGE_ID"},
  "title": [{"type": "text", "text": {"content": "📥 Quick Capture"}}],
  "description": [{"type": "text", "text": {"content": "Inbox for ideas captured on the go. Use iOS Shortcuts or Notion mobile to add items. Claude reviews unprocessed items at session start."}}],
  "is_inline": true,
  "properties": {
    "Capture": {
      "title": {}
    },
    "Type": {
      "select": {
        "options": [
          {"name": "💡 Idea", "color": "yellow"},
          {"name": "🐛 Issue", "color": "red"},
          {"name": "✨ Feature", "color": "blue"},
          {"name": "❓ Question", "color": "purple"},
          {"name": "📝 Note", "color": "gray"}
        ]
      }
    },
    "Processed": {
      "checkbox": {}
    },
    "Created": {
      "created_time": {}
    }
  }
}
PAYLOAD
    )

    CAPTURE_DB_ID=$(echo "$CAPTURE_RESPONSE" | jq -r '.id // empty')
    if [ -n "$CAPTURE_DB_ID" ] && [ "$CAPTURE_DB_ID" != "null" ]; then
        CAPTURE_DB_ID_CLEAN=$(echo "$CAPTURE_DB_ID" | tr -d '-')
        CAPTURE_DB_URL="https://www.notion.so/${CAPTURE_DB_ID_CLEAN}"
        echo -e "   ${GREEN}✓${NC} Created: Quick Capture (database)"
        echo -e "   ${CYAN}ℹ️${NC}  Set up iOS Shortcut: Settings → Shortcuts → Notion → 'Create Document Without Opening'"
    else
        ERROR_MSG=$(echo "$CAPTURE_RESPONSE" | jq -r '.message // "Unknown error"')
        echo -e "   ${YELLOW}⚠️${NC} Could not create Quick Capture database: $ERROR_MSG"
    fi
fi

# ============================================
# STEP 2c: Create Claude Scratch Page
# ============================================
SCRATCH_PAGE_ID=""
SCRATCH_PAGE_URL=""

if [ -n "$NOTION_TOKEN" ]; then
    echo -e "${CYAN}   Creating Claude Scratch page...${NC}"

    SCRATCH_RESPONSE=$(curl -s -X POST "https://api.notion.com/v1/pages" \
        -H "Authorization: Bearer $NOTION_TOKEN" \
        -H "Content-Type: application/json" \
        -H "Notion-Version: 2022-06-28" \
        -d @- << PAYLOAD
{
  "parent": {"type": "page_id", "page_id": "$PAGE_ID"},
  "properties": {
    "title": {
      "title": [{"type": "text", "text": {"content": "🤖 Claude Scratch"}}]
    }
  },
  "children": [
    {"object": "block", "type": "callout", "callout": {"rich_text": [{"type": "text", "text": {"content": "Claude's working memory - notes, thinking, context that persists between sessions."}}], "icon": {"type": "emoji", "emoji": "🧠"}}},
    {"object": "block", "type": "heading_2", "heading_2": {"rich_text": [{"type": "text", "text": {"content": "Current Focus"}}]}},
    {"object": "block", "type": "paragraph", "paragraph": {"rich_text": [{"type": "text", "text": {"content": "[What Claude is currently working through]"}}]}},
    {"object": "block", "type": "heading_2", "heading_2": {"rich_text": [{"type": "text", "text": {"content": "Open Threads"}}]}},
    {"object": "block", "type": "paragraph", "paragraph": {"rich_text": [{"type": "text", "text": {"content": "[Things to pick up next session]"}}]}},
    {"object": "block", "type": "heading_2", "heading_2": {"rich_text": [{"type": "text", "text": {"content": "Insights & Patterns"}}]}},
    {"object": "block", "type": "paragraph", "paragraph": {"rich_text": [{"type": "text", "text": {"content": "[Observations about the project]"}}]}},
    {"object": "block", "type": "heading_2", "heading_2": {"rich_text": [{"type": "text", "text": {"content": "Session Notes"}}]}},
    {"object": "block", "type": "paragraph", "paragraph": {"rich_text": [{"type": "text", "text": {"content": "$TODAY - Workspace initialized"}}]}}
  ]
}
PAYLOAD
    )

    SCRATCH_PAGE_ID=$(echo "$SCRATCH_RESPONSE" | jq -r '.id // empty')
    if [ -n "$SCRATCH_PAGE_ID" ] && [ "$SCRATCH_PAGE_ID" != "null" ]; then
        SCRATCH_PAGE_ID_CLEAN=$(echo "$SCRATCH_PAGE_ID" | tr -d '-')
        SCRATCH_PAGE_URL="https://www.notion.so/${SCRATCH_PAGE_ID_CLEAN}"
        echo -e "   ${GREEN}✓${NC} Created: Claude Scratch"
    else
        echo -e "   ${YELLOW}⚠️${NC} Could not create Claude Scratch page"
    fi
fi

# ============================================
# STEP 2d: Create System Canvas Page
# ============================================
# Visual companion to the Design Doc - diagrams, flows, spatial thinking
CANVAS_PAGE_ID=""
CANVAS_PAGE_URL=""

if [ -n "$NOTION_TOKEN" ]; then
    echo -e "${CYAN}   Creating System Canvas page...${NC}"

    CANVAS_RESPONSE=$(curl -s -X POST "https://api.notion.com/v1/pages" \
        -H "Authorization: Bearer $NOTION_TOKEN" \
        -H "Content-Type: application/json" \
        -H "Notion-Version: 2022-06-28" \
        -d @- << PAYLOAD
{
  "parent": {"type": "page_id", "page_id": "$PAGE_ID"},
  "properties": {
    "title": {
      "title": [{"type": "text", "text": {"content": "🗺️ System Canvas"}}]
    }
  },
  "children": [
    {"object": "block", "type": "callout", "callout": {"rich_text": [{"type": "text", "text": {"content": "Visual companion to Design Doc - diagrams, flows, spatial thinking. Less text, more pictures."}}], "icon": {"type": "emoji", "emoji": "🎨"}}},
    {"object": "block", "type": "heading_1", "heading_1": {"rich_text": [{"type": "text", "text": {"content": "🎬 THE SCENARIO"}}]}},
    {"object": "block", "type": "paragraph", "paragraph": {"rich_text": [{"type": "text", "text": {"content": "Walk through using this: Who does what → System responds → Result"}}]}},
    {"object": "block", "type": "divider", "divider": {}},
    {"object": "block", "type": "heading_1", "heading_1": {"rich_text": [{"type": "text", "text": {"content": "🗺️ SYSTEM MAP"}}]}},
    {"object": "block", "type": "paragraph", "paragraph": {"rich_text": [{"type": "text", "text": {"content": "[Add Mermaid diagram: graph TD showing major components]"}}]}},
    {"object": "block", "type": "divider", "divider": {}},
    {"object": "block", "type": "heading_1", "heading_1": {"rich_text": [{"type": "text", "text": {"content": "🔄 DATA FLOW"}}]}},
    {"object": "block", "type": "paragraph", "paragraph": {"rich_text": [{"type": "text", "text": {"content": "[Add Mermaid diagram: flowchart LR showing data movement]"}}]}},
    {"object": "block", "type": "divider", "divider": {}},
    {"object": "block", "type": "heading_1", "heading_1": {"rich_text": [{"type": "text", "text": {"content": "🎭 KEY INTERACTIONS"}}]}},
    {"object": "block", "type": "paragraph", "paragraph": {"rich_text": [{"type": "text", "text": {"content": "[Add Mermaid diagram: sequenceDiagram showing user ↔ system]"}}]}}
  ]
}
PAYLOAD
    )

    CANVAS_PAGE_ID=$(echo "$CANVAS_RESPONSE" | jq -r '.id // empty')
    if [ -n "$CANVAS_PAGE_ID" ] && [ "$CANVAS_PAGE_ID" != "null" ]; then
        CANVAS_PAGE_ID_CLEAN=$(echo "$CANVAS_PAGE_ID" | tr -d '-')
        CANVAS_PAGE_URL="https://www.notion.so/${CANVAS_PAGE_ID_CLEAN}"
        echo -e "   ${GREEN}✓${NC} Created: System Canvas"
    else
        echo -e "   ${YELLOW}⚠️${NC} Could not create System Canvas page"
    fi
fi
echo ""

# ============================================
# STEP 3: Create Local Structure
# ============================================
echo -e "${BLUE}Step 3: Creating Local Structure${NC}"
echo "---------------------------------"

# Create braindump directory
mkdir -p braindump/source-materials
touch braindump/.gitkeep
touch braindump/source-materials/.gitkeep

cat > braindump/README.md << 'EOF'
# Braindump

This folder is for raw materials BEFORE Phase 0 processing.

## What Goes Here

Add any accumulated materials you want processed:

- **AI conversation exports** - ChatGPT, Claude, etc.
- **Voice memo transcriptions**
- **Notes and ideas** - text files, markdown
- **Reference projects** - links, descriptions
- **Screenshots with ideas**
- **"Someday" notes** - things you've been saving

## Structure

```
braindump/
├── source-materials/    # Put your files here
├── extracted-insights.md    # (Generated by Phase 0)
└── dream-synthesis.md       # (Generated by Phase 0)
```

## Processing

When ready, tell Claude: "Process my braindump materials"

This triggers Phase 0:
1. **Meta-Analysis** - Extract explicit and implicit ideas
2. **Dream Phase** - AI creative synthesis

After processing, you'll have structured insights ready for Phase 1 (CAPTURE).

## Skip If

- Fresh idea with no accumulated materials
- Prefer to start with raw capture first
- Just say "skip braindump" or "start with capture"
EOF

echo -e "   ${GREEN}✓${NC} Created: braindump/"

# Create spec directory
mkdir -p spec
touch spec/.gitkeep
echo -e "   ${GREEN}✓${NC} Created: spec/"

# Create status.json
TIMESTAMP=$(date -Iseconds)

cat > status.json << EOF
{
  "project": "$PROJECT_NAME",
  "slug": "$PROJECT_SLUG",
  "notion": {
    "designDoc": {
      "id": "$PAGE_ID_CLEAN",
      "url": "$PAGE_URL"
    },
    "quickCapture": {
      "id": "${CAPTURE_DB_ID_CLEAN:-}",
      "url": "${CAPTURE_DB_URL:-}",
      "type": "database"
    },
    "claudeScratch": {
      "id": "${SCRATCH_PAGE_ID_CLEAN:-}",
      "url": "${SCRATCH_PAGE_URL:-}"
    },
    "systemCanvas": {
      "id": "${CANVAS_PAGE_ID_CLEAN:-}",
      "url": "${CANVAS_PAGE_URL:-}"
    }
  },
  "framework": "project-incubator",
  "currentPhase": 0,
  "phaseName": "braindump",
  "status": "initialized",
  "phases": {
    "0-braindump": { "status": "pending", "optional": true },
    "1-capture": { "status": "pending" },
    "2-expand": { "status": "pending" },
    "3-specify": { "status": "pending" },
    "4-architect": { "status": "pending" },
    "5-configure": { "status": "pending" },
    "6-seed": { "status": "pending" }
  },
  "created": "$TIMESTAMP",
  "lastSession": "$TIMESTAMP"
}
EOF
echo -e "   ${GREEN}✓${NC} Created: status.json"

# Create CONTEXT.md
cat > CONTEXT.md << EOF
# $PROJECT_NAME

*Created: $TODAY*

## Raw Idea

[Add your initial thoughts here - or process braindump materials first]

## Notes

[Additional context as you work through phases]

---

## Session Notes

### $TODAY - Initialized
- Project workspace created
- Notion Design Doc: $PAGE_URL
- Ready to begin Phase 0 (BRAINDUMP) or Phase 1 (CAPTURE)
EOF
echo -e "   ${GREEN}✓${NC} Created: CONTEXT.md"

echo ""

# ============================================
# STEP 4: Create Skill
# ============================================
echo -e "${BLUE}Step 4: Creating Claude Code Skill${NC}"
echo "-----------------------------------"

SKILL_DIR="$HOME/.claude/skills/incubator-$PROJECT_SLUG"

if [ -d "$SKILL_DIR" ]; then
    echo -e "${YELLOW}⚠️  Skill directory already exists: $SKILL_DIR${NC}"
    read -p "   Overwrite? (y/N): " OVERWRITE
    if [ "$OVERWRITE" != "y" ] && [ "$OVERWRITE" != "Y" ]; then
        echo "   Skipping skill creation."
        SKILL_CREATED=0
    else
        rm -rf "$SKILL_DIR"
        SKILL_CREATED=1
    fi
else
    SKILL_CREATED=1
fi

if [ "$SKILL_CREATED" -eq 1 ]; then
    mkdir -p "$SKILL_DIR"

    # Copy and process SKILL.md
    sed -e "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" \
        -e "s/{{PROJECT_SLUG}}/$PROJECT_SLUG/g" \
        -e "s/{{PAGE_ID}}/$PAGE_ID_CLEAN/g" \
        -e "s|{{PAGE_URL}}|$PAGE_URL|g" \
        -e "s/{{CAPTURE_PAGE_ID}}/${CAPTURE_DB_ID_CLEAN:-}/g" \
        -e "s|{{CAPTURE_PAGE_URL}}|${CAPTURE_DB_URL:-}|g" \
        -e "s/{{SCRATCH_PAGE_ID}}/${SCRATCH_PAGE_ID_CLEAN:-}/g" \
        -e "s|{{SCRATCH_PAGE_URL}}|${SCRATCH_PAGE_URL:-}|g" \
        -e "s/{{DATE}}/$TODAY/g" \
        skill-template/SKILL.md.template > "$SKILL_DIR/SKILL.md"

    # Copy and process voice-patterns.md
    sed -e "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" \
        -e "s/{{PROJECT_SLUG}}/$PROJECT_SLUG/g" \
        skill-template/voice-patterns.md.template > "$SKILL_DIR/voice-patterns.md"

    echo -e "   ${GREEN}✓${NC} Created: $SKILL_DIR"
fi
echo ""

# ============================================
# STEP 5: Create Skill ZIP for Web Upload
# ============================================
echo -e "${BLUE}Step 5: Creating Skill ZIP for Web${NC}"
echo "-----------------------------------"

ZIP_DIR="skill-export"
mkdir -p "$ZIP_DIR"

# Copy skill files to export directory
cp "$SKILL_DIR/SKILL.md" "$ZIP_DIR/" 2>/dev/null || true
cp "$SKILL_DIR/voice-patterns.md" "$ZIP_DIR/" 2>/dev/null || true

# Create the ZIP
ZIP_FILE="incubator-$PROJECT_SLUG-skill.zip"
cd "$ZIP_DIR"
zip -q "../$ZIP_FILE" ./*
cd ..
rm -rf "$ZIP_DIR"

echo -e "   ${GREEN}✓${NC} Created: $ZIP_FILE"
echo ""
echo "   To use with Claude App (web/mobile):"
echo "   1. Go to claude.ai → Settings → Skills"
echo "   2. Upload: $ZIP_FILE"
echo ""

# ============================================
# STEP 6: Update CLAUDE.md
# ============================================
echo -e "${BLUE}Step 6: Configuring Workspace${NC}"
echo "------------------------------"

sed -e "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" \
    -e "s/{{PROJECT_SLUG}}/$PROJECT_SLUG/g" \
    -e "s/{{PAGE_ID}}/$PAGE_ID_CLEAN/g" \
    -e "s|{{PAGE_URL}}|$PAGE_URL|g" \
    -e "s|{{CAPTURE_PAGE_URL}}|${CAPTURE_DB_URL:-[not created]}|g" \
    -e "s|{{SCRATCH_PAGE_URL}}|${SCRATCH_PAGE_URL:-[not created]}|g" \
    -e "s/{{DATE}}/$TODAY/g" \
    CLAUDE.md.template > CLAUDE.md

echo -e "   ${GREEN}✓${NC} Created: CLAUDE.md"

# ============================================
# STEP 7: Update README.md
# ============================================
echo ""
echo -e "${BLUE}Step 7: Updating README${NC}"
echo "-----------------------"

cat > README.md << EOF
# $PROJECT_NAME - Planning Workspace

This is a **Project Incubator** workspace for planning **$PROJECT_NAME**.

## Quick Start

Open Claude Code in this directory:

\`\`\`bash
claude
\`\`\`

Then say:

\`\`\`
"Let's work on $PROJECT_NAME"
\`\`\`

Or use slash commands:
- \`/status\` - See current state
- \`/whats-next\` - Get next action (directive)
- \`/advance\` - Move to next phase

## Links

- **Notion Design Doc:** [$PROJECT_NAME - Design Doc]($PAGE_URL)
- **Voice Skill:** \`~/.claude/skills/incubator-$PROJECT_SLUG/\`
- **Skill ZIP:** \`$ZIP_FILE\` (for Claude web/mobile)

## Project Phases

| Phase | Name | Purpose |
|-------|------|---------|
| 0 | BRAINDUMP | Process accumulated materials (optional) |
| 1 | CAPTURE | Get the core idea out |
| 2 | EXPAND | Explore scope and possibilities |
| 3 | SPECIFY | Create detailed requirements |
| 4 | ARCHITECT | Design system structure |
| 5 | CONFIGURE | Define tech stack and setup |
| 6 | SEED | Generate project scaffold |

## Files

- \`CLAUDE.md\` - Workspace configuration
- \`status.json\` - Progress tracking (machine-readable)
- \`CONTEXT.md\` - Session notes and raw ideas
- \`braindump/\` - Raw materials for Phase 0
- \`spec/\` - Specifications and PRDs
- \`docs/\` - Reference documentation

## Documentation

- \`docs/voice-patterns.md\` - Voice command reference
- \`docs/notion-integration.md\` - Notion MCP tools guide
- \`docs/development-rules.md\` - Design principles

---

*Created with [Project Incubator](https://github.com/goodsch/project-incubator)*
EOF

echo -e "   ${GREEN}✓${NC} Created: README.md"

# ============================================
# STEP 8: Create .env
# ============================================
echo ""
echo -e "${BLUE}Step 8: Creating Environment Config${NC}"
echo "------------------------------------"

cat > .env << EOF
# Project Incubator Configuration
# Generated: $TODAY

PROJECT_NAME="$PROJECT_NAME"
PROJECT_SLUG="$PROJECT_SLUG"
NOTION_DESIGN_DOC_ID="$PAGE_ID_CLEAN"
NOTION_DESIGN_DOC_URL="$PAGE_URL"
NOTION_QUICK_CAPTURE_ID="${CAPTURE_DB_ID_CLEAN:-}"
NOTION_QUICK_CAPTURE_URL="${CAPTURE_DB_URL:-}"
NOTION_QUICK_CAPTURE_TYPE="database"
NOTION_SCRATCH_ID="${SCRATCH_PAGE_ID_CLEAN:-}"
NOTION_SCRATCH_URL="${SCRATCH_PAGE_URL:-}"
SKILL_NAME="incubator-$PROJECT_SLUG"
EOF

echo -e "   ${GREEN}✓${NC} Created: .env"

# ============================================
# STEP 9: Cleanup
# ============================================
echo ""
echo -e "${BLUE}Step 9: Cleanup${NC}"
echo "---------------"
read -p "Remove template files? (Y/n): " CLEANUP

if [ "$CLEANUP" != "n" ] && [ "$CLEANUP" != "N" ]; then
    rm -f CLAUDE.md.template
    rm -f .env.example
    echo -e "   ${GREEN}✓${NC} Removed: CLAUDE.md.template"
else
    echo "   Kept template files for reference"
fi

# ============================================
# DONE
# ============================================
echo ""
echo "========================================"
echo -e "${GREEN}✅ Setup Complete!${NC}"
echo "========================================"
echo ""
echo "Your workspace is ready for: $PROJECT_NAME"
echo ""
echo -e "${BLUE}Files created:${NC}"
echo "  - CLAUDE.md (workspace configuration)"
echo "  - README.md (project readme)"
echo "  - status.json (progress tracking)"
echo "  - CONTEXT.md (session notes)"
echo "  - .env (environment config)"
echo "  - braindump/ (raw materials folder)"
echo "  - spec/ (specifications folder)"
echo "  - ~/.claude/skills/incubator-$PROJECT_SLUG/ (voice skill)"
echo "  - $ZIP_FILE (skill for web upload)"
echo ""
echo -e "${BLUE}Notion Pages:${NC}"
echo "  - Design Doc: $PAGE_URL"
if [ -n "$CAPTURE_DB_URL" ]; then
    echo "  - Quick Capture (database): $CAPTURE_DB_URL"
fi
if [ -n "$SCRATCH_PAGE_URL" ]; then
    echo "  - Claude Scratch: $SCRATCH_PAGE_URL"
fi
if [ -n "$CANVAS_PAGE_URL" ]; then
    echo "  - System Canvas: $CANVAS_PAGE_URL"
fi
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo ""
echo "  1. Open Claude Code:"
echo "     ${GREEN}claude${NC}"
echo ""
echo "  2. Start planning:"
echo "     ${GREEN}/whats-next${NC}"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
