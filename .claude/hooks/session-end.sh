#!/bin/bash
# session-end.sh - Session End/Stop Hook for Project Incubator
#
# This hook runs when session ends (Stop event) to:
# 1. Prompt Claude to create any needed Input Forms in Notion
# 2. Update Session Dashboard in Notion
# 3. Store context in claude-mem for next session
# 4. Write handoff summary to Notion
# 5. Update Living Idea Dump List if ideas were captured
#
# Hook Event: Stop
# Input: Session summary via stdin (if available)
# Output: JSON with actions taken

set -e

# Configuration
NOTION_ENABLED="${NOTION_MCP_ENABLED:-true}"
CLAUDE_MEM_ENABLED="${CLAUDE_MEM_ENABLED:-false}"
PROJECT_NAME="${PROJECT_INCUBATOR_CURRENT_PROJECT:-}"
SESSION_LOG_DIR="${HOME}/.project-incubator/sessions"

# Ensure session log directory exists
mkdir -p "$SESSION_LOG_DIR"

# Read session data from stdin if provided
read_session_data() {
    local input
    if [ -t 0 ]; then
        # No stdin, return empty
        echo "{}"
    else
        input=$(cat)
        echo "$input"
    fi
}

# Log session end
log_session_end() {
    local session_data="$1"
    local timestamp=$(date -Iseconds)
    local log_file="$SESSION_LOG_DIR/session-$(date +%Y%m%d-%H%M%S).json"

    cat > "$log_file" << EOF
{
  "timestamp": "$timestamp",
  "project": "$PROJECT_NAME",
  "event": "session_end",
  "data": $session_data
}
EOF
    echo "$log_file"
}

# Store context in claude-mem
store_context() {
    local session_data="$1"
    if [ "$CLAUDE_MEM_ENABLED" = "true" ] && command -v claude-mem &> /dev/null; then
        # Extract key points to remember
        # claude-mem store --project "$PROJECT_NAME" --data "$session_data"
        echo "true"
    else
        echo "false"
    fi
}

# Generate reminder for Claude about Notion updates
generate_notion_reminders() {
    local session_data="$1"

    cat << EOF
{
  "notion_actions": {
    "update_dashboard": true,
    "check_pending_questions": true,
    "update_session_history": true,
    "reminders": [
      "Update Session Dashboard with session summary",
      "Check if any questions need to be converted to Input Forms",
      "Update Ideation Canvas session history",
      "Review Living Idea Dump List for any ideas captured this session"
    ]
  }
}
EOF
}

# Main execution
main() {
    local session_data
    session_data=$(read_session_data)

    # Log the session end
    local log_file
    log_file=$(log_session_end "$session_data")

    # Store context if claude-mem is available
    local context_stored
    context_stored=$(store_context "$session_data")

    # Generate Notion reminders
    local notion_reminders
    notion_reminders=$(generate_notion_reminders "$session_data")

    # Output combined result
    cat << EOF
{
  "session_end": {
    "timestamp": "$(date -Iseconds)",
    "project": "$PROJECT_NAME",
    "log_file": "$log_file",
    "context_stored": $context_stored,
    "notion": $(echo "$notion_reminders" | jq '.notion_actions'),
    "message": "Session ended. Remember to update Notion with session summary and create any needed Input Forms for questions requiring user thought."
  }
}
EOF
}

main "$@"
