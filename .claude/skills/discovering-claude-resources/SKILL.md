---
name: discovering-claude-resources
description: Use when researching Claude Code ecosystem resources (skills, MCP servers, hooks, configurations, best practices) via Firecrawl. Triggers on "find resources", "discover tools", "research Claude Code", "what MCP servers exist", "find skills for [X]", "scout resources", or during Phase 5 CONFIGURE when gaps exist in prebuilt libraries.
---

# Discovering Claude Code Resources with Firecrawl

This skill uses Firecrawl MCP tools to systematically crawl Claude Code resource directories and linked repositories to discover, evaluate, and curate tools, skills, plugins, and configurations for projects.

## Primary Source

**https://awesomeclaude.ai** - Comprehensive directory of Claude AI resources including:
- Official Anthropic resources and documentation
- Community-curated lists (awesome-claude-code, skills, agents)
- MCP servers (78k+ repository)
- Extensions and integrations
- Educational resources and guides

## Firecrawl Tool Selection

| Tool | When to Use |
|------|-------------|
| `firecrawl_map` | First step - discover all URLs on a site |
| `firecrawl_scrape` | Get content from specific pages you've identified |
| `firecrawl_search` | Find resources across the web by topic |
| `firecrawl_agent` | Complex discovery requiring autonomous navigation |
| `firecrawl_extract` | Pull structured data (names, URLs, descriptions) |

## Discovery Workflow

### Step 1: Map the Directory

Start by mapping the primary source to discover all linked resources:

```
firecrawl_map:
  url: "https://awesomeclaude.ai"
  limit: 100
```

This returns an array of URLs. Filter for relevant sections:
- `/claude-code/` - Claude Code specific resources
- `/mcp/` - MCP servers
- `/skills/` or `/agents/` - Skills and agent configs
- GitHub links to repositories

### Step 2: Scrape Key Pages

For each relevant section, scrape the content:

```
firecrawl_scrape:
  url: "{discovered_url}"
  formats: ["markdown"]
  onlyMainContent: true
```

### Step 3: Follow GitHub Links

When GitHub repositories are found, scrape their READMEs:

```
firecrawl_scrape:
  url: "https://github.com/{owner}/{repo}"
  formats: ["markdown"]
```

Key files to check in repos:
- README.md - Overview and usage
- CLAUDE.md - Claude Code instructions
- .claude/skills/ - Skill definitions
- .claude/commands/ - Command definitions
- .claude/agents/ - Agent configs

### Step 4: Search for Specific Needs

When looking for resources for a specific project need:

```
firecrawl_search:
  query: "Claude Code {technology} skill site:github.com"
  limit: 10
```

Example queries:
- "Claude Code React skill site:github.com"
- "MCP server database site:github.com modelcontextprotocol"
- "Claude Code hooks authentication"

### Step 5: Extract Structured Data

For pages listing multiple resources, extract structured data:

```
firecrawl_extract:
  urls: ["{list_page_url}"]
  prompt: "Extract all Claude Code resources with name, description, URL, and category"
  schema: {
    "type": "object",
    "properties": {
      "resources": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "name": {"type": "string"},
            "description": {"type": "string"},
            "url": {"type": "string"},
            "category": {"type": "string"},
            "stars": {"type": "number"}
          }
        }
      }
    }
  }
```

## Evaluation Criteria

For each discovered resource, assess:

| Criterion | Questions |
|-----------|-----------|
| **Relevance** | Does it address a project need? |
| **Quality** | Well-documented? Actively maintained? |
| **Compatibility** | Works with current Claude Code version? |
| **Complexity** | Appropriate for the user's skill level? |
| **Adoption** | GitHub stars? Community usage? |

See `./evaluation-rubric.md` for detailed scoring.

## Output Format

Document discoveries in this format:

```markdown
# Resource Discovery: {topic}

**Date:** {date}
**Query:** {what was searched for}
**Sources Crawled:** {list of URLs}

## Discovered Resources

### Category: {category}

#### {Resource Name}
- **URL:** {url}
- **Type:** Skill / MCP Server / Hook / Pattern / Template
- **Description:** {description}
- **Evaluation:**
  - Relevance: High/Medium/Low
  - Quality: High/Medium/Low
  - Complexity: Simple/Moderate/Complex
- **Recommendation:** Include / Consider / Skip
- **Notes:** {any adaptation needed}

## Summary

**Recommended for inclusion:**
- {list}

**For consideration:**
- {list}

**Sources:**
- {urls crawled}
```

## Integration with Project Incubator

When used during Phase 5 (CONFIGURE):

1. Identify gaps in prebuilt resource libraries
2. Run this skill to discover missing resources
3. Evaluate discoveries against project requirements
4. Document in `projects/{name}/scouted-resources.md`
5. Update project config with selected resources

## Best Practice Curation

When curating best practices (not project-specific):

1. Map awesomeclaude.ai completely
2. Identify "best practices" and "guides" sections
3. Crawl official Anthropic documentation
4. Cross-reference community recommendations
5. Synthesize into actionable patterns

See `./crawl-patterns.md` for common crawl sequences.

## Rate Limiting

Firecrawl has usage limits. Be efficient:
- Use `firecrawl_map` before `firecrawl_crawl`
- Prefer targeted `firecrawl_scrape` over broad crawls
- Cache results mentally - don't re-crawl same URLs
- Use `maxAge` parameter for faster cached responses

## Fallback: WebFetch

If Firecrawl MCP tools are unavailable or erroring:

```
WebFetch:
  url: "{target_url}"
  prompt: "Extract all Claude Code resources, tools, skills, MCP servers, and best practices. Include URLs."
```

WebFetch provides similar functionality for single-page extraction. Use it to:
1. Fetch awesomeclaude.ai main page for directory overview
2. Scrape individual GitHub repos for README content
3. Extract best practices from documentation pages

Limitation: WebFetch cannot map sites or crawl multiple pages automatically - do those sequentially.

## Pre-Curated Output

See `.claude/resources/claude-code-best-practices.md` for a curated compilation of configuration best practices discovered from:
- awesome-claude-code (19.2k★)
- Claude-Code-Everything-You-Need-to-Know (640★)
- claude-code-tips (411★)
- awesome-claude-code-subagents (6.8k★)
