# Firecrawl Patterns for Claude Resources

Common crawl sequences for different discovery goals.

## Pattern 1: Full Directory Discovery

**Goal:** Complete inventory of resources from awesomeclaude.ai

```
1. firecrawl_map:
     url: "https://awesomeclaude.ai"
     limit: 200

2. For each category URL found:
   firecrawl_scrape:
     url: "{category_url}"
     formats: ["markdown"]
     onlyMainContent: true

3. For GitHub repo links:
   firecrawl_scrape:
     url: "{github_url}"
     formats: ["markdown"]
```

## Pattern 2: MCP Server Discovery

**Goal:** Find MCP servers for specific capabilities

```
1. firecrawl_search:
     query: "MCP server {capability} site:github.com modelcontextprotocol"
     limit: 10

2. For promising results:
   firecrawl_scrape:
     url: "{repo_url}"
     formats: ["markdown"]

3. Check official registry:
   firecrawl_scrape:
     url: "https://github.com/modelcontextprotocol/servers"
     formats: ["markdown"]
```

## Pattern 3: Skills Discovery

**Goal:** Find Claude Code skills for specific domains

```
1. firecrawl_search:
     query: "Claude Code skill {domain} SKILL.md site:github.com"
     limit: 10

2. firecrawl_search:
     query: "claude-code {domain} .claude/skills site:github.com"
     limit: 10

3. Cross-reference with:
   firecrawl_scrape:
     url: "https://awesomeclaude.ai"
     formats: ["markdown"]
```

## Pattern 4: Best Practices Research

**Goal:** Curate configuration best practices

```
1. Official docs first:
   firecrawl_scrape:
     url: "https://docs.anthropic.com/en/docs/claude-code"
     formats: ["markdown"]

2. Community best practices:
   firecrawl_search:
     query: "Claude Code best practices CLAUDE.md configuration"
     limit: 15

3. Reference implementations:
   firecrawl_agent:
     prompt: "Find the most starred Claude Code configuration examples on GitHub with CLAUDE.md files"

4. Synthesize patterns from results
```

## Pattern 5: Technology-Specific Resources

**Goal:** Find resources for a specific tech stack

```
1. firecrawl_search:
     query: "Claude Code {technology} {framework}"
     limit: 10

2. firecrawl_agent:
     prompt: "Find Claude Code skills, MCP servers, and configurations for {technology} development"

3. Validate with:
   firecrawl_scrape on each promising result
```

## Pattern 6: Hooks and Automation

**Goal:** Find hook patterns and automation examples

```
1. firecrawl_search:
     query: "Claude Code hooks PreToolUse PostToolUse site:github.com"
     limit: 10

2. firecrawl_search:
     query: "Claude Code automation workflow site:github.com"
     limit: 10

3. Reference implementation:
   firecrawl_scrape:
     url: "https://github.com/diet103/claude-code-infrastructure-showcase"
     formats: ["markdown"]
```

## Efficient Crawling Tips

### Use Search Before Crawl
```
# DON'T: Crawl entire site
firecrawl_crawl:
  url: "https://github.com/anthropics"
  limit: 100  # Wasteful

# DO: Search first, then scrape specific pages
firecrawl_search:
  query: "site:github.com/anthropics Claude Code"
  limit: 10
```

### Cache with maxAge
```
firecrawl_scrape:
  url: "https://awesomeclaude.ai"
  maxAge: 172800000  # 2 days - uses cached version
```

### Extract Structured Data
```
# When page has many resources, extract instead of parsing markdown
firecrawl_extract:
  urls: ["https://awesomeclaude.ai/claude-code"]
  prompt: "Extract all tools and libraries with their URLs and descriptions"
  schema: { ... }
```

### Use Agent for Complex Discovery
```
# When you don't know where information lives
firecrawl_agent:
  prompt: "Find the official documentation for Claude Code hooks and list all available hook types"
```

## Rate Limit Management

Firecrawl has credit-based limits. Prioritize:

1. **High Priority** - Official Anthropic docs, awesomeclaude.ai main pages
2. **Medium Priority** - Popular GitHub repos (>100 stars)
3. **Low Priority** - Individual project repos

Stop crawling when:
- You have 10+ relevant resources for a category
- Resources start repeating across searches
- Quality drops below threshold (score <3.0)
