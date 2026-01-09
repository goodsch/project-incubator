# Archived Content Summary

This document catalogs valuable content that was archived during the template cleanup. Reference this when you need patterns or ideas from the original development process.

## Archive Location
`../Project-Incubator-Archive/` (not included in this repo)

---

## High-Value Content

### 1. Core Analysis Documents
**Location:** `archive/analysis/`

| File | Purpose | Key Insights |
|------|---------|--------------|
| `project_incubator_report.md` | Defines "Vibe Coding Failure Mode" | The core problem: creative ADHD minds are great at ideation but struggle with structure, persistence, and execution |
| `vibe_coding_profile.md` | Chris's cognitive profile | "Meta-System Architect" - excels at systems thinking but needs external structure |
| `vibecoding_patterns_report.md` | Interaction patterns | Session patterns, friction points, what works/doesn't |
| `virtual_chris_spec.md` | Test simulation spec | How to simulate user behavior for testing |

### 2. Notion Templates
**Location:** `archive/notion-template/`

**Most Valuable:**

| Template | Purpose | When to Use |
|----------|---------|-------------|
| `prd-template.md` | 25-question PRD structure | Detailed product requirements with quality gates |
| `ideation-canvas-template.md` | 4E Framework | Excavate → Expand → Examine → Extract process |
| `project-hub-template.md` | Project dashboard | Central navigation for project artifacts |
| `decision-log-template.md` | Decision tracking | Record decisions with rationale |

**The 4E Framework (from ideation-canvas):**
1. **E1: EXCAVATE** - Uncover raw material (what triggered it, what problem, emotional response)
2. **E2: EXPAND** - Explore adjacent territory (3 different solutions, 10x bigger/smaller)
3. **E3: EXAMINE** - Stress test (why not solved, failure modes, kill criteria)
4. **E4: EXTRACT** - Crystallize into WHAT/WHO/WHY statement

**PRD Structure (5 sections × 5 questions = 25 total):**
1. THE PROBLEM - moment, workaround, cost, frequency, severity
2. THE USER - person, role, budget, alternatives, trigger
3. THE SOLUTION - core, impossible, boundaries, magic, evidence
4. THE PROOF - metric, timeline, kill switch, comparison, target
5. THE PATH - test, V1 gate, V2 defer, risk, first step

### 3. Phase Skills
**Location:** `archive/.claude/skills/`

| Skill | Purpose | Key Patterns |
|-------|---------|--------------|
| `phase-capture/` | Voice-first idea capture | ADHD-optimized, zero friction, preserve raw voice |
| `phase-dream/` | Creative expansion | Lucid dream process for stuck ideas |
| `phase-braindump/` | Initial dump | Unstructured capture |
| `phase-expand/` | Systematic exploration | Adjacent territory mapping |
| `phase-specify/` | Technical specification | Convert ideas to specs |

**Key Pattern from phase-capture:**
- Accept any input without judgment
- Don't correct transcription quirks
- Parse intent over exact wording
- Keep responses short (voice users can't scroll)
- Celebrate progress, never shame

### 4. Project Ideas
**Location:** `archive/idea-shortlist.md`

Six project ideas with data models:
1. **Signal Garden** - Capture → cultivation → harvest
2. **Thread Steward** - Rescue half-started projects
3. **Meaning Map Studio** - Visual belief/question graph
4. **Ritual Forge** - Family ritual design
5. **Learning Campfire** - Kid questions → quests
6. **Home Signal Layer** - Ambient home ops

### 5. Testing Framework
**Location:** `archive/AGENTS.md`

Codex testing instructions including:
- tmux-cli for automated testing
- Chris persona simulation rules
- Interaction patterns to emulate
- Success criteria for tests

### 6. Project Type Templates
**Location:** `archive/templates/`

| Template | Purpose |
|----------|---------|
| `automation/` | Scheduled automation projects |
| `cli-tool/` | Command-line tool projects |
| `web-app/` | Web application projects |

---

## What Was NOT Archived (Kept)

- `docs/` - Current documentation
- `CLAUDE.md` - Will be rewritten for template
- `README.md` - Will be rewritten for template
- `.gitignore` - Standard config
- `.env.example` - Template for secrets

---

## How to Access Archived Content

```bash
# Navigate to archive (if available)
cd ../Project-Incubator-Archive

# Find specific content
grep -r "keyword" archive/

# Read a template
cat archive/notion-template/prd-template.md
```

---

## Recommended Extractions

When building new features, consider extracting:

1. **Quality Gate Pattern** - From PRD template, the section gates with pass/fail criteria
2. **ADHD-Optimized Prompts** - From phase-capture, the friction-reduction patterns
3. **4E Framework Questions** - From ideation-canvas, the systematic exploration questions
4. **Chris Persona Rules** - From AGENTS.md, for testing simulations
