# Update Libraries

Periodic maintenance command to refresh the prebuilt resource libraries with new discoveries and upstream changes.

## When to Use

Run this command:
- Monthly or quarterly for general maintenance
- After discovering valuable resources via `/scout-resources`
- When source repositories have significant updates
- When new Claude Code features are released

## Source Repositories

The resource libraries are derived from these sources:

| Library | Primary Sources |
|---------|-----------------|
| skill-library.md | claude-code-infrastructure-showcase, Claude-Development-Agents |
| mcp-library.md | modelcontextprotocol repos, community MCP servers |
| hooks-library.md | claude-code-infrastructure-showcase |
| context-patterns.md | Claude-Code-Context-Toolkit, CONTEXT.md, Claude-Spec-Starter |

## Process

### Step 1: Check Source Repositories

Fetch latest from each source:

```bash
# If local clones exist
cd ~/dev/github/clone/claude-code-infrastructure-showcase && git pull
cd ~/repos/Claude-Development-Agents && git pull
```

Or use WebFetch to check remote READMEs for changes.

### Step 2: Identify New Content

Compare current libraries against sources:

**For Skills:**
- New skills in infrastructure-showcase/.claude/skills/
- New agents in Claude-Development-Agents/.claude/agents/
- New commands in Claude-Development-Agents/.claude/commands/

**For MCP Servers:**
- New servers at https://github.com/modelcontextprotocol
- Community MCP servers gaining traction
- Official Anthropic MCP additions

**For Hooks:**
- New hook patterns in infrastructure-showcase
- New hook events in Claude Code releases

**For Context Patterns:**
- Updates to Context-Toolkit patterns
- New community patterns

### Step 3: Review Scouted Resources

Check the project's scouted-resources.md if it exists:

```bash
cat scouted-resources.md
```

Identify resources recommended for library addition.

### Step 4: Evaluate Additions

For each potential addition:

| Criteria | Threshold |
|----------|-----------|
| Used in 2+ projects | Strong candidate |
| Broadly applicable | Not project-specific |
| Well-maintained | Active repo, good docs |
| Non-coder friendly | Low complexity |

### Step 5: Update Libraries

Edit the relevant library file:

```
.claude/resources/skill-library.md
.claude/resources/mcp-library.md
.claude/resources/hooks-library.md
.claude/resources/context-patterns.md
```

Follow the existing format in each file.

### Step 6: Document Changes

Create/append to `.claude/resources/CHANGELOG.md`:

```markdown
# Resource Library Changelog

## {YYYY-MM-DD}

### Added
- skill-library.md: Added {skill} from {source}
- mcp-library.md: Added {server} for {use-case}

### Updated
- {library}: Updated {item} with new features

### Removed
- {library}: Removed {item} - {reason}

### Sources Checked
- claude-code-infrastructure-showcase: {commit/date}
- Claude-Development-Agents: {commit/date}
- modelcontextprotocol: {date}
```

### Step 7: Verify Integrity

After updates, validate:
- [ ] All library files are valid markdown
- [ ] No broken internal references
- [ ] Examples still accurate
- [ ] Compatibility notes current

## Inputs

Optional: Specify which libraries to update

```
/update-libraries --skills    # Only skill-library.md
/update-libraries --mcp       # Only mcp-library.md
/update-libraries --all       # All libraries (default)
```

## Output

- Updated `.claude/resources/*.md` files
- `.claude/resources/CHANGELOG.md` entry
- Summary of changes made

## Maintenance Schedule

Recommended cadence:
- **Monthly**: Quick check for new MCP servers
- **Quarterly**: Full library refresh
- **On-demand**: After valuable `/scout-resources` discoveries
