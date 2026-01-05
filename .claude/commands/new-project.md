---
name: new-project
description: Initialize a new project directory in Project Incubator. Creates project structure with CONTEXT.md, status.json, and required folders.
arguments:
  - name: project-name
    description: Name for the new project (lowercase, hyphens allowed)
    required: true
---

# /new-project

Initialize a new project directory.

## Process

1. **Validate project name**
   - Must be lowercase
   - Hyphens allowed, no spaces or special chars
   - Must not already exist

2. **Create project structure**
   ```
   projects/{project-name}/
   ├── CONTEXT.md           # User's idea scratchpad
   ├── status.json          # Phase tracking
   ├── spec/                # Versioned specifications
   ├── decisions/           # Architecture decisions
   ├── config/              # Claude Code configuration
   └── output/              # Generated project
   ```

3. **Initialize CONTEXT.md**
   ```markdown
   # {Project Name} - Raw Ideas

   *Created: {timestamp}*

   ## Your Idea

   [Describe your idea here. Don't worry about structure - just get it out of your head.]

   ## Notes

   [Any additional thoughts, inspirations, or context]
   ```

4. **Initialize status.json**
   ```json
   {
     "project": "{project-name}",
     "currentPhase": 1,
     "phaseName": "CAPTURE",
     "gates": {
       "capture": { "passed": false, "timestamp": null },
       "expand": { "passed": false, "timestamp": null },
       "specify": { "passed": false, "timestamp": null },
       "architect": { "passed": false, "timestamp": null },
       "configure": { "passed": false, "timestamp": null },
       "seed": { "passed": false, "timestamp": null }
     },
     "created": "{timestamp}",
     "lastUpdated": "{timestamp}"
   }
   ```

5. **Confirm creation**
   ```
   Project '{project-name}' created!

   Location: projects/{project-name}/

   Next steps:
   1. Open CONTEXT.md and dump your raw idea
   2. Run /status to see your progress
   3. When ready, run /validate to check Phase 1 gate
   ```

## Example

User: `/new-project wellness-tracker`

Creates: `projects/wellness-tracker/` with all initialization files.
