# Phase 0.4: Parallel Worlds

## Setup

Use `mcp__clear-thought__thoughtbox` with branching:

```javascript
// For each branch, use:
{
  branchFromThought: 1,  // Branch from initial setup thought
  branchId: "minimal" | "maximal" | "lateral" | "shadow",
  thoughtNumber: 2-6,  // 5 thoughts per branch
  totalThoughts: 25   // Approximate total
}
```

## Process

### Initial Thought (Thought 1)
Set up the branching exploration:
"Exploring parallel worlds for {project-name}. I'll create 4 branches to explore different versions of this project: minimal, maximal, lateral, and shadow."

### Branch 1: MINIMAL (branchId: "minimal")

**The smallest version that keeps the soul.**

Thought 2: "What is the absolute essence of this project? If I could only keep ONE thing, what would it be?"

Thought 3: "What can be stripped away without losing meaning? What features are actually optional?"

Thought 4: "What's the smallest version that would still make the creator proud?"

Thought 5: "What's the minimum viable dream - not MVP, but the smallest version that still has magic?"

Thought 6: "Minimal version synthesis: [describe the minimal world]"

### Branch 2: MAXIMAL (branchId: "maximal")

**The biggest, most ambitious version.**

Thought 2: "If this project became huge, what would it look like? Remove all resource constraints."

Thought 3: "What features would exist if there were no limits? What integrations?"

Thought 4: "How would this change the world if it succeeded wildly?"

Thought 5: "What's the version that would make headlines?"

Thought 6: "Maximal version synthesis: [describe the maximal world]"

### Branch 3: LATERAL (branchId: "lateral")

**Unexpected direction, genre shift.**

Thought 2: "What if this wasn't [what it appears to be]? What if it was actually [something completely different]?"

Thought 3: "What adjacent problem could this solve? What different audience could use this?"

Thought 4: "What if we combined this with something unexpected?"

Thought 5: "What's the version that would surprise everyone, including the creator?"

Thought 6: "Lateral version synthesis: [describe the lateral world]"

### Branch 4: SHADOW (branchId: "shadow")

**What are you avoiding?**

Thought 2: "What aspect of this project feels scary or uncomfortable? Why?"

Thought 3: "What would happen if you went TOWARD the fear instead of away?"

Thought 4: "What version of this project would require you to grow the most?"

Thought 5: "What's the version you secretly want but are afraid to admit?"

Thought 6: "Shadow version synthesis: [describe the shadow world]"

### Synthesis Thought

After all branches, create a synthesis thought reviewing all four worlds.

## Output Template

Write to `spec/dream/04-parallel-worlds.md`:

```markdown
# Parallel Worlds: {Project Name}

## The Minimal World

**Essence:** [One sentence]

**What stays:**
- ...
- ...

**What goes:**
- ...
- ...

**The minimal dream:**
> [Description]

---

## The Maximal World

**Scale:** [One sentence]

**Full feature set:**
- ...
- ...
- ...

**World impact:**
> [How it changes things]

**The maximal dream:**
> [Description]

---

## The Lateral World

**The twist:** [What unexpected direction]

**Actually it's:** [Reframe]

**Different audience:** [Who else could use this]

**The lateral dream:**
> [Description]

---

## The Shadow World

**The fear:** [What's scary about this]

**Going toward it:** [What happens if you embrace it]

**Growth required:** [How would you need to change]

**The shadow dream:**
> [Description]

---

## Worlds Compared

| Aspect | Minimal | Maximal | Lateral | Shadow |
|--------|---------|---------|---------|--------|
| Core value | | | | |
| Audience | | | | |
| Risk level | | | | |
| Personal growth | | | | |

## Tensions and Trade-offs
- Minimal vs Maximal: ...
- Safe vs Shadow: ...
- Expected vs Lateral: ...

## What Resonates Across Worlds
[What themes appear in multiple branches?]
```
