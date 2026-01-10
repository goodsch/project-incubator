---
name: specify
description: Phase 3 - Create detailed requirements (PRD) from expansion answers
---

# /specify - Phase 3

Transform expansion into structured specification (PRD).

## Prerequisites

- Phase 2 (EXPAND) complete
- expansion.md exists with all 6 questions answered

## Process

### 1. Review Expansion

Read expansion.md to ground the specification.

### 2. Generate Initial PRD

Create `spec/v1.md` mapping expansion answers:

| Expansion Question | PRD Section |
|-------------------|-------------|
| Q1 (user) | Target User |
| Q2 (problem) | Problem Statement |
| Q3 (success) | Success Criteria |
| Q4 (features) | Features |
| Q5 (out of scope) | Out of Scope |
| Q6 (current state) | Context |

### 3. PRD Template

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
**Priority:** Must Have | Should Have | Nice to Have
**User Story:** As a {user}, I want to {action} so that {benefit}

**Description:**
{Detailed description}

**Acceptance Criteria:**
- [ ] {Criterion 1}
- [ ] {Criterion 2}

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

### 4. For Each Feature

Create:
- User story (As a..., I want to..., So that...)
- Acceptance criteria (testable conditions)
- Priority (Must Have / Should Have / Nice to Have)
- Notes (edge cases, dependencies)

### 5. Review Section by Section

```
Here's the Overview section:

[Show overview]

Does this accurately capture the problem and user?
Any adjustments needed?
```

### 6. Iterate as Needed

- Create v2.md for significant changes
- Document what changed between versions
- Never overwrite - always create new version

> **⚡ PARALLEL EXECUTION:** Step 8 (Notion updates) can run in parallel with step 7 (completeness check) since they write to different targets.

### 7. Run Completeness Check

```
PRD Completeness Check:

✅ Overview (problem, user, success)
✅ Features (3+ features with user stories)
✅ Acceptance criteria for each feature
✅ User interaction model
✅ In-scope items
✅ Out-of-scope items
⚠️ Technical constraints - needs more detail
✅ Open questions section

Would you like to add technical constraints now?
```

### 8. Update Notion

Update SPECIFICATION section with PRD link and key requirements.
Update DECISIONS LOG with any decisions made.
Update PROJECT SNAPSHOT phase status.

### 9. Get Explicit Approval

```
The PRD is ready for your approval.

[Summary of spec]

Do you approve this specification?
(This will allow us to proceed to architecture)
```

## Gate Criteria for Phase 3

To advance to Phase 4:
- [ ] PRD exists in spec/ folder
- [ ] At least 3 features with user stories
- [ ] All features have acceptance criteria
- [ ] User explicitly approved the PRD

## Versioning

- **v1.md**: Initial generation from expansion
- **v2.md**: After first review iteration
- **vN.md**: Subsequent iterations

Never overwrite - always create new version.
