---
name: status
description: Show current project status from Notion and local state
---

# /status - Project Status

Show the current state of this project.

## Execution

1. Read status.json for local state
2. Fetch the Notion Design Doc using `mcp__notion__notion-fetch`
3. Parse PROJECT SNAPSHOT section

## Output Format

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PROJECT: {name}

  Status: {status}
  Phase: {phase} of 6
  Last touched: {date}

  ┌────────────────────────────────────────────────┐
  │ PHASE PROGRESS                                  │
  ├────────────────────────────────────────────────┤
  │ 0. BRAINDUMP   {✓ or ○ or ⏭}  (optional)       │
  │ 1. CAPTURE     {✓ or ○ or →}                   │
  │ 2. EXPAND      {✓ or ○}                        │
  │ 3. SPECIFY     {✓ or ○}                        │
  │ 4. ARCHITECT   {✓ or ○}                        │
  │ 5. CONFIGURE   {✓ or ○}                        │
  │ 6. SEED        {✓ or ○}                        │
  └────────────────────────────────────────────────┘

  ⏭️ NEXT: {next action from Notion or status.json}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Legend:
- ✓ = Complete
- → = Current (in progress)
- ○ = Pending
- ⏭ = Skipped

## Process

1. Read `status.json` from project root
2. Fetch Notion page using page ID from status.json
3. Parse PROJECT SNAPSHOT section for current state
4. Display combined local + Notion status
