#!/bin/bash
# Hatchery MCP Server Installation Script
# Installs the MCP server and Claude Code skill

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$HOME/.claude/skills/hatchery"

echo "=== Hatchery MCP Server Installation ==="
echo

# 1. Install Python dependencies
echo "Installing Python dependencies..."
pip install -e "$SCRIPT_DIR" --quiet
echo "  Done."

# 2. Install skill
echo "Installing Claude Code skill..."
mkdir -p "$SKILL_DIR"
cp "$SCRIPT_DIR/../skill-template/hatchery/SKILL.md" "$SKILL_DIR/"
echo "  Installed to $SKILL_DIR"

# 3. Create .env if not exists
if [ ! -f "$SCRIPT_DIR/.env" ]; then
    echo "Creating .env from template..."
    cp "$SCRIPT_DIR/.env.example" "$SCRIPT_DIR/.env"
    echo "  Edit $SCRIPT_DIR/.env to configure Notion (optional)"
fi

# 4. Initialize state directory
mkdir -p "$SCRIPT_DIR/state"

# 5. Show MCP config instructions
echo
echo "=== Add to Claude Code MCP Config ==="
echo
echo "Add this to ~/.claude/settings.json or project .mcp.json:"
echo
cat << EOF
{
  "mcpServers": {
    "hatchery": {
      "command": "python",
      "args": ["-m", "src.server"],
      "cwd": "$SCRIPT_DIR"
    }
  }
}
EOF
echo
echo "=== Installation Complete ==="
echo
echo "Start using Hatchery:"
echo '  - Say "list projects" to see projects'
echo '  - Say "create project [name]" to start a new one'
echo '  - Say "status" to check current state'
echo
