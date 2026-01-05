# {{PROJECT_NAME}}

{{PROJECT_DESCRIPTION}}

## Tech Stack

- **Language:** {{LANGUAGE}}
- **Framework:** {{FRAMEWORK}}
- **Distribution:** {{DISTRIBUTION}}

## Project Structure

```
{{PROJECT_NAME}}/
├── src/
│   ├── index.ts        # Entry point
│   ├── commands/       # Command implementations
│   ├── utils/          # Utility functions
│   └── config/         # Configuration handling
├── bin/                # Executable scripts
├── tests/              # Test files
└── docs/               # Documentation
```

## Development

### Getting Started

```bash
# Install dependencies
npm install

# Run in development
npm run dev -- [command] [options]

# Build
npm run build

# Link for local testing
npm link
```

### Commands

| Command | Purpose |
|---------|---------|
| `/dev` | Run CLI in development mode |
| `/build` | Build for distribution |
| `/test` | Run tests |
| `/publish` | Publish to npm |

## CLI Structure

```
{{PROJECT_NAME}} <command> [options]

Commands:
  {{COMMAND_1}}    {{DESCRIPTION_1}}
  {{COMMAND_2}}    {{DESCRIPTION_2}}

Options:
  -h, --help       Show help
  -v, --version    Show version
  --verbose        Verbose output
```

## Code Conventions

### Commands
- One command per file in src/commands/
- Use async/await for async operations
- Validate inputs early
- Provide helpful error messages

### Output
- Use colors for emphasis (chalk)
- Provide progress for long operations
- Support --quiet and --verbose flags
- Exit with appropriate codes (0=success, 1=error)

### Configuration
- Support config file (~/.{{PROJECT_NAME}}rc)
- Allow environment variables
- CLI flags override config

## Clear Thought Usage

Use Clear Thought MCP tools for:

| Situation | Tool | Model |
|-----------|------|-------|
| Command design | mental_models | decomposition |
| Option naming | mental_models | abstraction-laddering |
| Error handling | thoughtbox | - |
| Complex logic | thoughtbox | - |

## Quality Checklist

Before publishing:
- [ ] All commands work correctly
- [ ] --help is accurate
- [ ] Error messages are helpful
- [ ] Exit codes are correct
- [ ] README has usage examples
