# Intent Confirmation Template

This template is used when Claude needs to confirm understanding of a complex or potentially destructive action before executing.

## When to Create Intent Confirmation

- Complex prompts with multiple potential interpretations
- Destructive or irreversible actions
- Actions affecting multiple files or systems
- Phase transitions or major decisions
- Voice prompts that may have transcription ambiguity

## Page Structure

```
# [Project Name] - Confirm Intent

> 🔔 **Action Required** | **Urgency**: 🔴 Before proceeding

---

## What I Understood

Based on your request, here's what I plan to do:

### Primary Action
[Clear description of the main action]

### Scope
- **Files affected**: [list or count]
- **Systems touched**: [list]
- **Reversibility**: [Reversible / Partially reversible / Irreversible]

### Expected Outcome
[What will be different after this action]

---

## Your Original Request

> "[Exact text of user's prompt]"

---

## My Interpretation

| Aspect | My Understanding |
|--------|------------------|
| **Goal** | [What you want to achieve] |
| **Method** | [How I plan to do it] |
| **Scope** | [What's included/excluded] |
| **Constraints** | [Limitations I'm respecting] |

---

## Potential Ambiguities

### ⚠️ Clarification Needed

1. **[Ambiguous aspect]**
   - Option A: [interpretation]
   - Option B: [interpretation]
   - 📝 Your choice: _____

2. **[Another ambiguity]**
   - Option A: [interpretation]
   - Option B: [interpretation]
   - 📝 Your choice: _____

---

## Confirmation

Please confirm by selecting one:

- [ ] ✅ **Proceed** - My understanding is correct, execute as planned
- [ ] 🔄 **Modify** - Make these changes: [space for notes]
- [ ] ❌ **Cancel** - Do not proceed, I'll clarify my request
- [ ] 💬 **Discuss** - I have questions before deciding

📝 **Additional Notes:**
> [Space for any clarifications]

---

## Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| [Risk 1] | Low/Med/High | Low/Med/High | [How we handle it] |
| [Risk 2] | Low/Med/High | Low/Med/High | [How we handle it] |

---

## Metadata

| Field | Value |
|-------|-------|
| Created | [timestamp] |
| Original prompt | [truncated if long] |
| Session | [identifier] |
| Phase | [current phase] |
| Status | 🔔 Pending / ✅ Confirmed / ❌ Cancelled / 🔄 Modified |

---

*Waiting for your confirmation before proceeding.*
```

---

## When to Use Inline vs Notion Confirmation

### Use Inline (Terminal) Confirmation
- Simple yes/no decisions
- Low-risk actions
- User is actively engaged in terminal
- Quick turnaround needed

### Use Notion Confirmation
- Complex multi-part actions
- Destructive or irreversible operations
- User prefers async review
- Multiple clarifications needed
- User is primarily mobile

---

## Trigger Conditions

Create Notion confirmation when ANY of:

1. **Complexity threshold**: Prompt > 30 words with multiple clauses
2. **Destructive keywords**: delete, remove, overwrite, replace all, reset
3. **Scope indicators**: "all files", "entire project", "everything"
4. **Uncertainty markers**: Claude's confidence < 80%
5. **Phase transitions**: Moving between major phases
6. **External effects**: Actions affecting systems outside the project

---

## Processing Confirmations

At session start or when checking Notion:

1. Find confirmations with status "Pending"
2. Check user's selection (Proceed/Modify/Cancel/Discuss)
3. If **Proceed**: Execute the planned action
4. If **Modify**: Parse modifications, update plan, optionally re-confirm
5. If **Cancel**: Acknowledge, ask for new instructions
6. If **Discuss**: Enter dialogue mode about the action

---

## ADHD-Friendly Design

1. **Clear action summary first** - Don't bury the lede
2. **Visual risk indicators** - Easy to scan severity
3. **Explicit options** - No ambiguity about how to respond
4. **Original prompt visible** - User can verify what they asked
5. **One decision at a time** - Don't bundle multiple confirmations
6. **Escape hatch clear** - Cancel is always an option

---

## Integration with Prompt Improver

When using claude-code-prompt-improver:

1. Prompt improver reformulates the request
2. If reformulation differs significantly from original → create confirmation
3. Show both original and improved version
4. Let user confirm the improved interpretation

```
Original: "fix the thing with the buttons"
Improved: "Fix the onClick handler in Button.tsx that's causing double-submission"

Confidence: 75% - Creating confirmation for review
```
