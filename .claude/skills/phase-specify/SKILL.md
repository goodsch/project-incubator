---
name: phase-specify
description: Phase 3 of Project Incubator. Transforms expanded understanding into structured PRD. Uses versioned specifications (v1.md, v2.md). Completeness checklist enforced. Guardrail blocks architecture phase until PRD validated.
---

# Phase 3: SPECIFY

## Purpose

Transform the expanded understanding into a structured Product Requirements Document (PRD) that can guide implementation.

## Prerequisites

- Phase 2 (EXPAND) must be complete
- All 6 macro questions must be answered
- expansion.md must exist

## PRD Structure

**File: `projects/[name]/spec/v1.md`**

```markdown
# [Project Name] - Product Requirements Document

*Version: 1.0*
*Date: [timestamp]*
*Status: Draft*

## 1. Overview

### 1.1 Problem Statement
[From expansion: core problem]

### 1.2 Target User
[From expansion: primary user profile]

### 1.3 Success Criteria
[From expansion: measurable outcomes]

## 2. Features

### 2.1 [Feature Name]
**Priority:** Must Have | Should Have | Nice to Have
**User Story:** As a [user], I want to [action] so that [benefit]

**Description:**
[Detailed description]

**Acceptance Criteria:**
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

**Notes:**
[Implementation hints, edge cases, dependencies]

### 2.2 [Feature Name]
[Repeat structure for each feature]

## 3. User Interaction Model

### 3.1 Primary Workflows
[Step-by-step user journeys]

### 3.2 Input/Output Formats
[Data user provides, data user receives]

### 3.3 Error Handling
[How errors are communicated to user]

## 4. Constraints & Scope

### 4.1 In Scope
[Explicit list of what's included]

### 4.2 Out of Scope
[From expansion: explicit exclusions]

### 4.3 Technical Constraints
[Platform, performance, compatibility requirements]

### 4.4 Non-Functional Requirements
[Security, accessibility, performance targets]

## 5. Open Questions

[Decisions that need to be made during architecture/implementation]

## 6. Appendix

### 6.1 Glossary
[Terms specific to this project]

### 6.2 References
[Related documents, research, inspiration]
```

## Process

### Step 1: Review Expansion
Read `expansion.md` to ground the specification in validated understanding.

### Step 2: Generate Initial PRD
Create `spec/v1.md` using the template above:
- Map expansion answers to PRD sections
- Write user stories for each feature
- Define acceptance criteria

### Step 3: Review with User
Walk through the PRD section by section:
- Confirm accuracy
- Identify gaps
- Resolve ambiguities

### Step 4: Iterate
Create new versions as needed:
- `v1.md` → `v2.md` → `v3.md`
- Document what changed between versions
- Keep all versions (don't overwrite)

### Step 5: Validate Completeness

**Completeness Checklist:**
- [ ] Overview section complete (problem, user, success criteria)
- [ ] All essential features documented
- [ ] Each feature has user story + acceptance criteria
- [ ] User interaction model defined
- [ ] In-scope items listed
- [ ] Out-of-scope items listed
- [ ] Technical constraints documented
- [ ] No critical open questions remaining

## Versioning Rules

1. **Never overwrite** - Create new version files
2. **Document changes** - Add changelog at top of new version
3. **User approval** - Each version requires explicit user sign-off
4. **Final version** - Mark as "Status: Approved" when complete

## Gate Criteria

Phase 3 is complete when:
- [ ] PRD passes completeness checklist
- [ ] User has explicitly approved the specification
- [ ] No blocking open questions remain
- [ ] At least one feature has detailed acceptance criteria

## Clear Thought Integration

Use `mcp__clear-thought__thoughtbox` when:
- Resolving conflicting requirements
- Prioritizing features
- Defining acceptance criteria for complex features

## What NOT to Do

- Don't make technical decisions (that's Phase 4)
- Don't specify implementation details
- Don't choose technologies or frameworks
- Don't design database schemas
- Don't skip the user review step

## Transition to Phase 4

When gate criteria are met:
"Specification complete! You have a validated PRD. Ready to design the technical architecture? Run `/advance` to move to Phase 4 (ARCHITECT)."
