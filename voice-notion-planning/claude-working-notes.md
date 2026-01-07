# Claude Working Notes System

Notion-based scratchpads that Claude maintains during ideation sessions. These are visible to the user and persist across sessions/platforms.

## Purpose

During ideation, Claude needs to track:
- Questions to ask (and why)
- Emerging design structure
- Gaps and assumptions detected
- Patterns and themes
- Session momentum and energy

By keeping these in Notion:
- User can watch Claude's thinking unfold
- Notes persist between voice and desktop sessions
- Provides transparency into the ideation process
- Creates continuity for multi-session projects

---

## Notion Structure: Ideation Canvas

Each project ideation gets a dedicated page with these sections:

```
[Project Name] - Ideation Canvas
├── 🎯 Core Concept (summary, updates as clarity emerges)
├── 📋 Design Schema (the evolving structure)
├── ❓ Claude's Question Queue (what to explore next)
├── 🔍 Gap Tracker (what's missing)
├── 💡 Assumptions Log (detected, validation status)
├── 🔗 Connections Map (how ideas relate)
├── 📊 Exploration Progress (dimensions covered)
├── 🌡️ Energy Notes (user engagement observations)
└── 📝 Session History (dated summaries)
```

---

## Scratchpad Definitions

### 1. Question Queue ❓

**Purpose:** Track questions Claude wants to ask, prioritized by importance and timing.

**Structure:**
```
| Priority | Question | Context/Why | Status |
|----------|----------|-------------|--------|
| 🔴 High | What triggers a user to need this? | Core to value prop, no answer yet | Pending |
| 🟡 Medium | What existing tools do they use? | Helps understand integration needs | Pending |
| 🟢 Low | What's the timeline thinking? | Nice to know, not blocking | Pending |
| ✅ Asked | Who is the primary user? | Needed for all design decisions | Answered: "Solo developers" |
```

**Behaviors:**
- Add questions as gaps are detected
- Prioritize based on what blocks further ideation
- Mark as "Asked" with summary of answer
- Review queue between phases
- Surface high-priority unasked questions

---

### 2. Design Schema 📋

**Purpose:** The evolving structural description of the project. This IS the deliverable being built.

**Structure:**
```
## Project Name
[One-line description - updates as clarity emerges]

## Problem
- Who: [specific audience]
- Pain: [what's wrong now]
- Trigger: [when they feel it]

## Solution
- Core: [the main thing it does]
- How: [key mechanism/approach]
- Differentiator: [why this vs alternatives]

## Features
### Must Have (MVP)
- [ ] Feature 1: [description]
- [ ] Feature 2: [description]

### Should Have (v1.1)
- [ ] Feature 3: [description]

### Could Have (Future)
- [ ] Feature 4: [description]

## Technical Shape
- Platform: [where it runs]
- Stack: [technologies]
- Integrations: [what it connects to]
- Constraints: [limitations to work within]

## Open Questions
- [Questions that need external research]

## Next Steps
1. [Immediate next action]
2. [Following action]
```

**Behaviors:**
- Update in real-time during conversation
- Mark sections as 🔴 Empty / 🟡 Draft / 🟢 Solid
- Note confidence level on key decisions
- Highlight sections that contradict each other

---

### 3. Gap Tracker 🔍

**Purpose:** Explicitly track what's missing or underdeveloped.

**Structure:**
```
| Gap Type | Description | Severity | Notes |
|----------|-------------|----------|-------|
| Vagueness | "Users" not defined specifically | 🔴 Blocking | Asked once, got generic answer |
| Missing | No error handling discussed | 🟡 Important | Need to explore edge cases |
| Assumption | Assumes API exists | 🟡 Important | Need to validate |
| Depth | Pricing model surface-level | 🟢 Minor | Can address later |
| Conflict | Scope vs timeline mismatch | 🔴 Blocking | User wants everything in 2 weeks |
```

**Gap Types:**
- **Vagueness**: Terms/concepts not clearly defined
- **Missing**: Dimension not explored at all
- **Assumption**: Unvalidated belief
- **Depth**: Explored but too shallow
- **Conflict**: Contradictory requirements/desires

**Behaviors:**
- Add gaps as detected during conversation
- Review at end of each phase
- Attempt to resolve before moving phases
- Carry unresolved gaps forward visibly

---

### 4. Assumptions Log 💡

**Purpose:** Track beliefs that underpin the design but haven't been validated.

**Structure:**
```
| Assumption | Source | Risk if Wrong | Validation Status |
|------------|--------|---------------|-------------------|
| Users have technical background | User said "developers" | High - changes entire UX | ✅ Confirmed |
| API rate limits won't be issue | Implied by scale | Medium - architecture change | ❓ Needs research |
| Users will pay monthly | Industry standard | High - business model | 🔴 Unvalidated |
| Can integrate with Notion | User mentioned it | Low - alternative exists | ✅ Confirmed - MCP exists |
```

**Behaviors:**
- Surface assumptions as they're detected
- Ask user to confirm critical ones
- Flag unvalidated assumptions in Design Schema
- Note which assumptions are "load-bearing"

---

### 5. Connections Map 🔗

**Purpose:** Track how different ideas, features, and concepts relate.

**Structure:**
```
## Clusters
- **User Experience**: onboarding → first value → retention loop
- **Technical Core**: data model → API → integrations
- **Business**: value prop → pricing → growth

## Dependencies
- Feature B requires Feature A
- Integration X depends on user having Y account
- Timeline assumes Z resource available

## Tensions
- "Simple" vs "Powerful" - user wants both
- "Fast" vs "Comprehensive" - need to choose
- "Privacy" vs "Collaboration" - design challenge

## Themes Emerging
- User values speed over completeness
- Strong preference for keyboard-driven UI
- Aversion to subscription pricing
```

**Behaviors:**
- Note when ideas connect across dimensions
- Surface dependencies that create risk
- Identify tensions that need resolution
- Track recurring themes in user's preferences

---

### 6. Exploration Progress 📊

**Purpose:** Visual tracking of what's been covered.

**Structure:**
```
## Dimensions
- [🟢] User/Audience - well explored
- [🟡] Functionality - core clear, edges fuzzy
- [🟡] Technical - direction set, details pending
- [🔴] Business/Value - barely touched
- [🟢] Context - clear picture

## Phases
- [✅] Capture - complete
- [✅] Clarify - complete
- [🔄] Expand - in progress (60%)
- [ ] Challenge - not started
- [ ] Synthesize - not started
- [ ] Validate - not started

## Completeness Score
[███████░░░] 70% - Good progress, business model needed
```

**Behaviors:**
- Update after each significant exchange
- Use to guide conversation toward gaps
- Show user progress transparently
- Gate phase transitions on coverage

---

### 7. Energy Notes 🌡️

**Purpose:** Track user engagement, enthusiasm, and hesitation patterns.

**Structure:**
```
## High Energy Topics (explore more)
- Voice interface ideas - lots of excitement
- Integration possibilities - eager to discuss
- Mobile use case - keeps bringing it up

## Low Energy / Hesitation (probe carefully)
- Pricing discussion - avoided twice
- Timeline questions - vague answers
- Technical constraints - seems uncertain

## Signals Observed
- "That's exactly it!" → core value prop moments
- "I don't know..." → genuine uncertainty vs avoidance
- Quick responses → comfortable territory
- Long pauses → processing or discomfort

## Possible Meanings
- Pricing hesitation might = unclear business model
- Technical uncertainty might = need research phase
- Mobile enthusiasm might = primary use case actually
```

**Behaviors:**
- Note energy shifts during conversation
- Lean into high-energy topics for momentum
- Approach low-energy topics with care
- Use patterns to understand true priorities

---

### 8. Session History 📝

**Purpose:** Maintain continuity across sessions.

**Structure:**
```
## Session 3 - Jan 5, 2025 (Voice, 25 min)
**Focus:** Technical architecture deep-dive
**Progress:** Expanded technical dimension, identified 3 integration needs
**Key Decisions:**
- Will use TypeScript
- Notion integration is must-have
- Local-first architecture
**Gaps Remaining:**
- Error handling approach
- Offline sync strategy
**Next Session Should:**
- Explore offline scenarios
- Begin Challenge phase
**User Mood:** Energized, making concrete decisions

---

## Session 2 - Jan 4, 2025 (Desktop, 40 min)
...
```

**Behaviors:**
- Summarize each session immediately after
- Note what should carry forward
- Suggest focus for next session
- Track momentum across sessions

---

## How Claude Uses These Notes

### During Conversation

1. **Before responding**, check:
   - Question Queue for pending high-priority questions
   - Gap Tracker for unresolved blocking gaps
   - Energy Notes for topics to lean into/avoid

2. **After user speaks**, update:
   - Design Schema with new information
   - Mark questions as answered
   - Note new gaps or assumptions detected
   - Record energy signals

3. **At phase transitions**, review:
   - Exploration Progress for coverage
   - Gap Tracker for blocking issues
   - Assumptions Log for load-bearing unknowns

### Between Sessions

1. **Ending session:**
   - Write Session History entry
   - Update all scratchpads with current state
   - Note recommended focus for next session

2. **Starting session:**
   - Read Session History for context
   - Review Gap Tracker for priorities
   - Check Question Queue for pending items
   - Note Energy patterns to inform approach

---

## Notion Implementation

### Creating an Ideation Canvas

When starting ideation for a new project:

1. Create page under Project Incubator
2. Use toggle blocks for each scratchpad section
3. Use tables for structured trackers
4. Use callouts for current status/phase
5. Link to relevant Ideas & Captures entries

### Real-Time Updates

During conversation, Claude should:
- Append to sections (don't overwrite)
- Use timestamps for significant updates
- Mark status changes clearly
- Keep Design Schema as source of truth

### Visual Cues

Use emoji consistently:
- 🔴 Blocking/Critical/Empty
- 🟡 Important/Draft/In Progress
- 🟢 Minor/Solid/Complete
- ✅ Done/Confirmed/Asked
- ❓ Unknown/Needs Research
- 🔄 In Progress
