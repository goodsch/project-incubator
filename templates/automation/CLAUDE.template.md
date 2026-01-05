# {{PROJECT_NAME}}

{{PROJECT_DESCRIPTION}}

## Tech Stack

- **Language:** {{LANGUAGE}}
- **Scheduler:** {{SCHEDULER}}
- **Storage:** {{STORAGE}}

## Project Structure

```
{{PROJECT_NAME}}/
├── src/
│   ├── main.py         # Entry point
│   ├── workflows/      # Workflow definitions
│   ├── processors/     # Data processors
│   └── utils/          # Utility functions
├── data/
│   ├── input/          # Input data
│   └── output/         # Output data
├── config/             # Configuration files
├── logs/               # Log files
└── tests/              # Test files
```

## Development

### Getting Started

```bash
# Create virtual environment
python -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Run workflow
python src/main.py
```

### Commands

| Command | Purpose |
|---------|---------|
| `/run` | Execute the workflow |
| `/test` | Run with test data |
| `/schedule` | Set up scheduled execution |
| `/logs` | View recent logs |

## Workflow Design

### Input
- Source: {{INPUT_SOURCE}}
- Format: {{INPUT_FORMAT}}
- Validation: {{VALIDATION_RULES}}

### Processing
1. {{STEP_1}}
2. {{STEP_2}}
3. {{STEP_3}}

### Output
- Destination: {{OUTPUT_DESTINATION}}
- Format: {{OUTPUT_FORMAT}}

## Code Conventions

### Workflows
- One workflow per file
- Clear input/output contracts
- Idempotent operations when possible
- Comprehensive logging

### Error Handling
- Catch and log all errors
- Implement retry logic for transient failures
- Send notifications on critical failures
- Never silently fail

### Data
- Validate inputs before processing
- Use transactions where applicable
- Keep backups of important data
- Document data formats

## Scheduling

### Cron Example
```bash
# Run daily at 2am
0 2 * * * cd /path/to/project && python src/main.py
```

### Manual Trigger
```bash
python src/main.py --run-now
```

## Clear Thought Usage

Use Clear Thought MCP tools for:

| Situation | Tool | Model |
|-----------|------|-------|
| Workflow design | mental_models | decomposition |
| Error handling | mental_models | pre-mortem |
| Data flow | thoughtbox | - |
| Edge cases | thoughtbox | - |

## Quality Checklist

Before deploying:
- [ ] Works with sample data
- [ ] Handles edge cases
- [ ] Error handling is robust
- [ ] Logging is comprehensive
- [ ] Schedule is configured
- [ ] Monitoring is in place
