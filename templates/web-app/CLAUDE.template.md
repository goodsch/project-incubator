# {{PROJECT_NAME}}

{{PROJECT_DESCRIPTION}}

## Tech Stack

- **Frontend:** {{FRONTEND_FRAMEWORK}}
- **Backend:** {{BACKEND_SERVICE}}
- **Database:** {{DATABASE}}
- **Hosting:** {{HOSTING_PLATFORM}}

## Project Structure

```
{{PROJECT_NAME}}/
├── src/
│   ├── components/     # Reusable UI components
│   ├── views/          # Page components
│   ├── composables/    # Shared logic (Vue) / hooks (React)
│   ├── utils/          # Utility functions
│   └── assets/         # Static assets
├── public/             # Public static files
├── tests/              # Test files
└── docs/               # Documentation
```

## Development

### Getting Started

```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Build for production
npm run build
```

### Commands

| Command | Purpose |
|---------|---------|
| `/dev` | Start development server |
| `/build` | Build for production |
| `/test` | Run tests |
| `/deploy` | Deploy to {{HOSTING_PLATFORM}} |

## Code Conventions

### Components
- One component per file
- Use composition API (Vue) / hooks (React)
- Props should be typed
- Keep components focused and small

### Styling
- Use scoped styles (Vue) / CSS modules (React)
- Follow mobile-first responsive design
- Use CSS variables for theming

### Data Fetching
- Use composables/hooks for data fetching
- Handle loading and error states
- Cache where appropriate

## Clear Thought Usage

Use Clear Thought MCP tools for:

| Situation | Tool | Model |
|-----------|------|-------|
| Component design | mental_models | decomposition |
| State management decisions | mental_models | trade-off-matrix |
| Debugging issues | mental_models | five-whys |
| Complex logic | thoughtbox | - |

## Quality Checklist

Before committing:
- [ ] Feature works as expected
- [ ] No console errors/warnings
- [ ] Responsive on mobile
- [ ] Accessible (keyboard nav, ARIA)
- [ ] Code is readable and documented
