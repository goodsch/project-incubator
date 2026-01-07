# Clear Thought MCP Integration

How to leverage mental models from Clear Thought MCP during ideation sessions.

## When to Use Mental Models

Mental models provide structured thinking frameworks. Use them at specific moments in ideation:

| Moment | Model | Purpose |
|--------|-------|---------|
| Clarifying the core idea | Abstraction Laddering | Find right level of abstraction |
| Exploring possibilities | Constraint Relaxation | Break limiting assumptions |
| Testing the idea | Pre-Mortem | Anticipate failures |
| Finding root issues | Five Whys | Dig to true cause |
| Making trade-offs | Trade-off Matrix | Explicit comparison |
| Checking blind spots | Adversarial Thinking | Find weaknesses |
| Breaking down complexity | Decomposition | Manageable pieces |
| Prioritizing features | Opportunity Cost | What you give up |

---

## Model Applications in Ideation

### Phase 2 (Clarify): Abstraction Laddering

**When:** User describes idea at wrong level (too vague or too specific)

**How to invoke:**
```
mcp__clear-thought__mental_models:
  operation: get_model
  args:
    model: abstraction-laddering
```

**Application:**
- **Ladder UP (Why?)**: "Why would someone want this?" → reveals true value
- **Ladder DOWN (How?)**: "How would this actually work?" → reveals implementation
- Find the level where user has clarity and energy

**Notion Update:** Add abstraction ladder visualization to Design Schema

---

### Phase 3 (Expand): Constraint Relaxation

**When:** User seems stuck or limited by assumptions

**How to invoke:**
```
mcp__clear-thought__mental_models:
  operation: get_model
  args:
    model: constraint-relaxation
```

**Application:**
- "What if budget wasn't a constraint?"
- "What if you had 10x the time?"
- "What if the technology didn't exist yet?"
- Identify which constraints are real vs assumed

**Notion Update:** Add to Assumptions Log with constraint type

---

### Phase 4 (Challenge): Pre-Mortem

**When:** Entering challenge phase, testing the idea's viability

**How to invoke:**
```
mcp__clear-thought__mental_models:
  operation: get_model
  args:
    model: pre-mortem
```

**Application:**
- "Imagine it's 6 months from now and this project failed. What happened?"
- Guide user through failure scenarios
- Identify preventable failure modes
- Create mitigation strategies

**Notion Update:** Add failure modes to Gap Tracker with prevention notes

---

### Phase 4 (Challenge): Five Whys

**When:** Surface concern needs deeper investigation

**How to invoke:**
```
mcp__clear-thought__mental_models:
  operation: get_model
  args:
    model: five-whys
```

**Application:**
- User: "I'm worried about adoption"
- Why? → "People might not understand it"
- Why? → "It's a new category"
- Why is that a problem? → "No reference point"
- Why does that matter? → "Can't explain in one sentence"
- Why? → "Core value prop unclear"
- ROOT CAUSE: Value proposition needs work

**Notion Update:** Add root cause to Gap Tracker, link symptoms

---

### Phase 4 (Challenge): Adversarial Thinking

**When:** Idea seems too clean, need to stress test

**How to invoke:**
```
mcp__clear-thought__mental_models:
  operation: get_model
  args:
    model: adversarial-thinking
```

**Application:**
- "If you were a competitor, how would you beat this?"
- "If a user wanted to abuse this, how would they?"
- "What would a harsh critic say?"
- "Where could this cause harm?"

**Notion Update:** Add adversarial insights to Gap Tracker

---

### Phase 5 (Synthesize): Trade-off Matrix

**When:** Multiple options need comparison for decisions

**How to invoke:**
```
mcp__clear-thought__mental_models:
  operation: get_model
  args:
    model: trade-off-matrix
```

**Application:**
Build comparison matrix for key decisions:
- Feature prioritization
- Technical approach selection
- Market positioning
- Resource allocation

**Notion Update:** Add matrix to Design Schema decisions section

---

### Phase 5 (Synthesize): Opportunity Cost

**When:** Prioritizing what to include in MVP

**How to invoke:**
```
mcp__clear-thought__mental_models:
  operation: get_model
  args:
    model: opportunity-cost
```

**Application:**
- "If we include X, what can't we do?"
- "What's the cost of NOT doing Y first?"
- "What doors does this close?"
- Make trade-offs explicit

**Notion Update:** Add opportunity costs to feature priorities

---

### Throughout: Decomposition

**When:** Any concept feels too big or vague

**How to invoke:**
```
mcp__clear-thought__mental_models:
  operation: get_model
  args:
    model: decomposition
```

**Application:**
- Break "the app" into components
- Break "users" into personas
- Break "features" into capabilities
- Break "launch" into phases

**Notion Update:** Create hierarchical structure in Design Schema

---

## Using Thoughtbox for Complex Reasoning

For multi-step reasoning during ideation, use the thoughtbox tool:

```
mcp__clear-thought__thoughtbox:
  thought: "User wants [X] but constraints suggest [Y]. Let me work through this..."
  nextThoughtNeeded: true
  thoughtNumber: 1
  totalThoughts: 5
```

**Use Cases:**
- Working through conflicting requirements
- Evaluating technical feasibility
- Exploring non-obvious solutions
- Processing complex user input

**Best Practice:** Share reasoning summary in conversation, full chain available in session for context.

---

## Integration Pattern

### Lightweight Touch (Default)
- Apply mental model thinking without formal invocation
- Mention framework in conversation: "Let me think about this like a pre-mortem..."
- Update Notion with structured output

### Deep Dive (When Stuck)
- Formally invoke the mental model MCP tool
- Work through full framework
- Document reasoning in Notion
- Share key insights with user

### Example Conversation Flow

**User:** "I want it to be simple but also really powerful"

**Claude's internal process:**
1. Detect tension (Connections Map)
2. Note in Gap Tracker as conflict
3. Consider: Abstraction Laddering to find right level?
4. Consider: Trade-off Matrix to make explicit?

**Claude's response:**
"That's an interesting tension - simple AND powerful. Let me think about this... [uses abstraction laddering internally]

Usually 'simple' means different things at different levels. The UI can be simple while the underlying system is powerful. Or the core workflow is simple but advanced features exist for power users.

Which resonates more with your vision?"

**Notion Update:** Add tension to Connections Map, create Design Schema note about simplicity approach

---

## Mental Model Quick Reference

For fast lookup during conversation:

| Need | Model | Key Question |
|------|-------|--------------|
| Find the real problem | Five Whys | "Why?" (5x) |
| Explore freely | Constraint Relaxation | "What if X wasn't a limit?" |
| Test viability | Pre-Mortem | "How could this fail?" |
| Make decisions | Trade-off Matrix | "What are we comparing?" |
| Break it down | Decomposition | "What are the parts?" |
| Find the level | Abstraction Laddering | "Why?" (up) / "How?" (down) |
| Stress test | Adversarial Thinking | "How would an enemy attack?" |
| Prioritize | Opportunity Cost | "What do we give up?" |
| Find root cause | Five Whys | "Why?" (until root) |
