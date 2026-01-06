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

---

## ADHD-Optimized Hooks

### Celebration Hooks (PostToolUse)

**Purpose:** Provide immediate dopamine feedback for completed actions
**ADHD Benefit:** Combats under-stimulation, provides positive reinforcement

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write",
        "hooks": [{
          "type": "command",
          "command": "echo '✅ File created! Nice work!'"
        }]
      },
      {
        "matcher": "Edit|MultiEdit",
        "hooks": [{
          "type": "command",
          "command": "echo '✏️ Changes saved successfully!'"
        }]
      },
      {
        "matcher": "Bash",
        "hooks": [{
          "type": "command",
          "command": "if [ $? -eq 0 ]; then echo '🎯 Command completed!'; fi"
        }]
      }
    ]
  }
}
```

### Session Completion Hook (Stop)

**Purpose:** Celebrate task completion, reinforce progress
**ADHD Benefit:** Provides closure, dopamine hit for finishing

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [{
          "type": "command",
          "command": "echo '🎉 Task complete! You did great!'"
        }]
      }
    ]
  }
}
```

### Progress Logging Hook (Stop)

**Purpose:** Track session activity for later review
**ADHD Benefit:** External memory, combat "what did I do?" confusion

```bash
#!/bin/bash
# ~/.claude/hooks/log-session.sh
SESSION_LOG=~/.claude/activity.log
echo "[$(date '+%Y-%m-%d %H:%M')] Session completed in $(pwd)" >> "$SESSION_LOG"
echo "  Files: $(git diff --name-only 2>/dev/null | head -5 | tr '\n' ', ')" >> "$SESSION_LOG"
```

### Break Reminder Hook (NotificationSent)

**Purpose:** Remind user to take breaks
**ADHD Benefit:** Combat hyperfocus-induced burnout

```bash
#!/bin/bash
# Check session duration (requires external tracking)
# Notify if >90 minutes
if [ "$SESSION_DURATION_MINUTES" -gt 90 ]; then
  echo "⏰ You've been working for 90+ minutes. Consider a short break!"
fi
```

## ADHD Hook Decision Matrix

| User Profile | Recommended Hooks |
|--------------|-------------------|
| ADHD - Needs motivation | All celebration hooks |
| ADHD - Session tracking | Progress logging + celebration |
| ADHD - Hyperfocus risk | Break reminder + logging |
| ADHD - Full support | All ADHD hooks |
| Non-ADHD | Standard hooks only |

## ADHD Hooks Settings.json

Complete configuration for ADHD-optimized project:

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [{
          "type": "command",
          "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/skill-activation-prompt.sh"
        }]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Write",
        "hooks": [{
          "type": "command",
          "command": "echo '✅ File created!'"
        }]
      },
      {
        "matcher": "Edit|MultiEdit",
        "hooks": [{
          "type": "command",
          "command": "echo '✏️ Saved!'"
        }]
      }
    ],
    "Stop": [
      {
        "hooks": [{
          "type": "command",
          "command": "echo '🎉 Great work! Task complete.'"
        }]
      }
    ]
  }
}
```
