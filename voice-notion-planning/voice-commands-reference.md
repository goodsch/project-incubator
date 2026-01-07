# Voice Commands Quick Reference

Natural language patterns for voice-based planning with Notion MCP.

## Session Management

| Say This | Action |
|----------|--------|
| "Start a planning session" | Creates Session Log entry, begins tracking |
| "Let's do some planning" | Same as above |
| "End session" / "We're done" | Summarizes session, updates counts |
| "What did we discuss last time?" | Retrieves most recent Session Log |
| "Continue where we left off" | Retrieves pending items from last session |

## Idea Capture

| Say This | Action |
|----------|--------|
| "I have an idea about [topic]" | Creates Ideas & Captures entry |
| "Quick thought: [idea]" | Same - quick capture mode |
| "Note this down: [content]" | Captures as-is |
| "Remind me to research [topic]" | Creates idea with Type = Research Later |
| "There's a connection between [A] and [B]" | Creates idea with Type = Connection |

## Research Prompts

| Say This | Action |
|----------|--------|
| "Create a research prompt for [question]" | Starts prompt creation workflow |
| "New research question: [question]" | Same as above |
| "I want to investigate [topic]" | Prompts for more details, then creates |
| "This prompt is ready to run" | Updates Stage to Ready to Run |
| "Move [prompt] to ready" | Same as above |
| "Archive [prompt]" | Updates Stage to Archived |

## Querying Status

| Say This | Action |
|----------|--------|
| "What prompts are ready?" | Queries Stage = Ready to Run |
| "Show me pending ideas" | Queries Processed = false |
| "What's in drafting?" | Queries Stage = Drafting |
| "Recent outputs for [project]" | Queries Outputs filtered by project |
| "What are our active projects?" | Queries Status = Active |
| "Status of [project]" | Retrieves project details |

## Knowledge Base

| Say This | Action |
|----------|--------|
| "Add [topic] to the wiki" | Creates Wiki entry |
| "Create a context entry for [topic]" | Creates Context entry |
| "Update [entry] with [info]" | Appends to existing entry |
| "What do we have on [topic]?" | Searches Knowledge Base |
| "Mark [entry] for review" | Sets Needs Review = true |

## Project Management

| Say This | Action |
|----------|--------|
| "Create a new project called [name]" | Creates Projects entry |
| "Set [project] to active" | Updates Status |
| "Pause [project]" | Updates Status to Paused |
| "Link this to [project]" | Adds Project relation |
| "What projects do we have?" | Lists all projects |

## Linking & Relations

| Say This | Action |
|----------|--------|
| "Link that to [project]" | Updates relation to project |
| "This relates to [prompt]" | Links idea to prompt |
| "Associate with [topic]" | Adds relation |
| "What's connected to [item]?" | Queries relations |

## Processing Ideas

| Say This | Action |
|----------|--------|
| "Let's review pending ideas" | Iterates through unprocessed ideas |
| "Turn that into a prompt" | Promotes idea to Research Prompt |
| "Add to context" | Sets Action, marks processed |
| "Discard that one" | Marks processed, Action = Discard |
| "Save for later" | Action = Research Later |

## Conversational Modifiers

| Say This | Effect |
|----------|--------|
| "High priority" | Sets Priority = High |
| "This is urgent" | Sets Priority = High |
| "Low priority / backburner" | Sets Priority = Low |
| "For the [project] project" | Links to specified project |
| "In the [category] category" | Sets Category property |

## Examples of Natural Conversations

### Creating a Research Prompt

**User:** "I want to research how different countries handle drug scheduling"

**Claude:** "I'll create a research prompt for that. What geographic scope - specific countries or regions?"

**User:** "Focus on US, UK, and the Netherlands"

**Claude:** "Got it. Any specific aspects - medical access, enforcement, recent reforms?"

**User:** "Mainly medical access pathways"

**Claude:** "Created a research prompt: 'Comparative analysis of drug scheduling and medical access pathways in US, UK, and Netherlands'. It's in drafting - want me to mark it ready or add more details?"

### Quick Idea Capture

**User:** "Oh, I just thought of something - we should look at WHO guidelines too"

**Claude:** "Captured that idea about WHO guidelines. Should I link it to the drug scheduling prompt?"

**User:** "Yes"

**Claude:** "Done. Linked to the drug scheduling research."

### Session Review

**User:** "What did we work on last session?"

**Claude:** "Last session on January 3rd you captured 4 ideas, created 2 prompts about healthcare policy, and marked 1 prompt as ready. You also had an action item to review the EU regulations context file - still pending."
