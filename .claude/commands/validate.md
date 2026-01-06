---
name: validate
description: Check if current phase gate criteria are met. Must pass validation before advancing to next phase.
---

# /validate

Check if current phase gate criteria are met.

## Process

1. **Identify project and current phase**

2. **Run phase-specific validation**

### Phase 1 (CAPTURE) Validation

Check:
- [ ] `CONTEXT.md` exists (at project root)
- [ ] File contains >50 words (excluding headers/metadata)
- [ ] Content is substantive (not just placeholders)

Pass criteria: All checks pass

### Phase 2 (EXPAND) Validation

Check:
- [ ] All 6 macro questions have answers in expansion.md:
  1. Primary user defined
  2. Core problem articulated
  3. Success criteria specified
  4. Essential features listed (3-5)
  5. Out of scope items listed
  6. Current state/integration described
- [ ] Clear Thought tools were used (check for evidence)
- [ ] User has validated expansion (look for confirmation)

Pass criteria: All questions answered and validated

### Phase 3 (SPECIFY) Validation

Check PRD completeness:
- [ ] Overview section (problem, user, success)
- [ ] Features section with user stories
- [ ] Each feature has acceptance criteria
- [ ] User interaction model defined
- [ ] In-scope items listed
- [ ] Out-of-scope items listed
- [ ] Technical constraints documented
- [ ] User has approved spec

Pass criteria: All sections present and approved

### Phase 4 (ARCHITECT) Validation

Check architecture decisions:
- [ ] Project type decided
- [ ] Tech stack specified
- [ ] Directory structure defined
- [ ] Data model documented (if applicable)
- [ ] External dependencies listed
- [ ] Deployment model chosen
- [ ] Trade-off matrix used
- [ ] Pre-mortem completed
- [ ] User approved architecture

Pass criteria: All decisions documented with rationale

### Phase 5 (CONFIGURE) Validation

Check configuration:
- [ ] CLAUDE.md content specified
- [ ] Skills list finalized
- [ ] Commands list finalized
- [ ] Agents list finalized
- [ ] MCP recommendations documented
- [ ] User approved configuration

Pass criteria: All config elements specified

### Phase 6 (SEED) Validation

Check output:
- [ ] Output directory created
- [ ] CLAUDE.md generated
- [ ] README.md generated
- [ ] All skills copied/created
- [ ] All commands copied/created
- [ ] All agents copied/created
- [ ] Documentation complete
- [ ] Source structure scaffolded

Pass criteria: All files present and valid

## Output Format

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔍 VALIDATION: Phase {N} - {PHASE_NAME}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Checking gate criteria...

✅ CONTEXT.md exists
✅ Content length: 127 words (>50 required)
✅ Substantive content detected

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ VALIDATION PASSED

Run /advance to proceed to Phase 2 (EXPAND)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Or if failed:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔍 VALIDATION: Phase {N} - {PHASE_NAME}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Checking gate criteria...

✅ CONTEXT.md exists
❌ Content length: 23 words (<50 required)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
❌ VALIDATION FAILED

Missing requirements:
- CONTEXT.md needs more content (23/50 words minimum)

Action: Add more detail to your idea in CONTEXT.md
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
