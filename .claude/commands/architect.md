---
name: architect
description: Technical architecture session for Phase 4. Uses Clear Thought trade-off-matrix and pre-mortem. Documents all decisions with rationale.
arguments:
  - name: project-name
    description: Name of the project (optional if only one project exists)
    required: false
---

# /architect

Technical architecture session for Phase 4.

## Prerequisites

- Phase 3 (SPECIFY) must be complete
- PRD must be approved

## Process

1. **Load the phase-architect skill**
   Use Skill tool with skill: "phase-architect"

2. **Review approved PRD**
   Extract technical requirements and constraints

3. **Work through 6 architecture decisions**

   ### Decision 1: Project Type
   ```
   Based on your PRD, this could be:
   - Web application (accessible anywhere)
   - Mobile app (native experience)
   - Desktop application
   - CLI tool
   - Hybrid approach

   Given your users' needs, I recommend: [recommendation]

   What are your thoughts?
   ```

   ### Decision 2: Tech Stack
   ```
   Let me use the trade-off matrix to compare options...
   ```

   **MANDATORY:** Use Clear Thought trade-off-matrix
   ```
   mcp__clear-thought__mental_models
   - operation: "get_model"
   - args: { "model": "trade-off-matrix" }
   ```

   Apply to:
   - Framework options
   - Language choices
   - Database options (if applicable)

   Document:
   - Options considered
   - Evaluation criteria
   - Scores
   - Winner and rationale

   ### Decision 3: Directory Structure
   ```
   Based on the tech stack, here's a proposed structure:

   [Show structure]

   This follows [pattern] because [reason].
   ```

   ### Decision 4: Data Model
   ```
   Your features require tracking:
   - [Entity 1]
   - [Entity 2]
   - [Relationships]

   Storage approach: [recommendation]
   ```

   ### Decision 5: External Dependencies
   ```
   Based on features, you'll need:
   - [Dependency 1]: for [purpose]
   - [Dependency 2]: for [purpose]

   Any concerns about these?
   ```

   ### Decision 6: Deployment Model
   ```
   For your use case, deployment options:
   - [Option 1]: [pros/cons]
   - [Option 2]: [pros/cons]

   Recommendation: [choice] because [reason]
   ```

4. **Run pre-mortem analysis**

   **MANDATORY:** Use Clear Thought pre-mortem
   ```
   mcp__clear-thought__mental_models
   - operation: "get_model"
   - args: { "model": "pre-mortem" }
   ```

   ```
   Let's imagine this project failed. Why might that happen?

   Potential failure modes:
   1. [Risk]: [Likelihood] / [Impact]
      Mitigation: [Strategy]

   2. [Risk]: [Likelihood] / [Impact]
      Mitigation: [Strategy]
   ```

5. **Document in decisions/architecture.md**

6. **Review with user**
   ```
   Architecture Summary:

   - Type: {choice}
   - Stack: {choice}
   - Key risks: {identified risks}

   Do you approve this architecture?
   ```

## Clear Thought Integration

**MANDATORY:**

1. **trade-off-matrix** for tech stack decisions
2. **pre-mortem** for risk identification
3. **thoughtbox** for complex technical reasoning

## Vibe Coding Consideration

Since user may be non-coder:
- Explain technical choices in plain language
- Note learning curve for each technology
- Prefer simpler stacks unless complexity is justified
- Document which decisions can be changed later

## Example

```
User: /architect

Claude: Let me review the approved PRD...

        Based on your requirements:
        - Simple interface for anxious users
        - Therapist dashboard
        - No complex integrations

        Decision 1: Project Type

        I recommend a Progressive Web App (PWA):
        - Works on any device with a browser
        - Can be "installed" without app stores
        - Simpler than native mobile development
        - Good offline support possible

        Does this approach work for you?

User: Yes, that makes sense.

Claude: Great! Now for the tech stack.

        Let me use the trade-off matrix to compare options...

        [Uses Clear Thought trade-off-matrix]

        Comparing frontend frameworks:

        Criteria: Learning curve, ecosystem, simplicity, docs
        Options: React, Vue, Svelte

        | Criteria      | React | Vue | Svelte |
        |--------------|-------|-----|--------|
        | Learning     | 3     | 4   | 5      |
        | Ecosystem    | 5     | 4   | 3      |
        | Simplicity   | 3     | 4   | 5      |
        | Docs         | 4     | 5   | 4      |
        | TOTAL        | 15    | 17  | 17     |

        Vue and Svelte tie. Given your goal of "vibe coding"
        and simplicity, I recommend Vue because:
        - Excellent documentation
        - Gentle learning curve
        - Large ecosystem for when you need it

        What do you think?
```
