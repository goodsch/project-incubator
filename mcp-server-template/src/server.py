"""
Hatchery MCP Server - Project Incubator companion

A centralized MCP server that provides cross-project awareness while
keeping each project isolated in its own repo.

Architecture:
- Each project lives in its own Git repo (cloned from template)
- Each project has its own status.json, Notion pages, etc.
- Central portfolio (~/.hatchery/portfolio.json) indexes all projects
- This server reads portfolio for cross-project context (dream synthesis)
- Operations happen on the selected project's local state

Use `hatchery_list` to see all projects, `hatchery_select` to switch.
"""

import json
import os
from datetime import datetime
from pathlib import Path
from typing import Optional

from fastmcp import FastMCP
from pydantic import BaseModel

try:
    from src.notion_sync import notion
except ImportError:
    from notion_sync import notion

# Initialize server
mcp = FastMCP(
    name="hatchery",
    instructions="""Hatchery is the Project Incubator's cross-project companion.

Use these tools to:
- List and switch between incubation project repos
- Get cross-project context for dream synthesis
- Check status and get next action directives
- Capture ideas quickly (syncs to project's Notion)
- View portfolio for patterns and learnings

Each project lives in its own repo with isolated state.
The portfolio provides cross-project awareness without mixing contexts.
"""
)

# Paths
HATCHERY_DIR = Path.home() / ".hatchery"
PORTFOLIO_FILE = HATCHERY_DIR / "portfolio.json"
CONFIG_FILE = HATCHERY_DIR / "config.json"

# Phase definitions (same as project repos)
PHASES = ["INCUBATE", "CAPTURE", "EXPAND", "SPECIFY", "ARCHITECT", "CONFIGURE", "SEED"]

PHASE_DIRECTIVES = {
    "INCUBATE": "Run /incubate to build cognitive context. I'll absorb materials, scan prior projects, and develop deep understanding.",
    "CAPTURE": "Run /capture to do a visualization-first walkthrough. Describe the tool as if it exists.",
    "EXPAND": "Run /expand to explore with Socratic dialogue. Answer the six macro questions.",
    "SPECIFY": "Run /specify to generate the PRD from captured artifacts.",
    "ARCHITECT": "Run /architect for technical design and pre-mortem risk analysis.",
    "CONFIGURE": "Run /configure to set up development environment.",
    "SEED": "Run /seed to generate project scaffold and initialize codebase.",
}


# --- Data Models ---

class ProjectEntry(BaseModel):
    """Portfolio entry for a project (lightweight index)"""
    name: str
    slug: str
    path: str  # Absolute path to project repo
    notion_page_id: Optional[str] = None
    created_at: str = ""
    last_active: str = ""
    # Cognitive metadata (for cross-project awareness)
    summary: str = ""
    key_features: list = []
    tech_stack: list = []
    outcome: str = "active"  # active, completed, paused, archived
    learnings: list = []


class Portfolio(BaseModel):
    """Central index of all projects"""
    active_project: Optional[str] = None  # slug of active project
    projects: dict = {}  # slug -> ProjectEntry


class HatcheryConfig(BaseModel):
    """Global hatchery configuration"""
    notion_api_key: Optional[str] = None
    notion_hub_page_id: Optional[str] = None


# --- State Management ---

def load_portfolio() -> Portfolio:
    """Load portfolio from ~/.hatchery/portfolio.json"""
    HATCHERY_DIR.mkdir(exist_ok=True)
    if PORTFOLIO_FILE.exists():
        data = json.loads(PORTFOLIO_FILE.read_text())
        if "projects" in data:
            for slug, proj_data in data["projects"].items():
                if isinstance(proj_data, dict):
                    data["projects"][slug] = ProjectEntry(**proj_data)
        return Portfolio(**data)
    return Portfolio()


def save_portfolio(portfolio: Portfolio):
    """Save portfolio to ~/.hatchery/portfolio.json"""
    HATCHERY_DIR.mkdir(exist_ok=True)
    data = {
        "active_project": portfolio.active_project,
        "projects": {slug: proj.model_dump() for slug, proj in portfolio.projects.items()}
    }
    PORTFOLIO_FILE.write_text(json.dumps(data, indent=2))


def load_project_status(project_path: str) -> Optional[dict]:
    """Load status.json from a project repo"""
    status_file = Path(project_path) / "status.json"
    if status_file.exists():
        return json.loads(status_file.read_text())
    return None


def save_project_status(project_path: str, status: dict):
    """Save status.json to a project repo"""
    status_file = Path(project_path) / "status.json"
    status["lastSession"] = datetime.now().isoformat()
    status_file.write_text(json.dumps(status, indent=2))


def get_active_project(portfolio: Portfolio) -> Optional[ProjectEntry]:
    """Get the currently active project from portfolio"""
    if portfolio.active_project and portfolio.active_project in portfolio.projects:
        return portfolio.projects[portfolio.active_project]
    return None


def slugify(name: str) -> str:
    """Convert project name to slug"""
    return name.lower().replace(" ", "-").replace("_", "-")


# --- Project Management Tools ---

@mcp.tool
def hatchery_list() -> dict:
    """
    List all incubation projects in the portfolio.

    Shows project names, paths, phases, and outcomes.
    """
    portfolio = load_portfolio()

    if not portfolio.projects:
        return {
            "projects": [],
            "active_project": None,
            "voice_summary": "No projects registered. Run setup.sh in a project repo to register it."
        }

    project_list = []
    for slug, proj in portfolio.projects.items():
        # Try to get current phase from project's status.json
        status = load_project_status(proj.path) if Path(proj.path).exists() else None
        phase = status.get("phaseName", "unknown").upper() if status else "unknown"

        project_list.append({
            "slug": slug,
            "name": proj.name,
            "path": proj.path,
            "phase": phase,
            "outcome": proj.outcome,
            "last_active": proj.last_active,
            "is_active": slug == portfolio.active_project,
            "summary": proj.summary or "(no summary)",
        })

    # Sort by last_active
    project_list.sort(key=lambda x: x["last_active"] or "", reverse=True)

    active_name = portfolio.projects[portfolio.active_project].name if portfolio.active_project else None

    return {
        "projects": project_list,
        "active_project": portfolio.active_project,
        "active_project_name": active_name,
        "voice_summary": f"{len(project_list)} projects. Currently on {active_name or 'none'}."
    }


@mcp.tool
def hatchery_select(project: str) -> dict:
    """
    Switch to a different project.

    Args:
        project: Project name or slug
    """
    portfolio = load_portfolio()
    slug = slugify(project)

    # Try exact slug match first
    if slug not in portfolio.projects:
        # Try name match
        for s, p in portfolio.projects.items():
            if p.name.lower() == project.lower():
                slug = s
                break
        else:
            available = [p.name for p in portfolio.projects.values()]
            return {
                "error": f"Project '{project}' not found",
                "available": available,
                "voice_error": f"No project called {project}."
            }

    proj = portfolio.projects[slug]

    # Verify project path exists
    if not Path(proj.path).exists():
        return {
            "error": f"Project directory not found: {proj.path}",
            "voice_error": f"Project {proj.name} directory is missing."
        }

    proj.last_active = datetime.now().isoformat()
    portfolio.active_project = slug
    save_portfolio(portfolio)

    # Load project status for phase info
    status = load_project_status(proj.path)
    phase = status.get("phaseName", "unknown").upper() if status else "unknown"

    # Generate dream synthesis on select
    dream = generate_dream_synthesis(proj.name, portfolio.projects)

    return {
        "selected": proj.name,
        "slug": slug,
        "path": proj.path,
        "phase": phase,
        "dream_hint": dream.get("synthesis", ""),
        "voice_confirm": f"Switched to {proj.name}. Phase: {phase.lower()}."
    }


@mcp.tool
def hatchery_register(
    name: str,
    path: str,
    notion_page_id: str = "",
    summary: str = ""
) -> dict:
    """
    Register a project repo with the portfolio.

    Called by setup.sh when initializing a new project.

    Args:
        name: Human-readable project name
        path: Absolute path to project repo
        notion_page_id: Notion Design Doc page ID (optional)
        summary: One-line project description (optional)
    """
    portfolio = load_portfolio()
    slug = slugify(name)

    if slug in portfolio.projects:
        # Update existing
        proj = portfolio.projects[slug]
        proj.path = path
        if notion_page_id:
            proj.notion_page_id = notion_page_id
        if summary:
            proj.summary = summary
        proj.last_active = datetime.now().isoformat()
    else:
        # Create new
        portfolio.projects[slug] = ProjectEntry(
            name=name,
            slug=slug,
            path=path,
            notion_page_id=notion_page_id,
            summary=summary,
            created_at=datetime.now().isoformat(),
            last_active=datetime.now().isoformat(),
        )

    portfolio.active_project = slug
    save_portfolio(portfolio)

    return {
        "registered": name,
        "slug": slug,
        "path": path,
        "voice_confirm": f"Registered {name} with portfolio."
    }


# --- Status & Navigation Tools ---

@mcp.tool
def hatchery_status() -> dict:
    """
    Get current project status and next action.

    Reads from the selected project's status.json.
    """
    portfolio = load_portfolio()
    proj = get_active_project(portfolio)

    if not proj:
        return {
            "error": "No active project",
            "projects_available": len(portfolio.projects),
            "voice_error": "No project selected. Say 'list projects' or select one."
        }

    status = load_project_status(proj.path)
    if not status:
        return {
            "error": f"No status.json found in {proj.path}",
            "voice_error": f"Project {proj.name} has no status file."
        }

    phase_name = status.get("phaseName", "unknown").upper()
    phase_num = status.get("currentPhase", 0)

    return {
        "project": proj.name,
        "slug": proj.slug,
        "path": proj.path,
        "current_phase": phase_name,
        "phase_number": phase_num,
        "status": status.get("status", "unknown"),
        "phases": status.get("phases", {}),
        "notion": status.get("notion", {}),
        "next_action": PHASE_DIRECTIVES.get(phase_name, "Check status.json"),
        "summary": proj.summary,
    }


@mcp.tool
def hatchery_capture(idea: str, idea_type: str = "💡 Idea") -> dict:
    """
    Quick capture an idea for the active project.

    Stores locally and queues for Notion sync.

    Args:
        idea: The idea or note to capture
        idea_type: One of: 💡 Idea, 🐛 Issue, ✨ Feature, ❓ Question, 📝 Note
    """
    portfolio = load_portfolio()
    proj = get_active_project(portfolio)

    if not proj:
        return {"error": "No active project", "voice_error": "No project selected."}

    status = load_project_status(proj.path)
    if not status:
        return {"error": "No status.json", "voice_error": "Project has no status file."}

    # Add capture to pending list
    if "pendingCaptures" not in status:
        status["pendingCaptures"] = []

    capture = {
        "idea": idea,
        "type": idea_type,
        "captured_at": datetime.now().isoformat(),
        "phase": status.get("phaseName", "unknown"),
        "synced": False,
    }
    status["pendingCaptures"].append(capture)
    save_project_status(proj.path, status)

    pending_count = len(status["pendingCaptures"])

    # Intelligent sync: auto-sync to Notion if >= 3 pending
    synced = False
    if pending_count >= 3 and proj.notion_page_id:
        sync_result = sync_captures_to_notion(proj, status)
        synced = sync_result.get("synced", 0) > 0

    return {
        "captured": idea,
        "type": idea_type,
        "project": proj.name,
        "pending_count": pending_count,
        "auto_synced": synced,
        "voice_confirm": f"Got it. Captured as {idea_type}."
    }


@mcp.tool
def hatchery_sync() -> dict:
    """
    Sync pending captures to Notion.
    """
    portfolio = load_portfolio()
    proj = get_active_project(portfolio)

    if not proj:
        return {"error": "No active project"}

    status = load_project_status(proj.path)
    if not status:
        return {"error": "No status.json"}

    return sync_captures_to_notion(proj, status)


def sync_captures_to_notion(proj: ProjectEntry, status: dict) -> dict:
    """Helper to sync captures to Notion"""
    pending = status.get("pendingCaptures", [])
    if not pending:
        return {"synced": 0, "voice_confirm": "Nothing to sync."}

    if not notion.is_configured:
        return {"synced": 0, "error": "Notion not configured"}

    # Get Quick Capture DB ID from project's status.json
    quick_capture_id = status.get("notion", {}).get("quickCapture", {}).get("id")
    if not quick_capture_id:
        return {"synced": 0, "error": "No Quick Capture DB configured"}

    # Sync each capture
    synced = 0
    for capture in pending:
        if capture.get("synced"):
            continue
        result = notion.create_capture(capture)
        if result.get("synced"):
            capture["synced"] = True
            synced += 1

    # Remove synced captures
    status["pendingCaptures"] = [c for c in pending if not c.get("synced")]
    save_project_status(proj.path, status)

    return {
        "synced": synced,
        "remaining": len(status["pendingCaptures"]),
        "voice_confirm": f"Synced {synced} captures to Notion."
    }


# --- Cognitive Layer Tools ---

@mcp.tool
def hatchery_dream() -> dict:
    """
    Get dream synthesis for the active project.

    Analyzes portfolio for cross-project patterns and suggestions.
    These are SUGGESTIONS until explicitly confirmed.
    """
    portfolio = load_portfolio()
    proj = get_active_project(portfolio)

    if not proj:
        return {"error": "No active project"}

    dream = generate_dream_synthesis(proj.name, portfolio.projects)

    return {
        "project": proj.name,
        "synthesis": dream.get("synthesis"),
        "related_projects": dream.get("related_projects", []),
        "suggested_features": dream.get("suggested_features", []),
        "portfolio_learnings": dream.get("portfolio_learnings", []),
        "open_questions": dream.get("open_questions", []),
        "is_suggestion": True,
        "voice_summary": dream.get("synthesis", "No patterns found.")
    }


@mcp.tool
def hatchery_portfolio(include_learnings: bool = False) -> dict:
    """
    View the full project portfolio.

    Shows all projects with outcomes, features, and optionally learnings.

    Args:
        include_learnings: Include detailed learnings from each project
    """
    portfolio = load_portfolio()

    if not portfolio.projects:
        return {"projects": [], "voice_summary": "Portfolio is empty."}

    entries = []
    for slug, proj in portfolio.projects.items():
        entry = {
            "name": proj.name,
            "slug": slug,
            "summary": proj.summary or "(no summary)",
            "outcome": proj.outcome,
            "key_features": proj.key_features,
            "tech_stack": proj.tech_stack,
        }
        if include_learnings:
            entry["learnings"] = proj.learnings
        entries.append(entry)

    completed = [e for e in entries if e["outcome"] == "completed"]
    active = [e for e in entries if e["outcome"] == "active"]

    return {
        "total": len(entries),
        "completed": completed,
        "active": active,
        "all_features": list(set(f for e in entries for f in e["key_features"])),
        "all_tech": list(set(t for e in entries for t in e["tech_stack"])),
        "voice_summary": f"{len(entries)} projects. {len(completed)} completed, {len(active)} active."
    }


@mcp.tool
def hatchery_annotate(
    summary: str = "",
    features: str = "",
    tech: str = "",
    outcome: str = "",
    learnings: str = ""
) -> dict:
    """
    Annotate the active project with meta information.

    This builds portfolio knowledge for future dream synthesis.

    Args:
        summary: One-line project description
        features: Comma-separated key features
        tech: Comma-separated tech stack
        outcome: One of: active, completed, paused, archived
        learnings: Comma-separated learnings
    """
    portfolio = load_portfolio()
    proj = get_active_project(portfolio)

    if not proj:
        return {"error": "No active project"}

    updated = []

    if summary:
        proj.summary = summary
        updated.append("summary")

    if features:
        proj.key_features = [f.strip() for f in features.split(",")]
        updated.append("features")

    if tech:
        proj.tech_stack = [t.strip() for t in tech.split(",")]
        updated.append("tech")

    if outcome and outcome.lower() in ["active", "completed", "paused", "archived"]:
        proj.outcome = outcome.lower()
        updated.append("outcome")

    if learnings:
        proj.learnings = [l.strip() for l in learnings.split(",")]
        updated.append("learnings")

    if updated:
        proj.last_active = datetime.now().isoformat()
        save_portfolio(portfolio)

    return {
        "project": proj.name,
        "updated": updated,
        "voice_confirm": f"Updated {', '.join(updated)}." if updated else "Nothing updated."
    }


# --- Voice-Optimized Tools ---

@mcp.tool
def hatchery_recap() -> str:
    """
    Brief spoken summary of current state.
    """
    portfolio = load_portfolio()
    proj = get_active_project(portfolio)

    if not proj:
        count = len(portfolio.projects)
        if count == 0:
            return "No projects registered. Run setup.sh in a project repo."
        return f"No project selected. {count} projects in portfolio."

    status = load_project_status(proj.path)
    phase = status.get("phaseName", "unknown") if status else "unknown"

    lines = [f"Working on {proj.name}.", f"Phase: {phase}."]
    if proj.summary:
        lines.append(proj.summary)

    return " ".join(lines)


@mcp.tool
def hatchery_next() -> str:
    """
    Single next action as directive.
    """
    portfolio = load_portfolio()
    proj = get_active_project(portfolio)

    if not proj:
        return "Select a project first. Say 'list projects' to see options."

    status = load_project_status(proj.path)
    if not status:
        return f"Run setup.sh in {proj.path} first."

    phase = status.get("phaseName", "unknown").upper()
    return PHASE_DIRECTIVES.get(phase, "Check /status for guidance.")


# --- Helper Functions ---

def generate_dream_synthesis(project_name: str, all_projects: dict) -> dict:
    """
    Generate dream synthesis based on portfolio.

    Finds related projects, suggests features, surfaces learnings.
    All output is SUGGESTIONS - not directive.
    """
    name_lower = project_name.lower()
    keywords = [w for w in name_lower.replace("-", " ").replace("_", " ").split()
                if len(w) > 2 and w not in ("the", "and", "for", "with")]

    related = []
    suggested_features = []
    all_learnings = []

    for slug, proj in all_projects.items():
        if slugify(project_name) == slug:
            continue  # Skip self

        relevance_score = 0
        reasons = []

        # Name similarity
        proj_name_lower = proj.name.lower()
        for kw in keywords:
            if kw in proj_name_lower:
                relevance_score += 2
                reasons.append(f"name contains '{kw}'")

        # Feature overlap
        for feature in proj.key_features:
            for kw in keywords:
                if kw in feature.lower():
                    relevance_score += 1
                    if feature not in suggested_features:
                        suggested_features.append(feature)
                    reasons.append(f"has '{feature}'")

        # Tech overlap
        for tech in proj.tech_stack:
            for kw in keywords:
                if kw in tech.lower():
                    relevance_score += 1
                    reasons.append(f"uses '{tech}'")

        # Collect learnings from mature projects
        if proj.learnings and proj.outcome in ("completed", "paused"):
            all_learnings.extend(proj.learnings)

        if relevance_score > 0:
            related.append({
                "project": proj.name,
                "slug": slug,
                "score": relevance_score,
                "reasons": reasons[:3],
                "outcome": proj.outcome,
                "features": proj.key_features[:3],
            })

    related.sort(key=lambda x: x["score"], reverse=True)
    related = related[:5]

    # Generate synthesis
    if related:
        top = related[0]["project"]
        synthesis = f"'{project_name}' may relate to {top}. "
        if suggested_features:
            synthesis += f"Consider: {', '.join(suggested_features[:3])}. "
        synthesis += "These are suggestions to explore or ignore."
    else:
        synthesis = f"'{project_name}' is fresh territory. No strong portfolio matches."

    return {
        "synthesis": synthesis,
        "related_projects": related,
        "suggested_features": suggested_features[:5],
        "portfolio_learnings": list(set(all_learnings))[:5],
        "open_questions": [
            "What problem does this solve?",
            "Who is the primary user?",
            "What's the simplest useful version?",
        ],
    }


# --- Run Server ---

if __name__ == "__main__":
    mcp.run()
