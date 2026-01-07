---
name: whats-next
description: Directive next step - what to do right now (Project Manager mode)
---

# /whats-next - What's Next

Project Manager mode: Tell the user exactly what to do next.

## Principles

From the analysis docs:
- **DIRECTIVE not interrogative**
- Don't ask "What would you like?" - TELL them the next step
- "Here is what we're doing next" not "What do you want to do?"

## Execution

1. Read status.json for current phase
2. **Check Quick Capture page first** for any pending items
3. Fetch Notion Design Doc for current state
4. Determine the single most important next action
5. Present it clearly and directly

## Quick Capture Priority

**Always check Quick Capture database before anything else.**

If `status.json` has `notion.quickCapture.id`:
1. Fetch the database using `mcp__notion__notion-fetch`
2. Filter for items where Processed = false (unchecked)
3. If unprocessed items exist:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📥 YOU CAPTURED {count} THINGS SINCE LAST SESSION

{list items with Type emoji}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⏭️ NEXT STEP

Let's process these captures first. I'll categorize each one.
Start by telling me about the first item: "{first item}"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

After processing captures, mark each as Processed=true and proceed to normal phase workflow.

**To mark as processed:**
```
mcp__notion__notion-update-page
  page_id: [item ID]
  command: "update_properties"
  properties: {"Processed": "__YES__"}
```

## Output Format

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⏭️ NEXT STEP

{Clear, specific instruction}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Examples

**Good (Directive):**
- "Describe your core idea in one sentence. Start with 'It's a...'"
- "Add 3 components to the table. Start with the most obvious one."
- "Answer this: What triggered this idea?"
- "Review the PRD and approve it with 'approved' or note changes."

**Bad (Interrogative):**
- "What would you like to work on?"
- "How should we proceed?"
- "What's on your mind?"

## Phase-Specific Next Steps

### Phase 0 (Braindump)
- "Add materials to braindump/source-materials/"
- "Run /braindump to process your materials"
- "Skip braindump and run /capture to start fresh"

### Phase 1 (Capture)
- "Tell me your idea in 2-3 sentences"
- "Answer: What triggered this idea?"
- "Answer: What's the core insight?"

### Phase 2 (Expand)
- "Answer: Who is the primary user?"
- "Answer: What's the core problem?"
- "Define 3-5 essential features"

### Phase 3 (Specify)
- "Review the Overview section"
- "Add acceptance criteria to Feature X"
- "Approve the PRD"

### Phase 4 (Architect)
- "Choose the project type"
- "Review the trade-off analysis"
- "Approve the architecture"

### Phase 5 (Configure)
- "Review the CLAUDE.md draft"
- "Confirm the commands list"
- "Approve the configuration"

### Phase 6 (Seed)
- "Run /seed to generate the project"
- "Copy output/ to your projects folder"
- "Start building!"

## When Stuck

If genuinely blocked:
```
🚧 BLOCKED

{Explain the blocker}

Options to unblock:
1. {Option A}
2. {Option B}

Which unblocks you faster?
```

Only ask a question when there's a real decision to make.

## ADHD-Friendly

- Single clear action (not a list)
- Specific starting point ("Start with...")
- No cognitive overhead
- Can be voice-read easily
