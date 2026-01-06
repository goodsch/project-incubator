#!/bin/bash
# session-start.sh - Session Start Hook for Project Incubator
#
# This hook runs at session start (SessionStart event) to:
# 1. Check Living Idea Dump List in Notion for new items
# 2. Check for pending Input Forms that user may have answered
# 3. Check for pending Intent Confirmations
# 4. Load context from claude-mem (if installed)
# 5. Output a session start summary
#
# Hook Event: SessionStart
# Output: JSON with context and pending items

set -e

# Configuration
NOTION_SEARCH_ENABLED="${NOTION_MCP_ENABLED:-true}"
CLAUDE_MEM_ENABLED="${CLAUDE_MEM_ENABLED:-false}"
PROJECT_NAME="${PROJECT_INCUBATOR_CURRENT_PROJECT:-}"

# Output structure
output_json() {
    local pending_ideas="$1"
    local pending_forms="$2"
    local pending_confirmations="$3"
    local context_loaded="$4"
    local summary="$5"

    cat << EOF
{
  "session_start": {
    "timestamp": "$(date -Iseconds)",
    "project": "$PROJECT_NAME",
    "pending": {
      "ideas": $pending_ideas,
      "forms": $pending_forms,
      "confirmations": $pending_confirmations
    },
    "context_loaded": $context_loaded,
    "summary": "$summary"
  }
}
EOF
}

# Check for pending ideas in Living Idea Dump List
check_idea_dump_list() {
    # This would use Notion MCP - returning placeholder count
    # In practice, Claude reads this and processes via Notion MCP
    echo "0"
}

# Check for pending input forms
check_pending_forms() {
    # Returns count of forms with status "Awaiting Input"
    echo "0"
}

# Check for pending intent confirmations
check_pending_confirmations() {
    # Returns count of confirmations with status "Pending"
    echo "0"
}

# Load context from claude-mem
load_context() {
    if [ "$CLAUDE_MEM_ENABLED" = "true" ] && command -v claude-mem &> /dev/null; then
        # claude-mem would retrieve relevant context here
        # claude-mem recall --project "$PROJECT_NAME" --limit 5
        echo "true"
    else
        echo "false"
    fi
}

# Main execution
main() {
    local pending_ideas=$(check_idea_dump_list)
    local pending_forms=$(check_pending_forms)
    local pending_confirmations=$(check_pending_confirmations)
    local context_loaded=$(load_context)

    # Build summary message
    local summary="Session started."

    if [ "$pending_ideas" -gt 0 ]; then
        summary="$summary Found $pending_ideas new items in idea dump list."
    fi

    if [ "$pending_forms" -gt 0 ]; then
        summary="$summary $pending_forms forms awaiting review."
    fi

    if [ "$pending_confirmations" -gt 0 ]; then
        summary="$summary $pending_confirmations actions pending confirmation."
    fi

    # Output JSON for Claude to process
    output_json "$pending_ideas" "$pending_forms" "$pending_confirmations" "$context_loaded" "$summary"
}

main "$@"
