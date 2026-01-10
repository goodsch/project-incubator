---
name: architect
description: Phase 4 - Design system structure using trade-off analysis and risk assessment
---

# /architect - Phase 4

Design system structure with documented decision rationale.

## Prerequisites

- Phase 3 (SPECIFY) complete
- PRD approved in spec/ folder

## Process

### 1. Review Approved PRD

Extract technical requirements and constraints.

### 2. Work Through 6 Architecture Decisions

#### Decision 1: Project Type

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

#### Decision 2: Tech Stack

**MANDATORY: Use trade-off matrix**
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

#### Decision 3: Directory Structure

```
Based on the tech stack, here's a proposed structure:

[Show structure]

This follows [pattern] because [reason].
```

#### Decision 4: Data Model

```
Your features require tracking:
- [Entity 1]
- [Entity 2]
- [Relationships]

Storage approach: [recommendation]
```

#### Decision 5: External Dependencies

```
Based on features, you'll need:
- [Dependency 1]: for [purpose]
- [Dependency 2]: for [purpose]

Any concerns about these?
```

#### Decision 6: Deployment Model

```
For your use case, deployment options:
- [Option 1]: [pros/cons]
- [Option 2]: [pros/cons]

Recommendation: [choice] because [reason]
```

### 3. Run Pre-Mortem Analysis

**MANDATORY: Use pre-mortem**
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

> **⚡ PARALLEL EXECUTION:** Steps 4 and 5 (creating architecture.md and updating Notion) are independent. Execute both simultaneously.

### 4. Document Architecture

Create `spec/architecture.md`:

```markdown
# {Project Name} - Architecture

*Date: {timestamp}*

## Project Type
{Decision 1}

## Tech Stack
{Decision 2 with trade-off analysis}

## Directory Structure
{Decision 3}

## Data Model
{Decision 4}

## Dependencies
{Decision 5}

## Deployment
{Decision 6}

## Risk Analysis
{Pre-mortem results}
```

### 5. Update Notion

Update ARCHITECTURE section with key decisions.
Update DECISIONS LOG with all architectural decisions.
Update PROJECT SNAPSHOT phase status.

### 6. Review with User

```
Architecture Summary:

- Type: {choice}
- Stack: {choice}
- Key risks: {identified risks}

Do you approve this architecture?
```

## Gate Criteria for Phase 4

To advance to Phase 5:
- [ ] Architecture document exists in spec/
- [ ] Trade-off analysis documented for tech stack
- [ ] Pre-mortem analysis completed
- [ ] User approved architecture

## Vibe Coding Consideration

Since user may be non-coder:
- Explain technical choices in plain language
- Note learning curve for each technology
- Prefer simpler stacks unless complexity is justified
- Document which decisions can be changed later

## Clear Thought Integration

**MANDATORY:**
1. **trade-off-matrix** for tech stack decisions
2. **pre-mortem** for risk identification
3. **thoughtbox** for complex technical reasoning
