# Scout Resources

**Optional** command for discovering project-specific resources beyond the prebuilt libraries.

## When to Use

Use this command during Phase 5 (CONFIGURE) when:
- The project has unusual tech stack requirements
- Prebuilt libraries don't cover the needed tools
- User wants to explore latest community resources

## Process

### Step 1: Identify Gaps

Review the project's architecture decisions and identify what's NOT covered by existing libraries:

```
Read: .claude/resources/skill-library.md
Read: .claude/resources/mcp-library.md
Read: .claude/resources/hooks-library.md
```

Compare against project requirements from:
- `projects/{name}/decisions/architecture.md`
- `projects/{name}/spec/vN.md`

### Step 2: Search for Resources

Use web search to find relevant Claude Code resources:

```
WebSearch: "Claude Code [tech-stack] skill"
WebSearch: "Claude Code MCP server [need]"
WebSearch: "site:github.com Claude Code [feature]"
```

Key repositories to check:
- https://github.com/anthropics/claude-code (official)
- https://github.com/modelcontextprotocol (MCP servers)
- https://github.com/topics/claude-code

### Step 3: Evaluate Candidates

For each discovered resource, assess:

| Criteria | Question |
|----------|----------|
| Relevance | Does it solve a gap in our libraries? |
| Quality | Is it well-documented and maintained? |
| Compatibility | Works with Claude Code current version? |
| Complexity | Appropriate for non-coder users? |

### Step 4: Document Findings

Create `projects/{name}/scouted-resources.md`:

```markdown
# Scouted Resources for {project-name}

Date: {date}
Reason: {why scouting was needed}

## Discovered Resources

### [Resource Name]
**Type:** Skill / MCP Server / Hook / Pattern
**Source:** {URL}
**Purpose:** {What it does}
**Evaluation:**
- Relevance: High/Medium/Low
- Quality: High/Medium/Low
- Complexity: Appropriate/Too Complex
**Recommendation:** Include / Skip
**Notes:** {Any adaptation needed}

## Summary

Resources to add to project config:
- {list}

Resources to potentially add to main libraries:
- {list}
```

### Step 5: Integration Decision

Ask user:
```
Found {N} relevant resources for this project.

Project-specific additions:
{list}

Should any be added to the main libraries for future projects?
{list with rationale}
```

## Output

- `projects/{name}/scouted-resources.md` - Discovery documentation
- Updates to `projects/{name}/config/` files if resources selected

## Notes

- This is OPTIONAL - prebuilt libraries cover most common cases
- Scouted resources require more user validation
- Consider proposing valuable discoveries for `/update-libraries`
