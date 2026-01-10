#!/bin/bash
#
# List all Project Incubator projects
#

PORTFOLIO_FILE="$HOME/.hatchery/portfolio.json"

if [ ! -f "$PORTFOLIO_FILE" ]; then
    echo "No projects found (portfolio.json doesn't exist)"
    exit 0
fi

echo ""
echo "📋 Project Incubator Projects"
echo "=============================="
echo ""

# Check if there are any projects
PROJECT_COUNT=$(jq '.projects | length' "$PORTFOLIO_FILE")

if [ "$PROJECT_COUNT" -eq 0 ]; then
    echo "No projects registered."
    exit 0
fi

# List projects
jq -r '.projects | to_entries[] | "• \(.value.name) (\(.key))\n  Path: \(.value.path)\n  Notion: \(.value.notion_page_id // "none")\n  Created: \(.value.created_at | split("T")[0])\n"' "$PORTFOLIO_FILE"

echo "Total: $PROJECT_COUNT project(s)"
echo ""
echo "To clean up a project:"
echo "  ./cleanup.sh /path/to/project"
echo "  ./cleanup.sh --slug project-slug"
echo ""
