# Input Form Template

This template is used when Claude needs thoughtful input that benefits from async, phone-friendly interaction rather than terminal-based Q&A.

## When to Create an Input Form

- Questions requiring more than a quick selection
- Input that benefits from time to think
- Multiple related questions that build on each other
- Questions where context/explanation helps
- User is primarily mobile/phone-based

## Page Structure

```
# [Project Name] - Input Needed

> ⏳ **Status**: Awaiting Input | **Priority**: 🔴 High / 🟡 Medium / 🟢 Low
> **Phase**: [Current phase] | **Blocking**: [Yes/No]

---

## Why This Input Is Needed

[Context explaining why Claude needs this input, what decision it enables, and how it fits into the current phase]

---

## Questions

### 1. [Question Title]

**Context:** [Why this question matters, what it influences]

**Type:** [Short text / Long text / Selection / Yes-No / Rating 1-5]

**Options (if selection):**
- Option A: [description]
- Option B: [description]
- Option C: [description]

📝 **Your Response:**
> [User types here]

---

### 2. [Question Title]

**Context:** [Why this question matters]

**Type:** [Type]

📝 **Your Response:**
> [User types here]

---

### 3. [Question Title]

**Context:** [Why this question matters]

**Type:** [Type]

📝 **Your Response:**
> [User types here]

---

## Additional Thoughts (Optional)

> Any other context, ideas, or concerns you want to share about these questions?

[Free-form space]

---

## Form Metadata

| Field | Value |
|-------|-------|
| Created | [timestamp] |
| Created by | Claude Code |
| Session | [session identifier] |
| Needed for | [Phase X / specific decision] |
| Deadline | [if applicable] |
| Status | ⏳ Awaiting / ✅ Completed / ⏭️ Skipped |

---

*Claude will process your responses at the next session start.*
```

---

## How to Create in Notion

Using Notion MCP:

```javascript
// 1. Create the page
mcp__notionApi__API-post-page({
  parent: { page_id: "[ideation-canvas-id]" },
  properties: {
    title: [{ text: { content: "[Project] - Input Needed" } }]
  }
})

// 2. Add content blocks
mcp__notionApi__API-patch-block-children({
  block_id: "[new-page-id]",
  children: [
    // Status callout
    { type: "callout", callout: { rich_text: [{ text: { content: "⏳ Status: Awaiting Input | Priority: 🔴 High" } }] } },
    // Divider
    { type: "divider" },
    // Context heading
    { type: "heading_2", heading_2: { rich_text: [{ text: { content: "Why This Input Is Needed" } }] } },
    // Context paragraph
    { type: "paragraph", paragraph: { rich_text: [{ text: { content: "[context]" } }] } },
    // ... questions follow same pattern
  ]
})
```

---

## Question Type Guidelines

### Short Text
- Single concept answers
- Names, titles, brief descriptions
- Example: "What should we call this feature?"

### Long Text
- Explanations, rationale, detailed descriptions
- Multiple paragraphs acceptable
- Example: "Describe your ideal user workflow"

### Selection
- Mutually exclusive choices
- Provide 2-5 options with descriptions
- Example: "Which authentication method?"

### Yes-No
- Binary decisions
- Include context for implications
- Example: "Should this support offline mode?"

### Rating 1-5
- Prioritization, importance, confidence
- Define what each number means
- Example: "How important is real-time sync? (1=nice-to-have, 5=critical)"

---

## ADHD-Friendly Design Principles

1. **One question visible at a time** - Use dividers liberally
2. **Context before question** - Don't make user guess why it matters
3. **No time pressure** - "Answer when ready" is the default
4. **Mobile-optimized** - Short paragraphs, clear formatting
5. **Optional sections clearly marked** - Reduce perceived burden
6. **Status visible** - User knows what's pending vs complete

---

## Processing Form Responses

At session start, the hook should:

1. Find forms with status "Awaiting Input"
2. Check if responses have been added
3. Parse responses into structured format
4. Present to user: "I see you answered the form about X. Here's what I understood..."
5. Update form status to "Completed"
6. Integrate responses into project context
