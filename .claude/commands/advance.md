---
name: advance
description: Move to the next phase after completing current phase (gate-checked)
---

# /advance - Advance to Next Phase

Gate-checked progression through phases.

## Process

1. Read status.json for current phase
2. Fetch Notion page and verify gate criteria for current phase
3. If gates passed: advance, update status.json and Notion
4. If gates not passed: explain what's missing

## Gate Criteria by Phase

### Phase 0 → 1 (Braindump → Capture)
- Optional phase - can skip with "skip braindump"
- If used: `braindump/extracted-insights.md` must exist

### Phase 1 → 2 (Capture → Expand)
- THE IDEA section must have one-liner and core insight
- CONTEXT.md has captured raw thoughts
- At least one entry in OPEN QUESTIONS

### Phase 2 → 3 (Expand → Specify)
- SYSTEM OVERVIEW must be populated
- At least 3 components in COMPONENTS table
- `expansion.md` exists with all 6 questions answered

### Phase 3 → 4 (Specify → Architect)
- PRD exists in `spec/` folder
- At least 3 features with acceptance criteria
- User approved the PRD

### Phase 4 → 5 (Architect → Configure)
- Architecture document exists in `spec/`
- Trade-off analysis documented
- Pre-mortem analysis completed
- User approved architecture

### Phase 5 → 6 (Configure → Seed)
- `config/` folder has configuration files
- CLAUDE.md content drafted
- User approved configuration

### Phase 6 (Seed) = Final Phase
- Generates project scaffold
- Creates buildable project structure

## Output

If gates pass:
```
✅ Phase {N} ({name}) complete!

Moving to Phase {N+1}: {next phase name}

{Brief description of next phase}

⏭️ NEXT: {first action for new phase}
```

If gates fail:
```
⚠️ Phase {N} ({name}) not yet complete.

Missing:
- {item 1}
- {item 2}

Complete these items, then run /advance again.
```

## Updating State

When advancing:
1. Update `status.json`:
   - `currentPhase`: increment
   - `phaseName`: new phase name
   - `phases.{current}.status`: "complete"
   - `phases.{next}.status`: "in_progress"
   - `lastSession`: timestamp

2. Update Notion PROJECT SNAPSHOT:
   - Current Phase row
   - Phase Progress table
   - Last touched date
