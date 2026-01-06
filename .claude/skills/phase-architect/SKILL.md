---
name: phase-architect
description: Phase 4 of Project Incubator. Technical architecture design. Uses Clear Thought trade-off-matrix and pre-mortem models. Documents all architecture decisions with rationale. Guardrail blocks configuration until architecture validated.
---

# Phase 4: ARCHITECT

## Purpose

Design the technical implementation based on the validated PRD. Make and document all architecture decisions with clear rationale.

## Prerequisites

- Phase 3 (SPECIFY) must be complete
- PRD must pass completeness checklist
- User must have approved the specification

## Architecture Decisions

**ALL must be made and documented:**

### 1. Project Type
- Web application (SPA, SSR, static)
- CLI tool
- Desktop application
- Mobile application
- Backend service/API
- Automation/workflow
- Hybrid

### 2. Tech Stack
- Programming language(s)
- Framework(s)
- Key libraries
- Build tools

### 3. Directory Structure
- Source organization
- Module/component structure
- Configuration locations
- Test organization

### 4. Data Model (if applicable)
- Entities and relationships
- Storage approach (DB, files, API)
- Data flow

### 5. External Dependencies
- APIs to integrate
- Services to use
- Third-party tools

### 6. Deployment Model
- Local only
- Self-hosted
- Cloud platform
- Distribution method

## Clear Thought Integration

**MANDATORY: Use these tools during architecture:**

### For Comparing Options
```
Use mcp__clear-thought__mental_models with:
- operation: "get_model"
- args: { "model": "trade-off-matrix" }
```
Apply when choosing between tech stack options, frameworks, or approaches.

### For Risk Identification
```
Use mcp__clear-thought__mental_models with:
- operation: "get_model"
- args: { "model": "pre-mortem" }
```
Apply to identify what could go wrong with the chosen architecture.

### For Complex Decisions
```
Use mcp__clear-thought__thoughtbox for multi-step technical analysis
```

## Process

### Step 1: Review PRD
Understand the requirements that drive architecture decisions.

### Step 2: Identify Constraints
From the PRD, extract:
- Technical constraints
- Performance requirements
- User technical ability (affects complexity)
- Integration requirements

### Step 3: Generate Options
For each architecture decision:
- List 2-3 viable options
- Note pros/cons of each
- Consider user's familiarity/preferences

### Step 4: Evaluate with Trade-off Matrix
Use Clear Thought `trade-off-matrix` to compare options:
- Define evaluation criteria
- Score each option
- Document the winning choice and why

### Step 5: Risk Analysis
Use Clear Thought `pre-mortem`:
- "Imagine this project failed. Why?"
- Identify architectural risks
- Document mitigations

### Step 6: Document Decisions

**File: `decisions/architecture.md`**

```markdown
# Architecture Decisions

*Date: [timestamp]*
*Based on: spec/vN.md*

## 1. Project Type
**Decision:** [Choice]
**Rationale:** [Why this choice]
**Alternatives Considered:** [What else was evaluated]

## 2. Tech Stack

### Language
**Decision:** [Choice]
**Rationale:** [Why]

### Framework
**Decision:** [Choice]
**Rationale:** [Why]
**Trade-off Analysis:** [Reference to trade-off matrix]

### Key Libraries
- [Library]: [Purpose]
- [Library]: [Purpose]

## 3. Directory Structure
```
[project-name]/
├── src/
│   ├── [structure]
├── tests/
├── docs/
└── ...
```
**Rationale:** [Why this structure]

## 4. Data Model
[Entity diagram or description]
**Storage:** [Approach]
**Rationale:** [Why]

## 5. External Dependencies
| Dependency | Purpose | Risk Level |
|------------|---------|------------|
| [API/Service] | [Why needed] | [Low/Med/High] |

## 6. Deployment Model
**Decision:** [Choice]
**Rationale:** [Why]
**Requirements:** [What's needed to deploy]

## Risk Analysis

### Identified Risks
1. [Risk]: [Mitigation]
2. [Risk]: [Mitigation]

### Pre-mortem Results
[Summary of pre-mortem analysis]
```

### Step 7: User Review
Walk through decisions with user:
- Confirm understanding
- Validate choices align with their preferences
- Get explicit approval

## Gate Criteria

Phase 4 is complete when:
- [ ] All 6 architecture decisions documented
- [ ] Each decision has rationale
- [ ] Trade-off matrix used for at least one decision
- [ ] Pre-mortem analysis completed
- [ ] User has approved the architecture

## What NOT to Do

- Don't over-engineer for hypothetical futures
- Don't choose complex stacks for simple projects
- Don't assume user knows technologies - explain choices
- Don't skip risk analysis
- Don't forget to consider user's ability to maintain

## User Ability Consideration

Since users may be non-coders:
- Prefer simpler stacks when possible
- Consider "vibe coding" friendliness
- Document learning curve for each technology
- Note which decisions can be changed later

## Transition to Phase 5

When gate criteria are met:
"Architecture complete! You have a technical design. Ready to configure the Claude Code setup for this project? Run `/advance` to move to Phase 5 (CONFIGURE)."
