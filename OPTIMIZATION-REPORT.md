# Project Incubator Optimization Report

**Cross-Analysis: Template vs Trellis-Fresh Instance**
**Date:** 2026-01-09
**Method:** Cognitive Profile lens from cognitive-gateway MCP

---

## Executive Summary

Trellis-Fresh evolved significant capabilities that should be backported to the Project-Incubator template. These align directly with the cognitive friction patterns defined in the cognitive-gateway MCP.

**Key Finding:** The template provides structure but the instance discovered that structure alone doesn't reduce cognitive load. The instance evolved **externalization mechanisms** that prevent friction before it occurs.

---

## Cognitive Profile Alignment Matrix

### Friction Patterns vs Solutions

| Friction Pattern | Template Coverage | Trellis-Fresh Innovation | Gap |
|------------------|-------------------|--------------------------|-----|
| **Decision Paralysis** | Directive prompts | Dream cycles offer pre-computed options | Add dream cycles |
| **Context Collapse** | Notion state | CONTEXT.md + /resume + /snapshot | Add resume/snapshot commands |
| **First-Step Paralysis** | /whats-next | Voice-first single directive + trellis-voice skill | Add voice companion skill template |
| **Scope Creep** | Gate-checked phases | Anti-Lock-In guarantees explicit | Document anti-lock-in explicitly |
| **Frustration/Stuck** | None | Friction detection + Quick Dreams | Add friction detection |
| **Loss of Direction** | /status | Unified Interface Framework | Add dual-interface support |

---

## Major Backport Recommendations

### 1. AI Dream Cycles (`/dream` command) ⭐ HIGH PRIORITY

**What it does:**
- Transforms AI from "facilitator" to "creative collaborator"
- Structured ideation: Ground → Diverge → Converge → Crystallize → Offer
- Uses thoughtbox for 15-20 iterations with branching
- All output framed as offerings, not conclusions

**Why it matters (cognitive profile):**
- Addresses Decision Paralysis: pre-computes options with rationale
- Addresses Frustration/Stuck: provides escape valve when looping
- Addresses Loss of Direction: alignment check built-in

**Files to add:**
- `.claude/commands/dream.md`
- `docs/ai-creative-contribution.md`

---

### 2. MCP Server Template (`trellis-mcp/`) ⭐ HIGH PRIORITY

**What evolved:** Trellis-Fresh created a dedicated MCP server for voice capture with:
- `trellis_start` - Start project
- `trellis_recap` - Voice-optimized state summary
- `trellis_next` - Single directive action
- `trellis_capture` - Quick idea capture
- `trellis_advance` - Phase advancement
- `trellis_gaps` - Show blockers
- `trellis_notion_sync` - Persist to Notion

**Why it matters:**
- Voice interface cannot use slash commands
- MCP tools enable Claude Web/mobile native integration
- State management enables session continuity across interfaces

**Recommendation:**
Add `mcp-server-template/` with:
- FastMCP scaffolding
- Voice-optimized response patterns
- State management boilerplate
- Notion sync integration
- Deployment docs (systemd + cloudflare tunnel)

---

### 3. Voice Companion Skill Template ⭐ HIGH PRIORITY

**What evolved:** `~/.claude/skills/trellis-voice/SKILL.md`

**Why it matters (cognitive profile):**
- MCP gives tools, skill tells Claude HOW to use them
- Maps natural voice intents to MCP tool calls
- Enforces speakable responses (2-3 sentences max)
- Maintains capture momentum without interrogation

**Recommendation:**
Add `skill-template/voice-companion/` with:
- Intent mapping patterns
- Response length constraints
- Capture flow templates
- Session continuity patterns

---

### 4. Unified Interface Framework ⭐ MEDIUM PRIORITY

**What evolved:** `docs/unified-interface-framework.md`

**Core principle:** "Notion is the only source of truth. Both terminal and voice sessions read/write to same Notion pages."

**Key patterns to backport:**
- Voice-first output rules (15 words max per sentence)
- Session handoff protocol (terminal ↔ voice)
- Dual-format sections (voice paragraph + visual table)
- Fast re-entry (< 60 seconds orientation)
- Friction detection signals and responses

---

### 5. Anti-Lock-In Documentation ⭐ MEDIUM PRIORITY

**What evolved:** Explicit guarantees against premature commitment

**Principles:**
1. Marination log is CONCEPTUAL - explicitly marked
2. Dream output is OFFERED - framed as possibilities
3. Visual + Summary is truth - only confirmed items are real
4. User picks - AI proposes, user disposes
5. Journal is reference - past ideas don't constrain future

**Why it matters (cognitive profile):**
- Addresses Scope Creep: prevents half-baked ideas from becoming requirements
- Reduces Decision Paralysis: lower stakes = faster decisions

---

### 6. New Commands ⭐ MEDIUM PRIORITY

**Add to template:**

| Command | Purpose |
|---------|---------|
| `/dream` | Creative ideation cycle |
| `/resume` | Fast re-entry (< 60 sec) |
| `/snapshot` | Quick context capture |

---

### 7. CONTEXT.md File ⭐ LOW PRIORITY

**What evolved:** Separate file for current visual + summary

**Why:** Keeps working state distinct from project documentation

**Template change:** Add CONTEXT.md.template alongside CLAUDE.md.template

---

## Structural Changes to Template

### Current Template Structure
```
project-incubator/
├── .claude/commands/       # Phase + utility commands
├── braindump/              # Phase 0 materials
├── docs/                   # Reference documentation
├── notion-template/        # Notion page templates
├── skill-template/         # Voice skill templates (basic)
└── spec/                   # PRD and architecture
```

### Recommended New Structure
```
project-incubator/
├── .claude/commands/       # Phase + utility + NEW commands
│   ├── dream.md            # NEW
│   ├── resume.md           # NEW
│   └── snapshot.md         # NEW
├── braindump/
├── docs/
│   ├── ai-creative-contribution.md    # NEW
│   ├── unified-interface-framework.md # NEW
│   └── ... (existing)
├── mcp-server-template/    # NEW - MCP server scaffolding
│   ├── src/
│   │   ├── server.py       # FastMCP server
│   │   ├── notion_sync.py  # Notion integration
│   │   └── state.py        # Workflow state management
│   ├── state/
│   │   └── workflow.json
│   ├── README.md
│   └── requirements.txt
├── skill-template/
│   ├── voice-companion/    # NEW - Voice skill scaffolding
│   │   └── SKILL.md.template
│   └── ... (existing)
├── CONTEXT.md.template     # NEW
└── ... (existing)
```

---

## Implementation Priority

### Phase 1: Core Cognitive Support (Do First)
1. Add `/dream` command and `ai-creative-contribution.md`
2. Add `/resume` and `/snapshot` commands
3. Document anti-lock-in principles in README

### Phase 2: Voice Infrastructure
4. Create `mcp-server-template/` scaffolding
5. Create `skill-template/voice-companion/`
6. Add `unified-interface-framework.md`

### Phase 3: Polish
7. Add `CONTEXT.md.template`
8. Update `setup.sh` to generate MCP server and skill
9. Update README with new capabilities

---

## Cognitive Profile Validation

**After implementing these changes, the template should address:**

| Friction Pattern | Intervention | Status |
|------------------|--------------|--------|
| Decision Paralysis | Dream cycles + defaults | ✅ Covered |
| Context Collapse | /resume + /snapshot + CONTEXT.md | ✅ Covered |
| First-Step Paralysis | /whats-next + voice skill | ✅ Covered |
| Scope Creep | Anti-lock-in + gate-checking | ✅ Covered |
| Frustration/Stuck | Friction detection + Quick Dreams | ✅ Covered |
| Loss of Direction | Unified interface + /status | ✅ Covered |

---

## Success Metrics

The optimized template should enable:
- **< 60 second re-entry** from any interface
- **Seamless voice ↔ terminal** switching
- **Zero lost context** across sessions
- **Single directive** at every step
- **Escape valves** when stuck (dream cycles)
- **Remote voice capture** via MCP + Cloudflare tunnel

---

## Notes

This analysis was performed using:
- Cognitive Profile from `cognitive-gateway` MCP server
- Diff analysis between template and trellis-fresh instance
- Documentation review of evolved capabilities

The cognitive-gateway MCP server's `get_profile` tool provides the friction patterns and intervention rules that drove this analysis.
