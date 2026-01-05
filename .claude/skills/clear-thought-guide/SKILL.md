---
name: clear-thought-guide
description: Guide for using Clear Thought MCP tools in Project Incubator. Covers mental models, thoughtbox, and notebooks. Activates when user needs to think, decide, compare options, or analyze trade-offs.
---

# Clear Thought Integration Guide

## Purpose

Project Incubator prescribes specific Clear Thought tools at decision points. This guide explains when and how to use each tool.

## Available Tools

### 1. Mental Models (`mcp__clear-thought__mental_models`)

Structured reasoning frameworks for specific situations.

**Operations:**
- `list_models` - See available models
- `list_tags` - See model categories
- `get_model` - Get a specific model

**Key Models for This Workspace:**

| Model | Use When | Phase |
|-------|----------|-------|
| `decomposition` | Breaking down complex ideas | 2 (EXPAND) |
| `abstraction-laddering` | Moving between why/how | 2 (EXPAND) |
| `trade-off-matrix` | Comparing options | 4 (ARCHITECT) |
| `pre-mortem` | Identifying risks | 4 (ARCHITECT) |
| `inversion` | Challenging assumptions | Any |

### 2. Thoughtbox (`mcp__clear-thought__thoughtbox`)

Step-by-step reasoning for complex analysis.

**Use for:**
- Multi-step reasoning chains
- Working through trade-offs
- Debugging specification inconsistencies
- Complex technical decisions

**Parameters:**
- `thought`: Current thinking step
- `thoughtNumber`: Step number (1, 2, 3...)
- `totalThoughts`: Estimated total steps
- `nextThoughtNeeded`: Whether to continue

### 3. Notebooks (`mcp__clear-thought__notebook`)

Interactive code execution for prototyping.

**Use for:**
- Testing data structures
- Validating technical feasibility
- Prototyping algorithms
- Quick experiments during architecture

## When to Use Each Tool

### Phase 2: EXPAND

**Required:** Mental models

```
# Breaking down the idea
Use mcp__clear-thought__mental_models:
- operation: "get_model"
- args: { "model": "decomposition" }

# Understanding user needs
Use mcp__clear-thought__mental_models:
- operation: "get_model"
- args: { "model": "abstraction-laddering" }
```

### Phase 3: SPECIFY

**Recommended:** Thoughtbox for complex features

```
Use mcp__clear-thought__thoughtbox when:
- Defining acceptance criteria for complex features
- Resolving conflicting requirements
- Prioritizing features with trade-offs
```

### Phase 4: ARCHITECT

**Required:** Mental models for decisions

```
# Comparing tech stack options
Use mcp__clear-thought__mental_models:
- operation: "get_model"
- args: { "model": "trade-off-matrix" }

# Identifying risks
Use mcp__clear-thought__mental_models:
- operation: "get_model"
- args: { "model": "pre-mortem" }
```

**Optional:** Notebook for technical validation

```
Use mcp__clear-thought__notebook when:
- Need to test if a technical approach works
- Want to prototype a data structure
- Validating API responses
```

### Phase 5: CONFIGURE

**Recommended:** Thoughtbox for complex configs

```
Use mcp__clear-thought__thoughtbox when:
- Deciding which skills to include
- Designing custom commands
- Planning agent capabilities
```

## Usage Patterns

### Trade-off Matrix Example

When comparing framework options:

1. Get the model:
```
mcp__clear-thought__mental_models
- operation: "get_model"
- args: { "model": "trade-off-matrix" }
```

2. Apply to decision:
- List options (React, Vue, Svelte)
- Define criteria (learning curve, ecosystem, performance)
- Score each option
- Document winner and rationale

### Pre-mortem Example

When validating architecture:

1. Get the model:
```
mcp__clear-thought__mental_models
- operation: "get_model"
- args: { "model": "pre-mortem" }
```

2. Apply to architecture:
- "Imagine this project failed. Why?"
- List potential failure modes
- For each: assess likelihood and impact
- Document mitigations

### Thoughtbox Example

When resolving complex trade-off:

```
mcp__clear-thought__thoughtbox
- thought: "Analyzing whether to use SQL vs NoSQL..."
- thoughtNumber: 1
- totalThoughts: 5
- nextThoughtNeeded: true
```

Continue through steps until conclusion reached.

## Integration Rules

1. **Don't skip prescribed tools** - If a phase requires a mental model, use it
2. **Document usage** - Note which tools were used and conclusions
3. **Share results with user** - Explain the analysis, not just the conclusion
4. **Use iteratively** - Can apply same model multiple times as understanding evolves

## Quick Reference

| Situation | Tool | Model/Feature |
|-----------|------|---------------|
| Break down complex idea | mental_models | decomposition |
| Understand user goals | mental_models | abstraction-laddering |
| Compare options | mental_models | trade-off-matrix |
| Identify risks | mental_models | pre-mortem |
| Challenge assumptions | mental_models | inversion |
| Multi-step reasoning | thoughtbox | - |
| Test code/data | notebook | - |
