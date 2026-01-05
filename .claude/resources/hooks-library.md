# Hooks Library

Hooks to include in output projects for automation and guardrails.

## Source: Infrastructure Showcase

### Essential Hooks (Always Consider)

#### skill-activation-prompt (UserPromptSubmit)
**Purpose:** Auto-suggest skills based on user prompts
**Customization:** None needed - reads skill-rules.json
**Files:**
- skill-activation-prompt.sh
- skill-activation-prompt.ts
- package.json (for tsx)

**When to Include:** Projects with 2+ skills

#### post-tool-use-tracker (PostToolUse)
**Purpose:** Track file changes for context management
**Customization:** None - auto-detects structure
**Files:** post-tool-use-tracker.sh

**When to Include:** Complex projects with many files

### Optional Hooks (Need Customization)

#### tsc-check (Stop)
**Purpose:** TypeScript compilation check on stop
**Customization:** Heavy - service names, paths
**When to Include:** TypeScript monorepos only

#### error-handling-reminder (Stop)
**Purpose:** Remind about error handling after edits
**Customization:** Moderate
**When to Include:** Backend projects with error tracking

## Hook Decision Matrix

| Project Type | Recommended Hooks |
|--------------|-------------------|
| Simple (1-2 skills) | None or skill-activation only |
| Medium (3+ skills) | skill-activation-prompt |
| Complex TypeScript | skill-activation + post-tool-use |
| Monorepo | All essential + tsc-check (customized) |

## Hook Setup for Output Projects

### Minimal (Most Projects)
```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/skill-activation-prompt.sh"
          }
        ]
      }
    ]
  }
}
```

### With Tool Tracking
```json
{
  "hooks": {
    "UserPromptSubmit": [...],
    "PostToolUse": [
      {
        "matcher": "Edit|MultiEdit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/post-tool-use-tracker.sh"
          }
        ]
      }
    ]
  }
}
```

## Hook Installation Steps

For output projects that include hooks:

1. Create `.claude/hooks/` directory
2. Copy hook files
3. Run `npm install` in hooks directory
4. Make shell scripts executable: `chmod +x *.sh`
5. Update settings.json with hook configuration

## When NOT to Include Hooks

- Very simple projects (single skill or none)
- Projects where user prefers manual control
- Learning/tutorial projects (reduce complexity)
