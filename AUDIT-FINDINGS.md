# Project Incubator Audit Findings

*Audit Date: 2026-01-05*
*Auditor: Claude Code Systematic Review*

## Executive Summary

The Project Incubator workspace is well-architected with comprehensive documentation, ADHD-optimized workflows, and solid MCP tool integration patterns. However, several inconsistencies exist between components that need alignment, particularly around the Phase 0 (Dream) process.

**Overall Rating: 8/10** - Strong foundation, needs alignment fixes

---

## Critical Issues (Must
### 1. Phase 0 Output Path Mismatch

**Location:** CLAUDE.md (lines 36-39) vs phase-dream/SKILL.md

**Problem:** CLAUDE.md references incorrect output paths for Phase 0:
```
braindump/
├── extracted-insights.md   ← CLAUDE.md says this
└── dream-synthesis.md      ← CLAUDE.md says this
```

But phase-dream/SKILL.md actually outputs to:
```
spec/dream/
├── 00-meta-analysis.md
├── 01-deep-listening.md
├── 02-digging-deeper.md
├── 03-wild-imagination.md
└── 04-parallel-worlds.md

DREAM-SYNTHESIS.md  (at root)
```

**Impact:** User confusion, inconsistent documentation

**Fix:** Update CLAUDE.md lines 36-39 to match actual phase-dream outputs

---

### 2. Duplicate Phase 0 Skills (phase-braindump vs phase-dream)

**Location:** `.claude/skills/phase-braindump/` and `.claude/skills/phase-dream/`

**Problem:** Two competing skills for Phase 0:
- `phase-braindump`: Simpler 2-part process (Meta-Analysis + Dream Phase)
- `phase-dream`: Full 5-phase Lucid Dream process with Clear Thought integration

**Impact:** Ambiguity about which process to use

**Fix:** Either:
- A) Deprecate phase-braindump, use phase-dream exclusively
- B) Keep phase-braindump as "lite" version for simple projects
- C) Merge into one skill with abbreviated mode

**Recommendation:** Option A - phase-dream is more complete and well-tested

---

### 3. Missing skill-rules.json Entries

**Location:** `.claude/skills/skill-rules.json`

**Problem:** skill-rules.json is missing entries for:
- `phase-dream`
- `phase-braindump`

**Impact:** Phase 0 skills won't auto-activate or enforce guardrails

**Fix:** Add entries to skill-rules.json:
```json
"phase-dream": {
  "type": "domain",
  "enforcement": "suggest",
  "priority": "high",
  "promptTriggers": {
    "keywords": ["dream", "braindump", "materials", "accumulated"],
    "intentPatterns": [
      "process.*?materials",
      "dream.*?phase",
      "lucid.*?dream"
    ]
  },
  "fileTriggers": {
    "pathPatterns": ["braindump/*"]
  }
}
```

---

### 4. Missing /dream Command

**Location:** `.claude/commands/`

**Problem:** `/braindump` command exists but `/dream` command does not, despite phase-dream being the canonical skill

**Impact:** No command to invoke the Lucid Dream process directly

**Fix:** Create `/dream` command or update `/braindump` to load phase-dream skill

---

## Moderate Issues (Should Fix)

### 5. Hooks Use Placeholder Notion Integration

**Location:** `.claude/hooks/session-start.sh`, `session-end.sh`

**Problem:** Hooks output JSON structure but don't actually call Notion MCP:
```bash
# This would use Notion MCP - returning placeholder count
echo "0"
```

**Impact:** Notion integration is documented but not functional in hooks

**Fix:** Either:
- A) Remove Notion calls from hooks (let Claude handle via JSON hints)
- B) Implement actual Notion MCP calls in hooks

**Recommendation:** Option A - hooks should output guidance, Claude should make MCP calls

---

### 6. Voice Transcription Error Handling

**Location:** `.claude/hooks/prompt-submit.sh`

**Problem:** prompt-submit.sh detects complexity and destructive keywords but doesn't handle common voice transcription patterns:
- "too" vs "to" vs "two"
- Missing punctuation
- Run-on sentences
- Filler words ("um", "like", "you know")

**Impact:** Voice users may get unnecessary confirmations for transcription quirks

**Fix:** Add voice transcription patterns to prompt-submit.sh:
```bash
# Voice transcription cleanup patterns
FILLER_WORDS="um|uh|like|you know|basically|actually"
clean_voice_input() {
    local prompt="$1"
    echo "$prompt" | sed -E "s/\b($FILLER_WORDS)\b//gi"
}
```

---

### 7. phase-capture References Outdated Braindump Paths

**Location:** `.claude/skills/phase-capture/SKILL.md` (lines 34-39)

**Problem:** References `braindump/extracted-insights.md` and `braindump/dream-synthesis.md`

**Fix:** Update to reference `spec/dream/` and `DREAM-SYNTHESIS.md`

---

## Minor Issues (Nice to Fix)

### 8. CLAUDE.md Length (758 lines)

**Problem:** Main CLAUDE.md is very long, potentially causing context overhead

**Impact:** More tokens consumed on every session start

**Fix:** Consider splitting into:
- `CLAUDE.md` - Core workflow (300 lines)
- `.claude/docs/notion-integration.md` - Notion details
- `.claude/docs/adhd-patterns.md` - ADHD optimization details
- `.claude/docs/hooks-guide.md` - Hooks architecture

---

### 9. Missing Notion Templates

**Location:** `notion-template/` directory exists but content not audited

**Recommendation:** Ensure Notion page templates match documentation

---

## Voice Mode Effectiveness Assessment

### Strengths

1. **Voice-First Philosophy Well-Documented**
   - CLAUDE.md lines 416-436 clearly explain voice sources and behaviors
   - phase-capture skill has comprehensive voice-first design section

2. **ADHD Optimization Comprehensive**
   - Micro-chunking, celebration, no-shame patterns
   - Clear challenge → solution mapping
   - TodoWrite usage mandated

3. **Cross-Platform Workflow Clear**
   - Mobile → Notion → Desktop flow documented
   - Living Idea Dump List provides quick capture

4. **Response Length Guidance**
   - "Keep responses short (voice users can't scroll)"
   - ADHD-friendly response patterns documented

### Weaknesses

1. **No Voice Transcription Error Patterns**
   - prompt-submit.sh doesn't clean filler words
   - No handling for common speech-to-text errors

2. **Missing Voice-Specific Commands**
   - No `/voice-mode` toggle or indicator
   - No explicit short-response mode

3. **Notion Mobile Experience Not Tested**
   - Documentation assumes mobile works but no verification

### Voice Mode Improvement Recommendations

1. Add filler word cleaning to prompt-submit.sh
2. Create voice-friendly command aliases (`/s` for `/status`)
3. Add `--brief` flag support for commands
4. Test Living Idea Dump List on mobile Notion

---

## MCP Tool Utilization Assessment

### Clear Thought Tools

| Phase | Tool | Status |
|-------|------|--------|
| 0 (Dream) | thoughtbox, mental_models | Well-prescribed in phase-dream |
| 1 (Capture) | N/A | Correct - no CT needed |
| 2 (Expand) | mental_models (decomposition, abstraction-laddering) | Documented |
| 3 (Specify) | thoughtbox | Optional, documented |
| 4 (Architect) | mental_models (trade-off-matrix, pre-mortem) | Mandatory, documented |
| 5 (Configure) | thoughtbox | Optional, documented |
| 6 (Seed) | N/A | Correct - generation phase |

**Assessment:** Clear Thought integration is comprehensive and well-prescribed

### Notion MCP Tools

| Tool | Usage | Status |
|------|-------|--------|
| API-post-search | Find existing pages | Documented |
| API-patch-block-children | Append content | Documented |
| API-get-block-children | Read idea dump list | Documented |
| API-query-data-source | Query databases | Documented |

**Assessment:** Notion tools documented but hooks use placeholders

---

## Context Management Assessment

### Strengths

1. **Dual-File Pattern** (CONTEXT.md + CLAUDE.md) well-implemented
2. **Versioned Specs** (spec/v1.md, v2.md) pattern documented
3. **Status.json** for machine state tracking
4. **Living Idea Dump List** for external memory

### Weaknesses

1. **No Context Compaction Strategy**
   - No guidance on when to summarize/compact
   - Long sessions could fill context

2. **Missing Handoff Patterns**
   - No `/handoff` command for Project Incubator
   - Session continuity relies on Notion (optional)

### Recommendations

1. Add context size warnings to session-start hook
2. Create `/handoff` command for session continuity
3. Document when to use `/clear` vs continue

---

## Implementation Priority

### Immediate (Before Next Use) - COMPLETED

1. [x] Fix CLAUDE.md Phase 0 output paths (Critical Issue #1) - **FIXED**
2. [x] Add phase-dream to skill-rules.json (Critical Issue #3) - **FIXED**
3. [x] Create /dream command (Critical Issue #4) - **FIXED**

### Short-Term (This Week) - COMPLETED

4. [x] Decide on phase-braindump vs phase-dream (Critical Issue #2) - **RESOLVED: /braindump is now alias for /dream**
5. [x] Update phase-capture braindump references (Moderate Issue #7) - **FIXED**
6. [x] Add voice transcription patterns to prompt-submit.sh (Moderate Issue #6) - **FIXED**

### Medium-Term (This Month) - COMPLETED

7. [x] Clarify hooks Notion integration approach (Moderate Issue #5) - **FIXED: Rewrote hooks with real Notion MCP instructions**
8. [x] Consider CLAUDE.md modularization (Minor Issue #8) - **FIXED: Split into 5 modular docs, reduced from 773 to 350 lines**
9. [ ] Add context management commands

---

## Files Modified/Created by This Audit

### Created
- `AUDIT-FINDINGS.md` (this file)
- `.claude/commands/dream.md` - New canonical command for Phase 0 Lucid Dream
- `.claude/docs/notion-integration.md` - Session protocols, Living Idea Dump, Notion as UI layer
- `.claude/docs/adhd-patterns.md` - ADHD-optimized workflows, daily flow patterns
- `.claude/docs/hooks-guide.md` - Session hooks, external tool integration
- `.claude/docs/clear-thought-guide.md` - When and how to use Clear Thought MCP
- `.claude/docs/voice-design.md` - Voice-first design principles, transcription handling

### Modified
- `CLAUDE.md` - Modularized from 773 to 350 lines, references new modular docs
- `.claude/skills/skill-rules.json` - Added phase-dream activation rules
- `.claude/skills/phase-capture/SKILL.md` - Updated braindump references to DREAM-SYNTHESIS.md
- `.claude/commands/braindump.md` - Converted to alias for /dream
- `.claude/hooks/prompt-submit.sh` - Added voice transcription detection and cleaning
- `.claude/hooks/session-start.sh` - Rewrote with real Notion MCP integration instructions
- `.claude/hooks/session-end.sh` - Rewrote with real Notion MCP integration instructions

## Files Requiring Future Updates

- Consider adding context management commands

---

## Verification Checklist

After fixes are applied, verify:

- [ ] `/init` with braindump materials triggers phase-dream
- [ ] `/dream` command invokes phase-dream skill
- [ ] Phase-dream outputs appear in correct locations
- [ ] skill-rules.json properly activates phase-dream
- [ ] Voice input with filler words works smoothly
- [ ] Session start checks Living Idea Dump List
- [ ] Clear Thought tools work in each prescribed phase

---

*End of Audit Report*
