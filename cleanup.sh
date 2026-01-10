#!/bin/bash
#
# Project Incubator Cleanup
# Properly removes a project and all its artifacts
#
# Usage:
#   ./cleanup.sh                    # Run from project directory
#   ./cleanup.sh /path/to/project   # Specify project path
#   ./cleanup.sh --slug my-project  # Clean by slug name only (no local files)
#

set -e

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo ""
echo "🧹 Project Incubator Cleanup"
echo "============================"
echo ""

# Parse arguments
PROJECT_PATH=""
SLUG_ONLY=""

if [ "$1" = "--slug" ]; then
    SLUG_ONLY="$2"
    if [ -z "$SLUG_ONLY" ]; then
        echo -e "${RED}❌ --slug requires a project slug${NC}"
        exit 1
    fi
elif [ -n "$1" ]; then
    PROJECT_PATH="$1"
else
    PROJECT_PATH="$(pwd)"
fi

# If slug-only mode, skip local file checks
if [ -n "$SLUG_ONLY" ]; then
    PROJECT_SLUG="$SLUG_ONLY"
    PROJECT_NAME="$SLUG_ONLY"
    echo -e "${CYAN}Cleaning up by slug: $SLUG_ONLY${NC}"
    echo "(No local files will be touched)"
    echo ""
else
    # Verify this is a Project Incubator workspace
    if [ ! -f "$PROJECT_PATH/status.json" ]; then
        echo -e "${RED}❌ Not a Project Incubator workspace${NC}"
        echo "   No status.json found in: $PROJECT_PATH"
        echo ""
        echo "Usage:"
        echo "   ./cleanup.sh                    # Run from project directory"
        echo "   ./cleanup.sh /path/to/project   # Specify project path"
        echo "   ./cleanup.sh --slug my-project  # Clean by slug only"
        exit 1
    fi

    # Load project info
    PROJECT_NAME=$(jq -r '.project' "$PROJECT_PATH/status.json")
    PROJECT_SLUG=$(jq -r '.slug' "$PROJECT_PATH/status.json")

    echo -e "Project: ${CYAN}$PROJECT_NAME${NC} (slug: $PROJECT_SLUG)"
    echo -e "Path: $PROJECT_PATH"
    echo ""
fi

# Confirm
echo -e "${YELLOW}⚠️  This will remove:${NC}"
echo "   - Notion pages (archive/trash)"
echo "   - Portfolio entry (~/.hatchery/portfolio.json)"
echo "   - Skill directory (~/.claude/skills/incubator-$PROJECT_SLUG/)"
if [ -z "$SLUG_ONLY" ]; then
    echo "   - Local project directory (optional)"
fi
echo ""
read -p "Continue? (y/N): " CONFIRM
if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
    echo "Cancelled."
    exit 0
fi
echo ""

# ============================================
# STEP 1: Archive Notion Pages
# ============================================
echo -e "${BLUE}Step 1: Archiving Notion Pages${NC}"
echo "-------------------------------"

# Get Notion token
NOTION_TOKEN="${NOTION_API_KEY:-}"
if [ -z "$NOTION_TOKEN" ] && [ -f "$HOME/.hatchery/config.json" ]; then
    NOTION_TOKEN=$(jq -r '.notion_api_key // empty' "$HOME/.hatchery/config.json")
fi
if [ -z "$NOTION_TOKEN" ] && [ -f "$HOME/.notion-token" ]; then
    NOTION_TOKEN=$(cat "$HOME/.notion-token")
fi

if [ -z "$NOTION_TOKEN" ]; then
    echo -e "   ${YELLOW}⚠️  No Notion token found - skipping page cleanup${NC}"
    echo "   You'll need to manually delete pages in Notion"
else
    # Get page IDs from status.json or portfolio
    if [ -z "$SLUG_ONLY" ] && [ -f "$PROJECT_PATH/status.json" ]; then
        DESIGN_DOC_ID=$(jq -r '.notion.designDoc.id // empty' "$PROJECT_PATH/status.json")
    else
        # Try to get from portfolio
        DESIGN_DOC_ID=$(jq -r ".projects[\"$PROJECT_SLUG\"].notion_page_id // empty" "$HOME/.hatchery/portfolio.json" 2>/dev/null)
    fi

    if [ -n "$DESIGN_DOC_ID" ] && [ "$DESIGN_DOC_ID" != "null" ]; then
        echo "   Archiving Design Doc: ${DESIGN_DOC_ID:0:8}..."

        RESPONSE=$(curl -s -X PATCH "https://api.notion.com/v1/pages/$DESIGN_DOC_ID" \
            -H "Authorization: Bearer $NOTION_TOKEN" \
            -H "Content-Type: application/json" \
            -H "Notion-Version: 2022-06-28" \
            -d '{"archived": true}')

        if echo "$RESPONSE" | jq -e '.archived == true' > /dev/null 2>&1; then
            echo -e "   ${GREEN}✓${NC} Design Doc archived (child pages included)"
        else
            ERROR=$(echo "$RESPONSE" | jq -r '.message // "Unknown error"')
            echo -e "   ${YELLOW}⚠️${NC} Could not archive: $ERROR"
        fi
    else
        echo -e "   ${YELLOW}⚠️${NC} No Design Doc ID found"
    fi
fi
echo ""

# ============================================
# STEP 2: Remove Portfolio Entry
# ============================================
echo -e "${BLUE}Step 2: Removing Portfolio Entry${NC}"
echo "---------------------------------"

PORTFOLIO_FILE="$HOME/.hatchery/portfolio.json"
if [ -f "$PORTFOLIO_FILE" ]; then
    if jq -e ".projects[\"$PROJECT_SLUG\"]" "$PORTFOLIO_FILE" > /dev/null 2>&1; then
        # Remove the project entry
        jq "del(.projects[\"$PROJECT_SLUG\"])" "$PORTFOLIO_FILE" > "$PORTFOLIO_FILE.tmp"
        mv "$PORTFOLIO_FILE.tmp" "$PORTFOLIO_FILE"
        echo -e "   ${GREEN}✓${NC} Removed from portfolio.json"
    else
        echo -e "   ${YELLOW}⚠️${NC} Project not found in portfolio"
    fi
else
    echo -e "   ${YELLOW}⚠️${NC} No portfolio.json found"
fi
echo ""

# ============================================
# STEP 3: Remove Skill Directory
# ============================================
echo -e "${BLUE}Step 3: Removing Skill Directory${NC}"
echo "---------------------------------"

SKILL_DIR="$HOME/.claude/skills/incubator-$PROJECT_SLUG"
if [ -d "$SKILL_DIR" ]; then
    rm -rf "$SKILL_DIR"
    echo -e "   ${GREEN}✓${NC} Removed: $SKILL_DIR"
else
    echo -e "   ${YELLOW}⚠️${NC} Skill directory not found"
fi
echo ""

# ============================================
# STEP 4: Remove Local Directory (Optional)
# ============================================
if [ -z "$SLUG_ONLY" ]; then
    echo -e "${BLUE}Step 4: Local Project Directory${NC}"
    echo "--------------------------------"
    echo ""
    read -p "Delete local project directory? (y/N): " DELETE_LOCAL

    if [ "$DELETE_LOCAL" = "y" ] || [ "$DELETE_LOCAL" = "Y" ]; then
        # Safety check - don't delete if we're inside it
        CURRENT_DIR="$(pwd)"
        REAL_PROJECT_PATH="$(realpath "$PROJECT_PATH")"

        if [ "$CURRENT_DIR" = "$REAL_PROJECT_PATH" ]; then
            echo -e "   ${YELLOW}⚠️${NC} You're inside the project directory"
            echo "   Please cd out first, then run:"
            echo "   rm -rf \"$PROJECT_PATH\""
        else
            rm -rf "$PROJECT_PATH"
            echo -e "   ${GREEN}✓${NC} Removed: $PROJECT_PATH"
        fi
    else
        echo "   Kept local directory"
    fi
    echo ""
fi

# ============================================
# DONE
# ============================================
echo "========================================"
echo -e "${GREEN}✅ Cleanup Complete${NC}"
echo "========================================"
echo ""
echo "Removed artifacts for: $PROJECT_NAME"
echo ""
echo "Note: Notion pages are archived (in trash)."
echo "They will be permanently deleted after 30 days,"
echo "or you can empty trash manually in Notion."
echo ""
