# Skill Library

Available skills to include in output projects, sourced from production-tested repositories.

## Source: Claude Code Infrastructure Showcase

### skill-developer
**Purpose:** Meta-skill for creating and managing skills
**Best For:** Any project that needs custom skills
**Tech Requirements:** None
**Files:** SKILL.md + 6 resource files
**Copy From:** infrastructure-showcase/.claude/skills/skill-developer/

### backend-dev-guidelines
**Purpose:** Node.js/Express/TypeScript patterns
**Best For:** Backend APIs, microservices
**Tech Requirements:** Express, Prisma, TypeScript, Sentry
**Files:** SKILL.md + 12 resource files
**Copy From:** infrastructure-showcase/.claude/skills/backend-dev-guidelines/
**Adaptation:** Update for user's ORM, error tracking

### frontend-dev-guidelines
**Purpose:** React/TypeScript/MUI v7 patterns
**Best For:** React frontends
**Tech Requirements:** React 18+, MUI v7, TanStack Query/Router
**Files:** SKILL.md + 11 resource files
**Copy From:** infrastructure-showcase/.claude/skills/frontend-dev-guidelines/
**Adaptation:** Update for Vue/Svelte/other frameworks

### route-tester
**Purpose:** Test authenticated API routes
**Best For:** APIs with JWT authentication
**Tech Requirements:** JWT cookie-based auth
**Files:** SKILL.md
**Copy From:** infrastructure-showcase/.claude/skills/route-tester/

### error-tracking
**Purpose:** Sentry integration patterns
**Best For:** Production applications
**Tech Requirements:** Sentry
**Files:** SKILL.md
**Copy From:** infrastructure-showcase/.claude/skills/error-tracking/

## Source: Claude Development Agents

### Agents (Copy as-is)

| Agent | Purpose | Best For |
|-------|---------|----------|
| code-architecture-reviewer | Review code structure | After features |
| code-refactor-master | Plan refactoring | Code cleanup |
| documentation-architect | Generate docs | All projects |
| debugging-agent | Single-bug diagnosis | Troubleshooting |
| plan-reviewer | Review dev plans | Before implementation |
| refactor-planner | Create refactor strategies | Legacy code |
| web-research-specialist | Research tech issues | Problem solving |

### Slash Commands (Copy as-is)

| Command | Purpose |
|---------|---------|
| /backup | Create repository backup |
| /containerize | Add Docker support |
| /debug | Debugging workflow |
| /devserver | Start dev environment |

## Custom Skills to Create

For projects without matching library skills, create custom skills following:

### Structure
```
skill-name/
├── SKILL.md           # <500 lines, main guide
└── resources/         # Deep-dive files
    ├── topic-1.md     # <500 lines each
    └── topic-2.md
```

### SKILL.md Template
```markdown
---
name: skill-name
description: Brief description with trigger keywords. Include topics, file types, use cases.
---

# Skill Name

## Purpose
What this skill helps with

## When to Use
Specific scenarios

## Key Information
Guidance, patterns, examples
```

## Skill Selection Matrix

| Project Type | Recommended Skills |
|--------------|-------------------|
| Web App (React) | frontend-dev-guidelines, error-tracking |
| Web App (Vue) | frontend-dev-guidelines (adapted), error-tracking |
| API/Backend | backend-dev-guidelines, route-tester, error-tracking |
| CLI Tool | skill-developer (for custom) |
| Automation | skill-developer (for custom) |
| Full Stack | frontend + backend + error-tracking |

## skill-rules.json Pattern

From infrastructure-showcase - enables auto-activation:

```json
{
  "version": "1.0",
  "skills": {
    "skill-name": {
      "type": "domain",
      "enforcement": "suggest",
      "priority": "high",
      "promptTriggers": {
        "keywords": ["keyword1", "keyword2"],
        "intentPatterns": ["(create|add).*?pattern"]
      },
      "fileTriggers": {
        "pathPatterns": ["src/**/*.ts"],
        "pathExclusions": ["**/*.test.ts"]
      }
    }
  }
}
```
