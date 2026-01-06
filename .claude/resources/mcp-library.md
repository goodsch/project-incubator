# MCP Server Library

MCP servers to recommend for output projects based on project type and requirements.

## Reasoning & Thinking

### clear-thought
**Purpose:** Structured reasoning with mental models, thoughtbox, notebooks
**Best For:** All projects - decision making, debugging, complex analysis
**Key Tools:**
- `mental_models` - 15+ models (decomposition, trade-off-matrix, pre-mortem, etc.)
- `thoughtbox` - Step-by-step reasoning
- `notebook` - JS/TS code execution

**When to Recommend:** Always for non-trivial projects
**Config:** Standard MCP setup

### sequential-thinking
**Purpose:** Chain-of-thought reasoning
**Best For:** Complex problem solving
**Key Tools:** `sequentialthinking`
**When to Recommend:** Projects with complex logic

## Memory & Persistence

### notionApi (Notion MCP)
**Purpose:** External brain, persistent working memory across sessions
**Best For:** Multi-session projects, voice-first workflows, ADHD users
**Key Tools:**
- `API-post-search` - Find pages/databases
- `API-patch-block-children` - Append content
- `API-post-page` - Create pages
- `API-query-data-source` - Query databases
**When to Recommend:** Projects requiring session persistence, idea incubation, team collaboration
**ADHD Benefit:** Everything visible, nothing hidden - combats object permanence issues
**Config:** Requires Notion integration token

### mem0
**Purpose:** Full memory system with 30+ data source connectors
**Best For:** Long-running projects needing semantic memory
**Key Tools:** Memory storage, retrieval, semantic search
**When to Recommend:** Complex projects with extensive context requirements
**Note:** More heavyweight than Anthropic Memory Server

### anthropic-memory-server
**Purpose:** Simple key-value persistent memory
**Best For:** Basic persistent storage needs
**When to Recommend:** Simpler projects that need session continuity
**Config:** Lightweight setup

## Database & Backend

### supabase
**Purpose:** Supabase database operations
**Best For:** Projects using Supabase
**Key Tools:** Database queries, auth, storage
**When to Recommend:** Supabase projects

### postgresql
**Purpose:** Direct PostgreSQL access
**Best For:** Custom PostgreSQL setups
**When to Recommend:** Non-Supabase PostgreSQL projects

## File & Content

### filesystem
**Purpose:** Extended file operations
**Best For:** Projects with heavy file manipulation
**When to Recommend:** Automation, data processing

## Web & Research

### brave-search
**Purpose:** Web search
**Best For:** Research-heavy projects
**When to Recommend:** Projects needing current info

### fetch
**Purpose:** HTTP requests
**Best For:** API integration projects
**When to Recommend:** Projects calling external APIs

## Development Tools

### github
**Purpose:** GitHub operations
**Best For:** Open source projects, collaboration
**When to Recommend:** Projects with GitHub repos

## Specialized

### playwright
**Purpose:** Browser automation
**Best For:** Testing, scraping, automation
**When to Recommend:** Web testing, browser automation

### docker
**Purpose:** Container management
**Best For:** Containerized applications
**When to Recommend:** Docker-based projects

## MCP Selection Matrix

| Project Type | Recommended MCPs |
|--------------|------------------|
| Web App | clear-thought, supabase/postgresql |
| CLI Tool | clear-thought, filesystem |
| Automation | clear-thought, filesystem, fetch |
| API/Backend | clear-thought, postgresql, github |
| Research | clear-thought, brave-search, fetch, notionApi |
| Testing | clear-thought, playwright |
| Multi-Session | clear-thought, notionApi or mem0 |
| ADHD-Optimized | clear-thought, notionApi, sequential-thinking |

## ADHD-Friendly MCP Selection

For users with ADHD, prioritize MCPs that provide:

| Need | MCP | Why |
|------|-----|-----|
| External memory | notionApi | Persistent scratchpads visible across sessions |
| Visual progress | clear-thought | Structured reasoning with visible checkpoints |
| Task breakdown | clear-thought (decomposition) | Micro-chunking for manageable steps |
| Decision support | clear-thought (trade-off-matrix) | Reduces cognitive load |
| Context continuity | mem0 or notionApi | Never lose track of where you were |

## Output Project MCP Config

For output projects, recommend in CLAUDE.md:

```markdown
## Recommended MCP Servers

Install these MCP servers to enhance Claude Code capabilities:

### Required
- **clear-thought**: Structured reasoning for technical decisions

### Recommended for This Project
- **[server]**: [Why useful for this project]
```

## MCP Installation Note

MCP servers are installed globally, not per-project. Output projects should:
1. Document recommended servers in CLAUDE.md
2. Explain why each is useful
3. Provide setup instructions if non-standard
