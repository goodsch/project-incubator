# iOS Quick Capture Setup

Capture ideas from your iPhone directly into your Project Incubator's Quick Capture database using iOS Shortcuts.

## Why Database-Based Capture?

Project Incubator uses a **Notion database** (not a page) for Quick Capture because:

1. **iOS Shortcuts integration** - Notion's Shortcut actions work with databases
2. **Siri support** - "Hey Siri, capture idea" for hands-free capture
3. **Structured data** - Type classification, processed status, timestamps
4. **Easy filtering** - Claude queries unprocessed items at session start

## Quick Setup (2 minutes)

### Step 1: Open Shortcuts App

On your iPhone, open the **Shortcuts** app.

### Step 2: Create New Shortcut

1. Tap the **+** icon in the top right
2. Tap **Add Action**
3. Search for "**Ask for Input**"
4. Configure:
   - Prompt: "What do you want to capture?"
   - Input Type: Text

### Step 3: Add Notion Action

1. Tap **+** to add another action
2. Search for "**Notion**"
3. Select "**Create Document Without Opening**"
4. Configure:
   - Database: Select your Quick Capture database
   - Title: Tap "Provided Input" from the previous step
   - (Optional) Type: Set a default like "💡 Idea"

### Step 4: Name and Save

1. Tap the dropdown at the top
2. Name it: "Capture Idea" (or "Quick Capture", etc.)
3. Tap **Done**

### Step 5: Add to Home Screen (Optional)

1. Open your new shortcut
2. Tap the **...** menu
3. Tap **Add to Home Screen**
4. Choose an icon and add

## Advanced: Voice Capture

For hands-free capture while driving, walking, etc.:

### Option A: Siri Voice Input

1. Edit your shortcut
2. Change "Ask for Input" to "**Dictate Text**"
3. Save

Now say: "Hey Siri, Capture Idea" and speak your thought.

### Option B: Type Selection Shortcut

Create a shortcut that asks for type first:

```
1. Ask for Input (Text): "What do you want to capture?"
2. Choose from Menu:
   - 💡 Idea
   - 🐛 Issue
   - ✨ Feature
   - ❓ Question
   - 📝 Note
3. Create Document Without Opening:
   - Database: Quick Capture
   - Title: [Provided Input from step 1]
   - Type: [Menu Result from step 2]
```

## Database Schema Reference

Your Quick Capture database has these properties:

| Property | Type | Purpose |
|----------|------|---------|
| **Capture** | Title | The captured thought |
| **Type** | Select | 💡 Idea, 🐛 Issue, ✨ Feature, ❓ Question, 📝 Note |
| **Processed** | Checkbox | Claude marks true after review |
| **Created** | Created time | Auto-set when added |

## How Claude Uses Quick Capture

At the start of each planning session, Claude:

1. **Queries** the Quick Capture database for unprocessed items
2. **Displays** any captures to review with you
3. **Processes** each capture (categorizes, adds to Design Doc if relevant)
4. **Marks** items as Processed when done

This ensures nothing captured between sessions gets lost.

## Troubleshooting

### "Database not found" in Shortcuts

- Make sure your Notion integration has access to the workspace
- Try searching for the database name instead of selecting from list

### Captures not showing in Claude sessions

- Check that you're looking at the right project's Quick Capture
- Verify the database ID in your project's `status.json`
- Make sure items have `Processed = false`

### Want offline capture?

Consider the [Instant Notion](https://instantnotionapp.com/) app which:
- Works offline, syncs when online
- Supports multiple databases
- Has a widget for quick access

## Third-Party Apps

These apps also work well with Notion databases:

| App | Best For | Cost |
|-----|----------|------|
| **Instant Notion** | Offline capture | Paid |
| **Notion native** | Simple captures | Free |
| **Drafts** | Text processing then send to Notion | Paid |

## Example Workflow

1. **Walking to car:** "Hey Siri, Capture Idea" → "Add user onboarding wizard"
2. **In meeting:** Open shortcut → Type quick note
3. **Next Claude session:** "Let's work on MyProject"
4. **Claude:** "📥 You captured 3 things since last session..."
5. **Review together:** Categorize, add to Design Doc, or dismiss
