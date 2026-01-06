# Session Dashboard Template

This template provides a "where was I?" view that's auto-generated at session end and checked at session start. Optimized for phone viewing between sessions.

## Purpose

Help users with ADHD (or anyone) quickly orient themselves:
- What project am I working on?
- What phase am I in?
- What did we accomplish last time?
- What's pending/blocking?
- What should I do next?

## Page Structure

```
# [Project Name] - Session Dashboard

> 📍 **Phase [X]**: [Phase Name] | **Progress**: [X]% complete
> 🕐 **Last Active**: [relative time, e.g., "2 days ago"]

---

## 🎯 Quick Status

| Metric | Status |
|--------|--------|
| Current Phase | [Phase X: NAME] |
| Phase Progress | [████░░░░░░] 40% |
| Pending Forms | [X] awaiting your input |
| New Ideas | [X] in idea dump list |
| Blockers | [None / List] |

---

## 📋 Last Session Summary

**Date**: [timestamp]
**Duration**: [approximate]
**Mode**: [Voice / Desktop / Mixed]

### What We Accomplished
- ✅ [Completed item 1]
- ✅ [Completed item 2]
- ✅ [Completed item 3]

### Decisions Made
- [Decision 1]: [choice made and why]
- [Decision 2]: [choice made and why]

### Where We Stopped
> [Specific point where session ended, what was in progress]

---

## ⏳ Pending Items

### Input Forms Awaiting Response
| Form | Priority | Questions | Created |
|------|----------|-----------|---------|
| [Form title] | 🔴 High | 3 | 2 days ago |
| [Form title] | 🟡 Medium | 2 | 1 day ago |

→ [Link to form 1]
→ [Link to form 2]

### Intent Confirmations Pending
| Action | Risk | Status |
|--------|------|--------|
| [Action description] | 🟡 Medium | Awaiting confirm |

→ [Link to confirmation]

### Living Idea Dump List
| New Ideas | Type |
|-----------|------|
| [Idea 1] | 💡 Feature |
| [Idea 2] | 🐛 Bug |
| [Idea 3] | ✨ Enhancement |

→ [Link to idea list]

---

## 🚀 Suggested Next Steps

Based on current state, here's what to do:

### If You Have 5 Minutes (Phone)
1. [ ] Review and answer pending forms
2. [ ] Check idea dump list
3. [ ] Confirm/cancel pending actions

### If You Have 30 Minutes (Desktop)
1. [ ] Process form responses with Claude
2. [ ] Continue [specific task from last session]
3. [ ] [Next logical step in current phase]

### If You Have 2+ Hours (Deep Work)
1. [ ] Complete current phase
2. [ ] Run `/advance` to move to next phase
3. [ ] [Larger scope work]

---

## 📊 Project Progress

### Phase Completion
```
[BRAINDUMP] ████████████ ✅ (Optional - Completed/Skipped)
[CAPTURE]   ████████████ ✅
[EXPAND]    ████████░░░░ 🔄 Current (70%)
[SPECIFY]   ░░░░░░░░░░░░ ⏳
[ARCHITECT] ░░░░░░░░░░░░ ⏳
[CONFIGURE] ░░░░░░░░░░░░ ⏳
[SEED]      ░░░░░░░░░░░░ ⏳
```

### Key Milestones
- [x] Initial idea captured
- [x] Core concept defined
- [ ] All macro questions answered ← **Current focus**
- [ ] PRD v1 complete
- [ ] Architecture decided
- [ ] Project seeded

---

## 🔗 Quick Links

| Resource | Link |
|----------|------|
| Ideation Canvas | [→ Open] |
| CONTEXT.md | [→ Open in editor] |
| Current Spec | [→ spec/v[X].md] |
| Living Idea List | [→ Open] |
| Pending Forms | [→ View all] |

---

## 📝 Notes for Next Session

> [Any context Claude wants to remember, written at session end]

---

## Metadata

| Field | Value |
|-------|-------|
| Dashboard Updated | [timestamp] |
| Last Session | [timestamp] |
| Sessions Total | [count] |
| Project Created | [timestamp] |
| Estimated Completion | [if calculable] |

---

*This dashboard auto-updates at each session end.*
```

---

## Auto-Generation Logic

At session end, generate/update dashboard by:

1. **Read project status.json** → Current phase, gate status
2. **Query Notion** → Pending forms, confirmations, ideas
3. **Parse session activity** → What was accomplished
4. **Calculate progress** → Phase completion percentages
5. **Generate suggestions** → Based on state and time estimates

---

## Notion MCP Implementation

```javascript
// Update dashboard at session end
async function updateDashboard(projectId, sessionSummary) {
  // Find or create dashboard page
  const dashboard = await findOrCreateDashboard(projectId);

  // Update status callout
  await updateStatusCallout(dashboard, {
    phase: sessionSummary.currentPhase,
    progress: sessionSummary.phaseProgress,
    lastActive: new Date()
  });

  // Update last session summary
  await updateLastSession(dashboard, {
    accomplishments: sessionSummary.completed,
    decisions: sessionSummary.decisions,
    stoppedAt: sessionSummary.stoppedAt
  });

  // Update pending items
  await updatePendingItems(dashboard, {
    forms: await getPendingForms(projectId),
    confirmations: await getPendingConfirmations(projectId),
    ideas: await getNewIdeas(projectId)
  });

  // Generate and update suggestions
  await updateSuggestions(dashboard, sessionSummary);
}
```

---

## ADHD-Friendly Design Principles

1. **Status visible immediately** - Top callout shows phase and progress
2. **Time-based suggestions** - "If you have 5 min" respects energy levels
3. **Visual progress bars** - ASCII art progress is scannable
4. **Links are prominent** - One tap to get anywhere
5. **Accomplishments celebrated** - ✅ items feel good
6. **No judgment** - Dashboard is neutral about time gaps
7. **Mobile-first layout** - Tables and lists work on phone

---

## When to Show Dashboard

**Session Start Hook** checks:
1. Time since last session > 4 hours? → Show dashboard summary
2. Pending items exist? → Highlight them
3. User seems confused? → Suggest reviewing dashboard

**Quick Summary Mode** (for terminal):
```
📍 Project: wellness-tracker | Phase 2: EXPAND (70%)
⏳ Pending: 2 forms, 3 new ideas
🚀 Next: Answer form about user personas, then continue macro questions
→ Full dashboard: [Notion link]
```
