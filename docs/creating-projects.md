# Creating New Project Skills

How to add a new project to the Project Incubator system.

## Quick Start

1. Create Notion page with Design Doc template
2. Create skill folder with SKILL.md
3. Test the integration

## Step 1: Create Notion Page

### Option A: Via Claude Code (MCP)
```python
mcp__notion__notion-create-pages(
    parent={"type": "page_id", "page_id": "HUB_PAGE_ID"},
    pages=[{
        "properties": {"title": "[Project Name] - Design Doc"},
        "content": "[Design Doc template content]"
    }]
)
```

### Option B: Manual
1. Open Project Incubator hub in Notion
2. Create new page: "[Project Name] - Design Doc"
3. Paste template from `~/.claude/skills/incubator-signalgarden/notion-template.md`
4. Get the page ID from the URL

## Step 2: Create Skill Folder

```bash
mkdir -p ~/.claude/skills/incubator-[projectname]
```

### Required Files

**SKILL.md** - Copy and modify from existing skill:
```bash
cp ~/.claude/skills/incubator-signalgarden/SKILL.md \
   ~/.claude/skills/incubator-[projectname]/SKILL.md
```

Update these fields:
```yaml
name: incubator-[projectname]
description: Voice-based project planning for [Project Name]. Use when user says "let's work on [Project Name]"...

project_name: "[Project Name]"
project_page_id: "[new page id]"
project_page_url: "[new page url]"
```

**voice-patterns.md** - Copy and update triggers:
```bash
cp ~/.claude/skills/incubator-signalgarden/voice-patterns.md \
   ~/.claude/skills/incubator-[projectname]/voice-patterns.md
```

Update trigger phrases:
```markdown
| "Let's work on [Project Name]" | Fetch page, present state |
| "Continue [Project Name]" | Same as above |
```

## Step 3: Test Integration

### Test 1: Search
```
"Search for [Project Name] in Notion"
```
Should find the new page.

### Test 2: Fetch
```
"Fetch the [Project Name] Design Doc"
```
Should return full page structure.

### Test 3: Skill Trigger
```
"Let's work on [Project Name]"
```
Should:
- Find and fetch the page
- Present PROJECT SNAPSHOT
- Offer guided or conversational mode

### Test 4: Update
Try a simple update:
```
"Add 'Test Component' to the components"
```
Should:
- Propose the update
- Wait for confirmation
- Apply to Notion

## Template Reference

### Design Doc Template

```markdown
## 🎯 PROJECT SNAPSHOT

| Field | Value |
|-------|-------|
| **Status** | Ideating |
| **Phase** | Capture |
| **Last touched** | [date] |
| **Next action** | Define the core idea |
| **Blockers** | None |

---

## 💡 THE IDEA

**One-liner:** [Not yet defined]

**The spark:** [What triggered this?]

**Core insight:** [The non-obvious thing]

---

## 🏗️ SYSTEM OVERVIEW

**Purpose:** [What problem does this solve?]

**Scope:**
- ✅ IN: [What's included]
- ❌ OUT: [What's excluded]

**Key actors:** [Who/what interacts?]

---

## 🧩 COMPONENTS

| Component | Role | Inputs | Outputs | Status |
|-----------|------|--------|---------|--------|
| *None yet* | | | | |

---

## 🔗 RELATIONSHIPS

*How do components connect?*

---

## 🚶 USER JOURNEYS

### Primary Flow
1. [Step 1]
2. [Step 2]

### Entry Points
- [How users get in]

---

## ✅ DECISIONS LOG

| Decision | Options | Chosen | Rationale | Date |
|----------|---------|--------|-----------|------|
| *None yet* | | | | |

---

## ❓ OPEN QUESTIONS

- [ ] [Question 1]
- [ ] [Question 2]

---

## 📋 NEXT ACTIONS

- [ ] [Action 1]
- [ ] [Action 2]

---

## 📜 SESSION LOG

| Date | Duration | What Changed |
|------|----------|--------------|
| [date] | - | Page created |
```

## Checklist

- [ ] Notion page created with Design Doc template
- [ ] Page ID captured
- [ ] Skill folder created at `~/.claude/skills/incubator-[name]/`
- [ ] SKILL.md created with correct project config
- [ ] voice-patterns.md created with project-specific triggers
- [ ] Search test passed
- [ ] Fetch test passed
- [ ] Skill trigger test passed
- [ ] Update test passed
