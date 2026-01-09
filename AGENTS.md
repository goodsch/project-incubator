# Repository Guidelines

Project Incubator is a template repo for voice-based project planning with Claude Code and Notion. Contributions typically update setup scripts, Markdown templates, and reference docs. Keep edits small, focused, and aligned with the 7-phase workflow.

## Project Structure & Module Organization
- `.claude/commands/` contains the slash-command playbooks used by Claude Code.
- `docs/` holds reference documentation and development rules.
- `notion-template/` contains the Notion Design Doc template.
- `skill-template/` contains template files for generated voice skills.
- `braindump/` and `spec/` are working areas for captured materials and PRD/architecture output.
- `voice-notion-planning/` contains planning-specific guides and schema notes.
- `setup.sh` and `verify-setup.sh` are the primary automation entry points.

## Build, Test, and Development Commands
- `./setup.sh` initializes a new workspace, creates the Notion Design Doc, and installs commands/skills.
- `./verify-setup.sh` validates local setup and Notion MCP configuration.
- `claude` launches Claude Code so you can run commands like `/status` or `/capture`.
- There is no build step; this repo is documentation and scripts.

## Coding Style & Naming Conventions
- Shell scripts use bash with `set -e`; quote variables and prefer clear, linear logic.
- Markdown should be concise and directive; keep headings short and use ASCII only.
- Template placeholders use `{{PROJECT_NAME}}` and `{{DATE}}`; keep that pattern consistent.
- Use lowercase, hyphenated names for new files and folders.

## Testing Guidelines
- There are no automated unit tests in this repo.
- After changing setup, templates, or MCP configuration, run `./verify-setup.sh` and manually sanity-check `./setup.sh` in a fresh clone when practical.

## Commit & Pull Request Guidelines
- Commit messages are short, imperative, and sentence case (e.g., "Add setup script", "Fix Notion config").
- PRs should describe user-facing impact, list any Notion/Claude prerequisites, and call out template or command changes.
- If you alter the workflow or prompts, include before/after snippets of the affected Markdown or command output.

## Notion & Configuration Notes
- Notion is the source of truth; `status.json` is only a local cache when created by setup.
- Keep tokens out of the repo; use `~/.notion-token` or `NOTION_API_KEY`, and update `.env.example` when configuration changes.
