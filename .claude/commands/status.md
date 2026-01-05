---
name: status
description: Show current phase and gate status for a project. Displays progress through the 6-phase workflow.
arguments:
  - name: project-name
    description: Name of the project (optional if only one project exists)
    required: false
---

# /status

Display project status and phase progress.

## Process

1. **Identify project**
   - If project-name provided, use that
   - If only one project exists, use that
   - If multiple projects and no name, list projects and ask

2. **Read status.json**
   - Load current phase information
   - Load gate validation status

3. **Display status**

   ```
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   📊 PROJECT STATUS: {project-name}
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

   Current Phase: {N} - {PHASE_NAME}

   Phase Progress:
   ✅ 1. CAPTURE    - {passed/pending}
   ⬜ 2. EXPAND     - {passed/pending}
   ⬜ 3. SPECIFY    - {passed/pending}
   ⬜ 4. ARCHITECT  - {passed/pending}
   ⬜ 5. CONFIGURE  - {passed/pending}
   ⬜ 6. SEED       - {passed/pending}

   Gate Status: {Current gate criteria}

   Next Action: {What to do next}
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   ```

4. **Include gate criteria for current phase**

   Phase 1 (CAPTURE):
   - [ ] CONTEXT.md exists
   - [ ] Contains >50 words of substantive content

   Phase 2 (EXPAND):
   - [ ] All 6 macro questions answered
   - [ ] expansion.md created
   - [ ] User validated expansion

   Phase 3 (SPECIFY):
   - [ ] PRD completeness checklist passed
   - [ ] User approved specification

   Phase 4 (ARCHITECT):
   - [ ] All 6 architecture decisions documented
   - [ ] Trade-off analysis completed
   - [ ] Pre-mortem analysis completed

   Phase 5 (CONFIGURE):
   - [ ] CLAUDE.md content specified
   - [ ] Skills, commands, agents determined

   Phase 6 (SEED):
   - [ ] Output directory generated
   - [ ] All files validated

## Example Output

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 PROJECT STATUS: wellness-tracker
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Current Phase: 2 - EXPAND

Phase Progress:
✅ 1. CAPTURE    - passed (2024-01-15 10:30)
🔄 2. EXPAND     - in progress
⬜ 3. SPECIFY    - pending
⬜ 4. ARCHITECT  - pending
⬜ 5. CONFIGURE  - pending
⬜ 6. SEED       - pending

Gate Criteria (Phase 2):
- [x] Question 1: Primary user answered
- [x] Question 2: Core problem answered
- [ ] Question 3: Success criteria - NOT ANSWERED
- [ ] Question 4: Essential features - NOT ANSWERED
- [ ] Question 5: Out of scope - NOT ANSWERED
- [ ] Question 6: Current state - NOT ANSWERED

Next Action: Continue /expand to answer remaining questions
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
