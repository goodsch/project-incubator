# Voice Companion Skill Template

This template creates a voice-optimized Claude Code skill for your Project Incubator instance.

## What It Does

The voice companion skill transforms verbose MCP tool responses into speakable, mobile-friendly outputs. It handles:

- **Quick capture**: "I have an idea about X" → captures without interrupting flow
- **Status checks**: "What's next?" → single-sentence directives
- **Session continuity**: Automatic recaps when resuming
- **Notion sync**: Voice-triggered sync to your capture database

## Installation

### 1. Create the Skill Directory

```bash
mkdir -p ~/.claude/skills/YOUR-PROJECT-voice
```

### 2. Copy and Customize the Template

```bash
cp SKILL.md.template ~/.claude/skills/YOUR-PROJECT-voice/SKILL.md
```

### 3. Replace Placeholders

In your new `SKILL.md`, replace:

| Placeholder | Example | Description |
|-------------|---------|-------------|
| `{{PROJECT_NAME}}` | "Smart Garden" | Human-readable project name |
| `{{project_slug}}` | "garden" | MCP tool prefix (lowercase, no spaces) |

### 4. Register the Skill

Add to your Claude settings or skill registry. The skill will activate when:
- User mentions your project name
- User uses capture triggers ("new idea", "what's next", etc.)
- You're in a project-related conversation

## Customization

### Adding Custom Triggers

Edit the "Triggers" section to match your project's vocabulary:

```markdown
## Triggers

Activate when user says:
- "garden idea", "plant thought"
- "watering schedule", "sensor reading"
```

### Custom Capture Types

Match your workflow categories:

```markdown
| User Language | Capture Type |
|---------------|--------------|
| "plant", "species" | Research Question |
| "sensor", "hardware" | Resource |
| "automation", "schedule" | Follow-up |
```

### Phase-Specific Prompts

Customize opening/closing prompts for your domain:

```markdown
| Phase | Opening Prompt |
|-------|----------------|
| BRAINDUMP | "What plants are you thinking about?" |
| CAPTURE | "Walk me through the garden layout." |
```

## Voice Response Rules

**These rules are non-negotiable for voice interfaces:**

1. Maximum 2-3 sentences per response
2. No markdown formatting
3. No bullet points or lists
4. No technical jargon
5. Always end with a prompt

## Testing

Test your skill with these voice scenarios:

1. **Cold start**: "Start project called test garden"
2. **Rapid capture**: Say 5 ideas in quick succession
3. **Status check**: "Recap" after capturing
4. **Sync**: "Save to Notion"
5. **Resume**: Close and reopen, then "Where was I?"

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Skill not activating | Check trigger phrases match your speech patterns |
| Responses too long | Review and simplify response templates |
| Wrong capture type | Adjust user language mappings |
| Sync failing | Verify MCP server running and Notion configured |

## Related

- [MCP Server Template](../../mcp-server-template/) - The backend this skill talks to
- [Phase Commands](../../.claude/commands/) - Terminal equivalents of voice actions
