---
name: specify
description: PRD generation session for Phase 3. Transforms expansion into structured specification with versioning.
arguments:
  - name: project-name
    description: Name of the project (optional if only one project exists)
    required: false
---

# /specify

PRD generation session for Phase 3.

## Prerequisites

- Phase 2 (EXPAND) must be complete
- expansion.md must exist with all 6 questions answered

## Process

1. **Load the phase-specify skill**
   Use Skill tool with skill: "phase-specify"

2. **Review expansion.md**
   Ground the specification in the validated expansion

3. **Generate initial PRD (spec/v1.md)**

   Map expansion answers to PRD structure:
   - Question 1 (user) → Target User section
   - Question 2 (problem) → Problem Statement
   - Question 3 (success) → Success Criteria
   - Question 4 (features) → Features section
   - Question 5 (out of scope) → Out of Scope section
   - Question 6 (current state) → Context section

4. **For each feature, create:**
   - User story (As a..., I want to..., So that...)
   - Acceptance criteria (testable conditions)
   - Priority (Must Have / Should Have / Nice to Have)
   - Notes (edge cases, dependencies)

5. **Define user interaction model**
   - Primary workflows
   - Input/output formats
   - Error handling approach

6. **Review with user section by section**
   ```
   Here's the Overview section:

   [Show overview]

   Does this accurately capture the problem and user?
   Any adjustments needed?
   ```

7. **Iterate as needed**
   - Create v2.md for significant changes
   - Document what changed between versions

8. **Run completeness check**
   ```
   PRD Completeness Check:

   ✅ Overview (problem, user, success)
   ✅ Features (3 features with user stories)
   ✅ Acceptance criteria for each feature
   ✅ User interaction model
   ✅ In-scope items
   ✅ Out-of-scope items
   ⚠️ Technical constraints - needs more detail
   ✅ Open questions section

   Would you like to add technical constraints now?
   ```

9. **Get explicit approval**
   ```
   The PRD is ready for your approval.

   [Summary of spec]

   Do you approve this specification?
   (This will allow us to proceed to architecture)
   ```

## PRD Template

```markdown
# {Project Name} - Product Requirements Document

*Version: 1.0*
*Date: {timestamp}*
*Status: Draft*

## 1. Overview

### 1.1 Problem Statement
{From expansion Q2}

### 1.2 Target User
{From expansion Q1}

### 1.3 Success Criteria
{From expansion Q3}

## 2. Features

### 2.1 {Feature Name}
**Priority:** Must Have
**User Story:** As a {user}, I want to {action} so that {benefit}

**Description:**
{Detailed description}

**Acceptance Criteria:**
- [ ] {Criterion 1}
- [ ] {Criterion 2}

### 2.2 {Feature Name}
{Repeat for each feature from Q4}

## 3. User Interaction Model

### 3.1 Primary Workflows
{How user accomplishes key tasks}

### 3.2 Input/Output
{Data formats, interfaces}

## 4. Scope

### 4.1 In Scope
{Explicit inclusions}

### 4.2 Out of Scope
{From expansion Q5}

### 4.3 Technical Constraints
{Any known technical requirements}

## 5. Open Questions
{Decisions for architecture phase}
```

## Versioning

- **v1.md**: Initial generation from expansion
- **v2.md**: After first review iteration
- **vN.md**: Subsequent iterations

Never overwrite - always create new version.

## Example

```
User: /specify

Claude: Let me review your expansion...

        [Reads expansion.md]

        I'll now generate the initial PRD based on our
        exploration. This will be saved as spec/v1.md.

        Starting with the Overview...

        ---
        # Therapy Homework Tracker - PRD

        ## 1. Overview

        ### 1.1 Problem Statement
        Therapists lack visibility into whether clients complete
        homework assignments between sessions, making it difficult
        to adjust treatment plans and address non-completion.

        ### 1.2 Target User
        Primary: Adult therapy clients (25-55) in individual therapy
        - Often anxious, including about technology
        - Need extremely simple interfaces
        - May have executive function challenges

        Secondary: Therapists managing multiple clients
        - Need at-a-glance completion status
        - Want to identify patterns

        ---

        Does this Overview section capture it accurately?
```
