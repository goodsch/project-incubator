# Project Incubator Skills

Skills that guide the deterministic workflow through 6 phases.

## Phase Skills

| Skill | Phase | Enforcement | Purpose |
|-------|-------|-------------|---------|
| `phase-capture` | 1 | suggest | Guide initial idea capture |
| `phase-expand` | 2 | block | Socratic expansion with Clear Thought |
| `phase-specify` | 3 | block | PRD generation with completeness checks |
| `phase-architect` | 4 | block | Technical design with trade-off analysis |
| `phase-configure` | 5 | block | Claude Code configuration |
| `phase-seed` | 6 | block | Project generation |

## Support Skills

| Skill | Purpose |
|-------|---------|
| `clear-thought-guide` | How to use Clear Thought tools |

## Guardrail Enforcement

Skills with `enforcement: "block"` prevent:
- Skipping phases
- Proceeding with incomplete gates
- Generating output before validation

This is intentional - the friction ensures completeness.

## skill-rules.json

Defines activation triggers and enforcement levels for all skills.
Auto-activation hook reads this file to suggest relevant skills.

## Clear Thought Integration

Skills prescribe specific Clear Thought tools:

| Phase | Tool | Model |
|-------|------|-------|
| 2 (EXPAND) | mental_models | decomposition, abstraction-laddering |
| 4 (ARCHITECT) | mental_models | trade-off-matrix, pre-mortem |
| Any | thoughtbox | Complex multi-step reasoning |
