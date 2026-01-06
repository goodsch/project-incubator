---
name: init
description: Initialize this Project Incubator clone for a new project. Detects brain dump materials and routes to Phase 0 or Phase 1 accordingly. Sets up Notion integration if available.
arguments:
  - name: project-name
    description: Name for the project (used in Notion, CONTEXT.md, etc.)
    required: true
---

# /init

Initialize this Project Incubator clone for a new project.

## How It Works

This command detects whether you have brain dump materials ready:

```
braindump/ has files?
    ├── YES → Phase 0: Process materials first
    └── NO  → Phase 1: Start with capture
```

## Process

### Step 1: Check Brain Dump Folder

```bash
# Check if braindump/ contains any files (excluding .gitkeep)
files=$(find braindump/ -type f ! -name '.gitkeep' 2>/dev/null | wc -l)
```

### Step 2: Route Based on Content

**If braindump/ has files:**
1. Confirm project name with user
2. Initialize CONTEXT.md and status.json
3. Create Notion Ideation Canvas (if available)
4. Execute Phase 0: BRAINDUMP processing
   - Meta-analysis of all materials
   - Dream phase synthesis
5. Transition to Phase 1: CAPTURE when complete

**If braindump/ is empty:**
1. Confirm project name with user
2. Initialize CONTEXT.md and status.json
3. Create Notion Ideation Canvas (if available)
4. Begin Phase 1: CAPTURE directly

### Step 3: Initialize Project Files

**Create CONTEXT.md:**
```markdown
# {Project Name} - Raw Ideas

*Initialized: {timestamp}*
*Template: Project Incubator*

## Your Idea

[Describe your idea here. Don't worry about structure - just get it out of your head.]

## Notes

[Any additional thoughts, inspirations, or context]
```

**Create status.json:**
```json
{
  "project": "{project-name}",
  "currentPhase": 0 or 1,
  "phaseName": "BRAINDUMP" or "CAPTURE",
  "initialized": "{timestamp}",
  "braindumpDetected": true/false,
  "gates": {
    "braindump": { "passed": false, "timestamp": null, "skipped": true/false },
    "capture": { "passed": false, "timestamp": null },
    "expand": { "passed": false, "timestamp": null },
    "specify": { "passed": false, "timestamp": null },
    "architect": { "passed": false, "timestamp": null },
    "configure": { "passed": false, "timestamp": null },
    "seed": { "passed": false, "timestamp": null }
  },
  "lastUpdated": "{timestamp}"
}
```

### Step 4: Create Notion Integration (Optional)

If Notion MCP is available:

1. Create Ideation Canvas page with project name
2. Initialize Living Idea Dump List (empty)
3. Create Session Dashboard
4. Link to local project

```
mcp__notionApi__API-post-page to create:
- Page title: "{Project Name} - Ideation Canvas"
- Initialize all sections from template
- Include Living Idea Dump List
```

### Step 5: Confirm Initialization

**With brain dump materials:**
```
Project '{project-name}' initialized!

Detected {X} files in braindump/ folder.
Starting Phase 0: BRAINDUMP processing.

I'll analyze your materials to extract:
- Explicit ideas, goals, features
- Implicit needs and motivations
- Then enter dream phase for creative synthesis

Ready to begin processing?
```

**Without brain dump materials:**
```
Project '{project-name}' initialized!

No brain dump materials detected.
Starting Phase 1: CAPTURE.

Location: ./
Notion: [Link to Ideation Canvas if created]

Next steps:
1. Open CONTEXT.md and dump your raw idea
2. Use Living Idea Dump List in Notion for quick thoughts
3. Run /status to see your progress

Ready when you are!
```

## Brain Dump Materials

If you have materials to process, add them to `braindump/` BEFORE running `/init`:

**Supported materials:**
- Text files, markdown (`.txt`, `.md`)
- AI conversation exports (`.json`, `.txt`)
- Voice memo transcriptions
- Reference project descriptions
- Screenshots with annotations
- Any unstructured notes

**Folder structure:**
```
braindump/
├── notes.md              # Your scattered thoughts
├── claude-chat.json      # AI conversation export
├── voice-memo-1.txt      # Transcribed voice notes
├── reference-project.md  # Inspiration description
└── ideas/                # Subfolder of related ideas
    ├── feature-idea.md
    └── ux-thoughts.md
```

## Example Usage

**Fresh project (no materials):**
```
User: /init wellness-tracker

Claude: Project 'wellness-tracker' initialized!
No brain dump materials detected. Starting Phase 1: CAPTURE.
...
```

**With brain dump materials:**
```
User: /init wellness-tracker

Claude: Project 'wellness-tracker' initialized!
Detected 5 files in braindump/ folder.
Starting Phase 0: BRAINDUMP processing.

Materials found:
- notes.md (2.3 KB)
- chat-export.json (15 KB)
- voice-notes.txt (1.1 KB)

Ready to begin meta-analysis?
```

## After Initialization

- Run `/status` to see current phase and progress
- If in Phase 0, braindump processing begins automatically
- If in Phase 1, start capturing your idea in CONTEXT.md
- Use Living Idea Dump List in Notion for quick thoughts anytime
