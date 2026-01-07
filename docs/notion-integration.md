# Notion Integration

Technical details of the MCP integration with Notion.

## MCP Tool Reference

### Working Tools (mcp__notion__)

| Tool | Purpose | Example |
|------|---------|---------|
| `notion-search` | Find pages by query | `query: "Signal Garden"` |
| `notion-fetch` | Read page content | `id: "[page_id]"` |
| `notion-update-page` | Modify page content | See operations below |
| `notion-create-pages` | Create new pages | See creation below |

### Broken Tools (Avoid)

```
❌ mcp__notionApi__* - JSON stringification bug (issue #3084)
```

## Search Operations

```python
mcp__notion__notion-search(
    query="Signal Garden",
    query_type="internal"  # default
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

### Replace Entire Content
```python
mcp__notion__notion-update-page(
    data={
        "page_id": "[id]",
        "command": "replace_content",
        "new_str": "[full new content]"
    }
)
```

### Replace Content Range (Surgical Update)
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

**Important**: The `selection_with_ellipsis` must uniquely identify the text to replace. Include enough context on both ends.

### Insert After
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

### Update Properties
```python
mcp__notion__notion-update-page(
    data={
        "page_id": "[id]",
        "command": "update_properties",
        "properties": {
            "title": "New Title"
        }
    }
)
```

## Create Operations

### Create Page Under Parent
```python
mcp__notion__notion-create-pages(
    parent={
        "type": "page_id",
        "page_id": "[parent_id]"
    },
    pages=[{
        "properties": {"title": "Page Title"},
        "content": "[markdown content]"
    }]
)
```

## Page Structure Best Practices

### Tables
Notion renders markdown tables. Use consistent headers for AI parsing:

```markdown
| Component | Role | Status |
|-----------|------|--------|
| Auth | Handle login | idea |
```

### Code Blocks
Mermaid diagrams work in Notion:

```markdown
```mermaid
graph TD
    A --> B
```
```

### Checkboxes
```markdown
- [ ] Unchecked item
- [x] Checked item
```

### Sections
Use `---` for visual separation:
```markdown
## Section 1
Content

---

## Section 2
Content
```

## Common Update Patterns

### Update PROJECT SNAPSHOT
```python
# Update the status field in the snapshot table
mcp__notion__notion-update-page(
    data={
        "page_id": "[id]",
        "command": "replace_content_range",
        "selection_with_ellipsis": "| **Status** |...|\n| **Phase**",
        "new_str": "| **Status** | Designing |\n| **Phase**"
    }
)
```

### Add Component to Table
```python
mcp__notion__notion-update-page(
    data={
        "page_id": "[id]",
        "command": "replace_content_range",
        "selection_with_ellipsis": "| *None defined yet* |...|",
        "new_str": "| Auth Layer | Handle authentication | Credentials | Session token | idea |"
    }
)
```

### Add Decision
```python
mcp__notion__notion-update-page(
    data={
        "page_id": "[id]",
        "command": "insert_content_after",
        "selection_with_ellipsis": "| Decision | Options |...| Date |\n|",
        "new_str": "\n| Database choice | Postgres, SQLite, Mongo | Postgres | ACID compliance needed | 2026-01-07 |"
    }
)
```

### Add to Session Log
```python
mcp__notion__notion-update-page(
    data={
        "page_id": "[id]",
        "command": "insert_content_after",
        "selection_with_ellipsis": "| Date | Duration | What Changed |\n|",
        "new_str": "\n| 2026-01-07 | 30min | Defined core components |"
    }
)
```

## Error Handling

### "Selection not found"
The `selection_with_ellipsis` doesn't match. Solutions:
1. Fetch page to see current exact text
2. Use more characters in the selection
3. Check for escaped characters (`\[`, `\]` etc.)

### Timeout
Large content updates may timeout. Solutions:
1. Break into smaller updates
2. Use `insert_content_after` instead of full replace
3. Retry after short delay

### Page Not Found
1. Verify page ID is correct (check URL)
2. Search again to confirm page exists
3. Check permissions

## Mobile Workflow (No MCP)

When MCP isn't available, output paste-ready content:

```markdown
## Session Capture: [Project]
📅 2026-01-07

### Updates to Add

**COMPONENTS (add row):**
| Component | Role | Inputs | Outputs | Status |
|-----------|------|--------|---------|--------|
| [name] | [role] | [in] | [out] | idea |

**DECISIONS (add row):**
| Decision | Options | Chosen | Rationale | Date |
|----------|---------|--------|-----------|------|
| [what] | [opts] | [choice] | [why] | 2026-01-07 |

---
*Paste relevant sections into [Project] Design Doc*
```

User then:
1. Opens Notion on mobile
2. Navigates to project page
3. Edits relevant section
4. Pastes the formatted content
