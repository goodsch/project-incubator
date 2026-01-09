# Project Incubator Audit Findings

*Audit Date: 2026-01-08*
*Auditor: Codex Project Audit & Improvement Review*

## Executive Summary

The repo is coherent and well-structured for a documentation-and-scripts template, but there were critical workflow and configuration mismatches that could break MCP setup or confuse phase progression. Those are now corrected. Remaining items are mostly about optional/legacy guidance and clarity.

## Resolved in This Audit

- Fixed `.mcp.json` structure and validity so MCP servers load correctly.
- Aligned template guidance to the 7-phase workflow across `CLAUDE.md.template` and skill templates.
- Removed hard-coded template path in `verify-setup.sh` and updated SKILL.md parsing to current schema.
- Removed default Notion parent page ID from `setup.sh` and added explicit `NOTION_HUB_PAGE_ID` handling.
- Updated `.env.example` to include `NOTION_HUB_PAGE_ID` and a clearer Firecrawl key field.
- Clarified legacy/parallel workflow and tool naming in `voice-notion-planning`.
- Updated `docs/creating-projects.md` reset snippet to match current `status.json` schema.
- Removed absolute paths from `docs/archived-content-summary.md` for portability.

## Follow-ups (Optional)

- Decide whether to fully align the `voice-notion-planning` 6-phase flow with the main 7-phase workflow or keep it intentionally separate.
- Add a preflight check for `zip` in `setup.sh` (currently assumed present).
- If Firecrawl is intended for first-class use, document usage in `docs/notion-integration.md` or a dedicated doc.

