#!/bin/bash
# prompt-submit.sh - User Prompt Submit Hook for Project Incubator
#
# This hook runs when user submits a prompt (UserPromptSubmit event) to:
# 1. Analyze prompt complexity and clarity
# 2. Optionally run through claude-code-prompt-improver
# 3. Flag prompts that need intent confirmation
# 4. Detect destructive keywords that require extra confirmation
#
# Hook Event: UserPromptSubmit
# Input: User's prompt via stdin (JSON with prompt field)
# Output: JSON with analysis and recommendations
# Exit codes:
#   0 = proceed normally
#   1 = error
#   2 = block and show message (for confirmation needed)

set -e

# Configuration
PROMPT_IMPROVER_ENABLED="${PROMPT_IMPROVER_ENABLED:-false}"
COMPLEXITY_THRESHOLD="${COMPLEXITY_THRESHOLD:-25}"  # words
REQUIRE_CONFIRMATION_FOR_DESTRUCTIVE="${REQUIRE_CONFIRMATION_FOR_DESTRUCTIVE:-true}"

# Destructive keywords that trigger confirmation
DESTRUCTIVE_KEYWORDS="delete|remove|drop|destroy|overwrite|replace all|reset|wipe|clear all|truncate|rm -rf|force push"

# Read prompt from stdin (Claude Code passes JSON)
read_prompt() {
    local input
    input=$(cat)
    # Extract prompt from JSON if present, otherwise use raw input
    if echo "$input" | jq -e '.prompt' > /dev/null 2>&1; then
        echo "$input" | jq -r '.prompt'
    else
        echo "$input"
    fi
}

# Count words in prompt
count_words() {
    echo "$1" | wc -w | tr -d ' '
}

# Check for destructive keywords
has_destructive_keywords() {
    local prompt="$1"
    if echo "$prompt" | grep -iE "$DESTRUCTIVE_KEYWORDS" > /dev/null 2>&1; then
        return 0
    fi
    return 1
}

# Check for scope indicators (affects many things)
has_broad_scope() {
    local prompt="$1"
    local scope_keywords="all files|entire|everything|whole project|every|across the|throughout"
    if echo "$prompt" | grep -iE "$scope_keywords" > /dev/null 2>&1; then
        return 0
    fi
    return 1
}

# Run prompt improver if available
improve_prompt() {
    local prompt="$1"
    if [ "$PROMPT_IMPROVER_ENABLED" = "true" ] && command -v claude-code-prompt-improver &> /dev/null; then
        # Run prompt improver and capture output
        claude-code-prompt-improver "$prompt" 2>/dev/null || echo "$prompt"
    else
        echo "$prompt"
    fi
}

# Analyze prompt and decide action
analyze_prompt() {
    local prompt="$1"
    local word_count=$(count_words "$prompt")
    local needs_confirmation="false"
    local reason=""
    local improved_prompt=""
    local confidence="high"

    # Check complexity
    if [ "$word_count" -gt "$COMPLEXITY_THRESHOLD" ]; then
        confidence="medium"
        reason="Complex prompt with multiple clauses"
    fi

    # Check for destructive keywords
    if has_destructive_keywords "$prompt"; then
        needs_confirmation="true"
        reason="Potentially destructive action detected"
        confidence="requires_confirmation"
    fi

    # Check for broad scope
    if has_broad_scope "$prompt"; then
        if [ "$needs_confirmation" = "true" ]; then
            reason="$reason + broad scope"
        else
            needs_confirmation="true"
            reason="Broad scope affecting multiple items"
        fi
        confidence="requires_confirmation"
    fi

    # Try to improve prompt if enabled
    if [ "$PROMPT_IMPROVER_ENABLED" = "true" ]; then
        improved_prompt=$(improve_prompt "$prompt")
        if [ "$improved_prompt" != "$prompt" ]; then
            needs_confirmation="true"
            reason="Prompt was reformulated for clarity"
        fi
    else
        improved_prompt="$prompt"
    fi

    # Output analysis as JSON
    cat << EOF
{
  "analysis": {
    "original_prompt": $(echo "$prompt" | jq -Rs .),
    "improved_prompt": $(echo "$improved_prompt" | jq -Rs .),
    "word_count": $word_count,
    "needs_confirmation": $needs_confirmation,
    "confidence": "$confidence",
    "reason": "$reason",
    "flags": {
      "destructive": $(has_destructive_keywords "$prompt" && echo "true" || echo "false"),
      "broad_scope": $(has_broad_scope "$prompt" && echo "true" || echo "false"),
      "complex": $([ "$word_count" -gt "$COMPLEXITY_THRESHOLD" ] && echo "true" || echo "false")
    }
  }
}
EOF
}

# Main execution
main() {
    local prompt
    prompt=$(read_prompt)

    if [ -z "$prompt" ]; then
        echo '{"error": "No prompt provided"}' >&2
        exit 1
    fi

    # Analyze the prompt
    local analysis
    analysis=$(analyze_prompt "$prompt")

    # Check if confirmation is needed
    local needs_confirmation
    needs_confirmation=$(echo "$analysis" | jq -r '.analysis.needs_confirmation')

    if [ "$needs_confirmation" = "true" ]; then
        # Output analysis and signal that confirmation is needed
        # Claude will handle creating Notion confirmation or inline confirm
        echo "$analysis"
        # Exit 0 but Claude should check the needs_confirmation flag
    else
        # Prompt is clear, proceed
        echo "$analysis"
    fi

    exit 0
}

main "$@"
