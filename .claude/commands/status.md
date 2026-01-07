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
2. Fetch Notion Design Doc using page ID from status.json
3. Parse PROJECT SNAPSHOT section for current state
4. **Check Quick Capture page** for any pending items
5. Display combined local + Notion status

## Quick Capture Check

If `status.json` has a `notion.quickCapture.id`:
1. Fetch the Quick Capture **database** using `mcp__notion__notion-fetch`
2. Filter for items where Processed = false (unchecked checkbox)
3. If unprocessed items found, show alert:

```
📥 QUICK CAPTURE ({count} unprocessed items)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
{list items with their Type emoji}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Review these before continuing? (y/N)
```

This ensures nothing captured between sessions gets lost.

**Note:** Quick Capture is a database (not a page) to enable iOS Shortcut integration for mobile capture.
