# Phase 0.2: Digging Deeper

## Setup

Use `mcp__clear-thought__mental_models` to retrieve:
1. `five-whys` model
2. `assumption-surfacing` model

## Process

### Step 1: Identify Key Goals
From Deep Listening, select 3 key goals/desires to explore.

### Step 2: Apply Five-Whys

For each goal, ask "Why?" five times:

**Goal 1: [State the goal]**
- Why do you want this? → [Answer 1]
- Why does that matter? → [Answer 2]
- Why is that important? → [Answer 3]
- Why do you care about that? → [Answer 4]
- Why is that significant? → [Answer 5 = Root motivation]

**Goal 2: [State the goal]**
- [Repeat five-whys]

**Goal 3: [State the goal]**
- [Repeat five-whys]

### Step 3: Apply Assumption-Surfacing

List all assumptions being made:

**Technical Assumptions**
- "The user has [X technology]"
- "This can be built with [Y]"
- "Performance will be [Z]"

**User Assumptions**
- "Users want [X]"
- "Users will understand [Y]"
- "Users have time for [Z]"

**Market Assumptions**
- "There's demand for [X]"
- "Competition doesn't do [Y]"
- "People will pay for [Z]"

**Personal Assumptions**
- "I have the skills to [X]"
- "I have the time for [Y]"
- "This aligns with my [Z]"

### Step 4: Categorize Assumptions

Mark each assumption:
- **Hard**: Truly fixed, can't change (laws of physics, regulations)
- **Soft**: Difficult but changeable (budget, timeline, technology)
- **Phantom**: May not be real constraints at all (assumed limitations)

### Step 5: Find the Underneath Story

Based on five-whys and assumptions:
- What is the REAL motivation beneath the stated goals?
- What problem is this person actually trying to solve in their life?
- What would success mean for them personally?

## Output Template

Write to `spec/dream/02-digging-deeper.md`:

```markdown
# Digging Deeper: {Project Name}

## Five-Whys Analysis

### Goal 1: [Goal]
1. Why? →
2. Why? →
3. Why? →
4. Why? →
5. **Root:** →

### Goal 2: [Goal]
[Same structure]

### Goal 3: [Goal]
[Same structure]

## Root Motivations Summary
The three goals converge on: [synthesis of root motivations]

---

## Assumption Inventory

### Technical (T)
| Assumption | Category | Challenge? |
|------------|----------|------------|
| ... | Hard/Soft/Phantom | Yes/No |

### User (U)
| Assumption | Category | Challenge? |
|------------|----------|------------|
| ... | Hard/Soft/Phantom | Yes/No |

### Market (M)
| Assumption | Category | Challenge? |
|------------|----------|------------|
| ... | Hard/Soft/Phantom | Yes/No |

### Personal (P)
| Assumption | Category | Challenge? |
|------------|----------|------------|
| ... | Hard/Soft/Phantom | Yes/No |

## Phantom Assumptions to Challenge
These "constraints" may not be real:
1. ...
2. ...

---

## The Underneath Story

> [What is this person REALLY trying to create/solve/become?]

## Key Insights to Carry Forward
1. ...
2. ...
3. ...
```
