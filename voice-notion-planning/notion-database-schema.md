# Notion Database Schema Reference

This document defines the complete database schema for the Project Incubator Notion workspace.

## Database: Projects

**Purpose:** Track active research projects/think tanks

| Property | Type | Options/Format |
|----------|------|----------------|
| Name | Title | - |
| Status | Select | `Planning`, `Active`, `Paused`, `Complete` |
| Focus Area | Multi-select | User-defined (e.g., `Healthcare`, `Technology`, `Environment`, `Education`, `Finance`) |
| Created | Date | Date only |
| Last Updated | Date | Date only |
| Description | Text | Rich text |
| Repository | URL | GitHub repo link |

**Default View:** Table sorted by Last Updated (descending)

---

## Database: Research Prompts

**Purpose:** Capture and track research questions

| Property | Type | Options/Format |
|----------|------|----------------|
| Title | Title | Research question |
| Project | Relation | -> Projects |
| Stage | Select | `Drafting`, `Ready to Run`, `Completed`, `Archived` |
| Priority | Select | `High`, `Medium`, `Low` |
| Scope | Multi-select | User-defined geographic/temporal tags |
| Created | Date | Date created |
| Run Date | Date | When executed |
| Output Link | URL | Link to output |
| Notes | Text | Additional context |

**Page Template Blocks:**
```
## Research Question
[To be filled]

## Context
[Background information]

## Scope
- Geographic:
- Temporal:
- Topical:

## Expected Deliverables
-

## Analysis Approach
-

## Voice Notes
[Captured from voice input]
```

---

## Database: Ideas & Captures

**Purpose:** Quick capture of ideas during voice sessions

| Property | Type | Options/Format |
|----------|------|----------------|
| Idea | Title | Brief description |
| Type | Select | `Research Question`, `Resource`, `Connection`, `Follow-up`, `Random` |
| Project | Relation | -> Projects (optional) |
| Captured | Date | Auto-set to now |
| Processed | Checkbox | Default: unchecked |
| Action | Select | `Create Prompt`, `Add to Context`, `Research Later`, `Discard` |
| Full Notes | Text | Complete voice transcription |

**Default View:** Table filtered by Processed = false

---

## Database: Knowledge Base

**Purpose:** Track wiki entries and context files

| Property | Type | Options/Format |
|----------|------|----------------|
| Entry | Title | Topic/entry name |
| Type | Select | `Wiki`, `Context` |
| Category | Select | `Topics`, `Methodologies`, `Jurisdictions`, `Stakeholders`, `Terminology`, `Resources` |
| Project | Relation | -> Projects (for Context type) |
| Last Updated | Date | Most recent update |
| Needs Review | Checkbox | Flag for review |
| File Path | Text | Path in repo |

---

## Database: Outputs

**Purpose:** Track research outputs and their status

| Property | Type | Options/Format |
|----------|------|----------------|
| Title | Title | Output title |
| Type | Select | `Research`, `Batch`, `Report`, `Policy Doc` |
| Project | Relation | -> Projects |
| Prompt | Relation | -> Research Prompts |
| Stage | Select | `Draft`, `Review`, `Final`, `Published` |
| Date Created | Date | When generated |
| File Path | Text | Path in outputs folder |
| Export Status | Select | `None`, `PDF Pending`, `PDF Complete`, `Audio Pending`, `Audio Complete` |

---

## Database: Session Log

**Purpose:** Track planning sessions for continuity

| Property | Type | Options/Format |
|----------|------|----------------|
| Session | Title | Session identifier |
| Date | Date | Session date |
| Project | Relation | -> Projects (multi) |
| Summary | Text | What was discussed |
| Action Items | Text | Tasks to complete |
| Prompts Created | Number | Count |
| Ideas Captured | Number | Count |

---

## Common Notion API Patterns

### Creating a Database Item

```javascript
// Tool: notion_create_database_item
{
  "database_id": "abc123...",
  "properties": {
    "Title": {
      "title": [{ "text": { "content": "My Research Question" } }]
    },
    "Stage": {
      "select": { "name": "Drafting" }
    },
    "Priority": {
      "select": { "name": "Medium" }
    },
    "Created": {
      "date": { "start": "2025-01-05" }
    },
    "Notes": {
      "rich_text": [{ "text": { "content": "Voice notes here..." } }]
    }
  }
}
```

### Querying a Database

```javascript
// Tool: notion_query_database
{
  "database_id": "abc123...",
  "filter": {
    "property": "Stage",
    "select": { "equals": "Ready to Run" }
  },
  "sorts": [
    { "property": "Created", "direction": "descending" }
  ]
}
```

### Adding Content Blocks

```javascript
// Tool: notion_append_block_children
{
  "block_id": "page_id_here",
  "children": [
    {
      "object": "block",
      "type": "heading_2",
      "heading_2": {
        "rich_text": [{ "text": { "content": "Research Question" } }]
      }
    },
    {
      "object": "block",
      "type": "paragraph",
      "paragraph": {
        "rich_text": [{ "text": { "content": "What is the impact of..." } }]
      }
    },
    {
      "object": "block",
      "type": "bulleted_list_item",
      "bulleted_list_item": {
        "rich_text": [{ "text": { "content": "Geographic: North America" } }]
      }
    }
  ]
}
```

### Updating Page Properties

```javascript
// Tool: notion_update_page_properties
{
  "page_id": "page_id_here",
  "properties": {
    "Stage": {
      "select": { "name": "Ready to Run" }
    },
    "Run Date": {
      "date": { "start": "2025-01-05" }
    }
  }
}
```

### Searching for Pages

```javascript
// Tool: notion_search
{
  "query": "climate policy",
  "filter": {
    "property": "object",
    "value": "page"
  }
}
```

---

## Relations Map

```
Projects
    ↑
    ├── Research Prompts (many-to-one)
    ├── Ideas & Captures (many-to-one, optional)
    ├── Knowledge Base [Context type] (many-to-one)
    ├── Outputs (many-to-one)
    └── Session Log (many-to-many)

Research Prompts
    ↓
    └── Outputs (one-to-many)
```

---

## Setup Checklist

When setting up the workspace:

- [ ] Create Projects database
- [ ] Create Research Prompts database with relation to Projects
- [ ] Create Ideas & Captures database with relation to Projects
- [ ] Create Knowledge Base database with relation to Projects
- [ ] Create Outputs database with relations to Projects and Research Prompts
- [ ] Create Session Log database with relation to Projects
- [ ] Share all databases with Notion integration
- [ ] Note database IDs for MCP configuration
- [ ] Create useful views (Kanban, Calendar, etc.)
