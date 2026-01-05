---
name: advance
description: Attempt to advance to the next phase. Runs validation first - blocks if gate criteria not met.
arguments:
  - name: project-name
    description: Name of the project (optional if only one project exists)
    required: false
---

# /advance

Attempt to advance to the next phase.

## Process

1. **Run /validate first**
   - If validation fails, show failure message and stop
   - Cannot advance without passing validation

2. **If validation passes:**
   - Update status.json with gate passed timestamp
   - Increment currentPhase
   - Update phaseName

3. **Show transition message**

## Transition Messages

### Phase 1 → 2 (CAPTURE → EXPAND)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ PHASE 1 (CAPTURE) COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Your idea has been captured!

Advancing to Phase 2: EXPAND

In this phase, we'll explore your idea systematically
by answering 6 macro questions:

1. Who is the primary user?
2. What is the core problem?
3. What does success look like?
4. What are the essential features?
5. What is out of scope?
6. What does this replace/complement?

Run /expand to begin the Socratic dialogue.

Clear Thought tools will be used for:
- decomposition (breaking down the idea)
- abstraction-laddering (why vs how)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Phase 2 → 3 (EXPAND → SPECIFY)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ PHASE 2 (EXPAND) COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Your idea has been fully explored!

Advancing to Phase 3: SPECIFY

In this phase, we'll transform your expanded
understanding into a formal PRD with:

- Feature specifications
- User stories
- Acceptance criteria
- Scope boundaries

Run /specify to generate the initial PRD.

Specs will be versioned (v1.md, v2.md, etc.)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Phase 3 → 4 (SPECIFY → ARCHITECT)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ PHASE 3 (SPECIFY) COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Your specification is complete!

Advancing to Phase 4: ARCHITECT

In this phase, we'll design the technical
implementation:

- Project type
- Tech stack
- Directory structure
- Data model
- External dependencies
- Deployment model

Run /architect to begin technical design.

Clear Thought tools will be used for:
- trade-off-matrix (comparing options)
- pre-mortem (identifying risks)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Phase 4 → 5 (ARCHITECT → CONFIGURE)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ PHASE 4 (ARCHITECT) COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Your architecture is designed!

Advancing to Phase 5: CONFIGURE

In this phase, we'll determine the Claude Code
configuration for your output project:

- CLAUDE.md content
- Skills to include
- Commands to create
- Agents to configure
- MCP server recommendations

Run /configure to begin configuration design.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Phase 5 → 6 (CONFIGURE → SEED)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ PHASE 5 (CONFIGURE) COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Your Claude Code configuration is ready!

Advancing to Phase 6: SEED

In this final phase, we'll generate your
complete project directory with:

- All configuration files
- Documentation
- Source scaffolding
- Ready-to-use workspace

Run /seed to generate your project!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Phase 6 Complete

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎉 PROJECT COMPLETE: {project-name}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Your project has been fully generated!

Output location:
projects/{project-name}/output/

Contents:
- CLAUDE.md (project instructions)
- README.md (human documentation)
- .claude/ (skills, commands, agents)
- docs/ (PRD, architecture, workflow)
- src/ (source structure)

Next steps:
1. Copy the output/ directory to your desired location
2. Run 'claude' in that directory
3. Start building!

The docs/WORKFLOW.md file has your vibe coding guide.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Blocked Advancement

If validation fails:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
❌ CANNOT ADVANCE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Phase {N} ({PHASE_NAME}) gate criteria not met.

Missing:
{list of failed checks}

Complete the requirements above before advancing.
Run /validate to check your progress.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
