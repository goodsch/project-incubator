#!/bin/bash
#
# Project Incubator - Setup Verification
# Checks that all components are correctly installed and working
#

set -e

echo ""
echo "🔍 Project Incubator Setup Verification"
echo "========================================"
echo ""

ERRORS=0
WARNINGS=0

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

pass() {
    echo -e "  ${GREEN}✓${NC} $1"
}

fail() {
    echo -e "  ${RED}✗${NC} $1"
    ((ERRORS++))
}

warn() {
    echo -e "  ${YELLOW}⚠${NC} $1"
    ((WARNINGS++))
}

info() {
    echo -e "  ℹ $1"
}

# ============================================
echo "1. Checking Skill Installation"
echo "------------------------------"

# Check for any incubator skills
SKILL_COUNT=$(ls -d ~/.claude/skills/incubator-* 2>/dev/null | wc -l)

if [ "$SKILL_COUNT" -eq 0 ]; then
    fail "No incubator skills found in ~/.claude/skills/"
    info "Run ./setup.sh to create a project skill"
else
    pass "Found $SKILL_COUNT incubator skill(s)"

    # List each skill
    for skill_dir in ~/.claude/skills/incubator-*/; do
        skill_name=$(basename "$skill_dir")
        echo ""
        echo "   Checking: $skill_name"

        # Check SKILL.md exists
        if [ -f "$skill_dir/SKILL.md" ]; then
            pass "SKILL.md exists"

            # Check for placeholders (shouldn't have any)
            if grep -q "{{PROJECT_NAME}}" "$skill_dir/SKILL.md" 2>/dev/null; then
                fail "SKILL.md contains unresolved {{PROJECT_NAME}} placeholder"
            else
                pass "No unresolved placeholders in SKILL.md"
            fi

            # Extract project config
            PAGE_ID=$(awk '
                $1 == "design_doc:" { in_doc = 1; next }
                in_doc && $1 == "id:" {
                    gsub(/"/, "", $2);
                    print $2;
                    exit
                }
            ' "$skill_dir/SKILL.md" 2>/dev/null)
            if [ -z "$PAGE_ID" ]; then
                PAGE_ID=$(grep -A1 "project_page_id:" "$skill_dir/SKILL.md" 2>/dev/null | tail -1 | tr -d ' "' | cut -d':' -f2)
            fi
            if [ -n "$PAGE_ID" ] && [ "$PAGE_ID" != "" ]; then
                pass "Page ID configured: ${PAGE_ID:0:8}..."
            else
                fail "No page ID found in SKILL.md"
            fi
        else
            fail "SKILL.md not found"
        fi

        # Check voice-patterns.md exists
        if [ -f "$skill_dir/voice-patterns.md" ]; then
            pass "voice-patterns.md exists"
        else
            warn "voice-patterns.md not found (optional)"
        fi
    done
fi

# ============================================
echo ""
echo "2. Checking MCP Configuration"
echo "------------------------------"

# Check for .mcp.json in common locations
MCP_FOUND=0

if [ -f ".mcp.json" ]; then
    pass "Local .mcp.json found"
    MCP_FOUND=1

    # Check for Notion MCP
    if grep -q "notion" ".mcp.json" 2>/dev/null; then
        pass "Notion MCP configured in local .mcp.json"
    else
        warn "Notion MCP not found in local .mcp.json"
    fi
fi

if [ -f ~/.claude/settings.json ]; then
    if grep -q "notion" ~/.claude/settings.json 2>/dev/null; then
        pass "Notion MCP found in global Claude settings"
        MCP_FOUND=1
    fi
fi

if [ $MCP_FOUND -eq 0 ]; then
    fail "No MCP configuration found for Notion"
    info "Add Notion MCP to .mcp.json or ~/.claude/settings.json"
fi

# ============================================
echo ""
echo "3. Checking Template Files"
echo "--------------------------"

# Check template structure
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR"

if [ -d "$TEMPLATE_DIR" ]; then
    pass "Template directory exists"

    # Required files
    for file in "README.md" "CLAUDE.md.template" "setup.sh" ".gitignore" ".env.example"; do
        if [ -f "$TEMPLATE_DIR/$file" ]; then
            pass "$file exists"
        else
            fail "$file missing"
        fi
    done

    # Required directories
    for dir in "docs" "notion-template" "skill-template"; do
        if [ -d "$TEMPLATE_DIR/$dir" ]; then
            pass "$dir/ directory exists"
        else
            fail "$dir/ directory missing"
        fi
    done

    # Skill template files
    if [ -f "$TEMPLATE_DIR/skill-template/SKILL.md.template" ]; then
        pass "skill-template/SKILL.md.template exists"
    else
        fail "skill-template/SKILL.md.template missing"
    fi

    if [ -f "$TEMPLATE_DIR/skill-template/voice-patterns.md.template" ]; then
        pass "skill-template/voice-patterns.md.template exists"
    else
        fail "skill-template/voice-patterns.md.template missing"
    fi

    # Notion template
    if [ -f "$TEMPLATE_DIR/notion-template/design-doc.md" ]; then
        pass "notion-template/design-doc.md exists"
    else
        fail "notion-template/design-doc.md missing"
    fi
else
    fail "Template directory not found at $TEMPLATE_DIR"
fi

# ============================================
echo ""
echo "4. Checking Claude Code CLI"
echo "---------------------------"

if command -v claude &> /dev/null; then
    pass "Claude Code CLI installed"
    CLAUDE_VERSION=$(claude --version 2>/dev/null || echo "unknown")
    info "Version: $CLAUDE_VERSION"
else
    fail "Claude Code CLI not found"
    info "Install from: https://docs.anthropic.com/claude-code"
fi

# ============================================
echo ""
echo "========================================"
echo "Summary"
echo "========================================"

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}All checks passed!${NC}"
    echo ""
    echo "Next: Test the Notion integration with Claude Code:"
    echo "  1. Open Claude Code: claude"
    echo "  2. Say: 'Search for Signal Garden in Notion'"
    echo "  3. If found, say: 'Fetch the Signal Garden Design Doc'"
    echo ""
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}Passed with $WARNINGS warning(s)${NC}"
    echo ""
else
    echo -e "${RED}Failed with $ERRORS error(s) and $WARNINGS warning(s)${NC}"
    echo ""
    echo "Fix the errors above and run this script again."
fi

exit $ERRORS
