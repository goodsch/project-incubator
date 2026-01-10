# Notion Integration

Technical details of the MCP integration with Notion for Project Incubator.

## MCP Server Setup

Add the Notion MCP server to your Claude Code configuration (`~/.claude/settings.json` or project `.mcp.json`):

```json
{
  "mcpServers": {
    "notion": {
      "type": "http",
      "url": "https://mcp.notion.com/mcp"
    }
  }
}
```

This uses Notion's official hosted MCP server. When you first use it, you'll be prompted to authenticate with your Notion account.

---

## MCP Tool Reference

### Working Tools (mcp__notion__)

| Tool | Purpose | Example |
|------|---------|---------|
| `notion-search` | Find pages by query | `query: "My Project"` |
| `notion-fetch` | Read page content | `id: "[page_id]"` |
| `notion-update-page` | Modify page content | See operations below |
| `notion-create-pages` | Create new pages | See creation below |

### Avoid

```
❌ mcp__notionApi__* - Known issues with JSON stringification
```

## Search Operations

```python
mcp__notion__notion-search(
    query="My Project Design Doc",
    query_type="internal"
)
```

Returns: List of matching pages with IDs, URLs, titles.

## Fetch Operations

```python
mcp__notion__notion-fetch(
    id="2e1ca94098f28115ae85e3e08f989eed"  # or full URL
)
```

Returns: Full page content in Notion-flavored Markdown.

## Update Operations

### Replace Content Range (Surgical Update)

Most common operation - replace a specific section:

```python
mcp__notion__notion-update-page(
    data={
        "page_id": "[id]",
        "command": "replace_content_range",
        "selection_with_ellipsis": "[first ~10 chars]...[last ~10 chars]",
        "new_str": "[replacement text]"
    }
)
```

**Important**: The `selection_with_ellipsis` must uniquely identify the text to replace.

### Insert After

Add content after a specific marker:

```python
mcp__notion__notion-update-page(
    data={
        "page_id": "[id]",
        "command": "insert_content_after",
        "selection_with_ellipsis": "[marker text]...",
        "new_str": "\n[content to insert]"
    }
)
```

### Replace Entire Content

Nuclear option - replaces everything:

```python
mcp__notion__notion-update-page(
    data={
        "page_id": "[id]",
        "command": "replace_content",
        "new_str": "[full new content]"
    }
)
```

## Design Doc Structure

The Project Incubator Design Doc has these sections:

### PROJECT SNAPSHOT

```markdown
## PROJECT SNAPSHOT

| Field | Value |
|-------|-------|
| **Status** | In Progress |
| **Current Phase** | 2 - EXPAND |
| **Last Touched** | 2026-01-07 |
| **Next Action** | Answer the 6 macro questions |

### Phase Progress

| Phase | Name | Status |
|-------|------|--------|
| 0 | INCUBATE | ⏭️ skipped |
| 1 | CAPTURE | ✅ complete |
| 2 | EXPAND | → in_progress |
| 3 | SPECIFY | ○ pending |
| 4 | ARCHITECT | ○ pending |
| 5 | CONFIGURE | ○ pending |
| 6 | SEED | ○ pending |
```

### THE IDEA

```markdown
## THE IDEA

**One-liner:** A tool that transforms voice rambles into structured project plans.

**The spark:** Realizing that ADHD brains need external structure, not more discipline.

**Core insight:** The structure itself is the product - AI provides the executive function.
```

### SYSTEM OVERVIEW

```markdown
## SYSTEM OVERVIEW

**Purpose:** Externalize project planning cognitive load for ADHD developers.

**Scope:**
- IN: Idea capture, expansion, specification, architecture, scaffolding
- OUT: Actual development, deployment, ongoing maintenance

**Key actors:** Developer (voice/text), Claude (AI), Notion (state)
```

### COMPONENTS

```markdown
## COMPONENTS

| Component | Role | Inputs | Outputs | Status |
|-----------|------|--------|---------|--------|
| Slash Commands | Phase navigation | User commands | Phase actions | defined |
| Notion MCP | State persistence | Updates | Synced pages | active |
| Voice Skill | Mobile access | Voice input | Paste-ready output | defined |
```

### Additional Sections

- **CONTEXT**: Raw thoughts and captured notes
- **OPEN QUESTIONS**: Unknowns to resolve
- **SPECIFICATION**: PRD content (Phase 3)
- **ARCHITECTURE**: Tech decisions (Phase 4)
- **CONFIGURATION**: Claude Code setup (Phase 5)
- **SEED OUTPUT**: Generated scaffold details (Phase 6)

## Common Update Patterns

### Update Phase Progress Table

```python
mcp__notion__notion-update-page(
    data={
        "page_id": "[id]",
        "command": "replace_content_range",
        "selection_with_ellipsis": "| 2 | EXPAND |...|\n| 3 |",
        "new_str": "| 2 | EXPAND | ✅ complete |\n| 3 |"
    }
)
```

### Update Current Phase in Snapshot

```python
mcp__notion__notion-update-page(
    data={
        "page_id": "[id]",
        "command": "replace_content_range",
        "selection_with_ellipsis": "| **Current Phase** |...|\n| **Last",
        "new_str": "| **Current Phase** | 3 - SPECIFY |\n| **Last"
    }
)
```

### Add Component to Table

```python
mcp__notion__notion-update-page(
    data={
        "page_id": "[id]",
        "command": "insert_content_after",
        "selection_with_ellipsis": "| Component | Role |...| Status |\n|",
        "new_str": "\n| Auth Layer | Handle user auth | Credentials | Session | idea |"
    }
)
```

### Add to CONTEXT Section

```python
mcp__notion__notion-update-page(
    data={
        "page_id": "[id]",
        "command": "insert_content_after",
        "selection_with_ellipsis": "## CONTEXT\n",
        "new_str": "\n### Session 2026-01-07\n\nDiscussed the core architecture...\n"
    }
)
```

## Error Handling

### "Selection not found"

The `selection_with_ellipsis` doesn't match. Solutions:
1. Fetch page to see current exact text
2. Use more characters in the selection
3. Check for escaped characters

### Timeout

Large content updates may timeout. Solutions:
1. Break into smaller updates
2. Use `insert_content_after` instead of full replace
3. Retry after short delay

### Page Not Found

1. Verify page ID is correct (check URL)
2. Search again to confirm page exists
3. Check MCP server is running

## Mobile Workflow (No MCP)

When MCP isn't available, output paste-ready content:

```markdown
📋 UPDATE FOR NOTION

**PROJECT SNAPSHOT - update Current Phase:**
| **Current Phase** | 2 - EXPAND |

**COMPONENTS - add row:**
| Auth Layer | Handle authentication | Credentials | Session | idea |

---
Paste into your Design Doc in Notion
```

User workflow:
1. Opens Notion on mobile
2. Navigates to project page
3. Edits relevant section
4. Pastes the formatted content

## Status Symbols Reference

Use these consistently in the Phase Progress table:

| Symbol | Meaning | When to Use |
|--------|---------|-------------|
| ✅ | Complete | Phase gate criteria met |
| → | Current | Phase in progress |
| ○ | Pending | Not yet started |
| ⏭️ | Skipped | Optional phase bypassed |
| ⏸️ | Paused | Started but on hold |

## Best Practices

1. **Always fetch before update** - Ensure you have current content
2. **Use surgical updates** - `replace_content_range` over full replace
3. **Confirm before writing** - Show user what will change
4. **Include enough context** - Make `selection_with_ellipsis` unique
5. **Update snapshot every session** - Keep orientation current
