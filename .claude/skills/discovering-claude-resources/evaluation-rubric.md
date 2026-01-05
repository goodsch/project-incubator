# Resource Evaluation Rubric

Detailed scoring criteria for discovered Claude Code resources.

## Scoring Scale

Each criterion is scored 1-5:
- **5** - Excellent, exceeds expectations
- **4** - Good, meets expectations
- **3** - Adequate, functional
- **2** - Below average, has issues
- **1** - Poor, not recommended

## Criteria Details

### Relevance (Weight: 30%)

| Score | Description |
|-------|-------------|
| 5 | Directly addresses a core project requirement |
| 4 | Addresses a project requirement with minor adaptation |
| 3 | Partially relevant, may be useful |
| 2 | Tangentially related |
| 1 | Not relevant to project needs |

### Quality (Weight: 25%)

| Score | Indicators |
|-------|------------|
| 5 | Comprehensive docs, active maintenance (<30 days), tests, examples |
| 4 | Good docs, recent updates (<90 days), some examples |
| 3 | Basic docs, occasional updates, works as described |
| 2 | Sparse docs, stale (>6 months), limited examples |
| 1 | No docs, abandoned, broken |

### Compatibility (Weight: 20%)

| Score | Description |
|-------|-------------|
| 5 | Explicitly supports current Claude Code version, verified working |
| 4 | Recent updates suggest compatibility, likely works |
| 3 | No version conflicts apparent, should work |
| 2 | May require adaptation, some compatibility concerns |
| 1 | Known compatibility issues, requires significant changes |

### Complexity (Weight: 15%)

For non-coder users:

| Score | Description |
|-------|-------------|
| 5 | Zero configuration, drop-in ready |
| 4 | Minimal config, clear instructions |
| 3 | Some setup required, documentation adequate |
| 2 | Complex setup, requires technical knowledge |
| 1 | Expert-level setup, extensive customization needed |

### Adoption (Weight: 10%)

| Score | Indicators |
|-------|------------|
| 5 | >1000 stars, official Anthropic resource |
| 4 | 100-1000 stars, well-known in community |
| 3 | 10-100 stars, some community usage |
| 2 | <10 stars, limited usage |
| 1 | No stars, personal project |

## Threshold Recommendations

| Total Score | Recommendation |
|-------------|----------------|
| 4.0 - 5.0 | **Include** - Add to project config |
| 3.0 - 3.9 | **Consider** - Review with user |
| 2.0 - 2.9 | **Skip** - Not recommended |
| < 2.0 | **Reject** - Do not use |

## Quick Assessment

For rapid evaluation, check these signals:

**Green Flags:**
- README has clear "Getting Started" section
- Last commit within 30 days
- Issues are being responded to
- Has CLAUDE.md or .claude/ directory
- Listed on awesomeclaude.ai

**Red Flags:**
- No README or sparse documentation
- Last commit >1 year ago
- Open issues with no responses
- Requires deprecated dependencies
- No license file
