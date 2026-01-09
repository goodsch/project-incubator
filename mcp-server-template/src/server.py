"""
Hatchery MCP Server - Multi-project ideation workflow manager

A centralized MCP server that manages multiple incubation projects.
Use `hatchery_list_projects` to see all projects, `hatchery_select` to switch,
and `hatchery_create` to start a new one.

Each project has its own phase progression and state.
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
    instructions="""Hatchery is a multi-project ideation workflow manager.

Use these tools to:
- List and switch between incubation projects
- Create new projects to incubate
- Check status and get next action directives
- Capture ideas quickly (they sync to Notion)
- Advance through workflow phases

The workflow follows 7 phases:
0. BRAINDUMP - Marination of raw materials
1. CAPTURE - Visualization-first walkthrough
2. EXPAND - Socratic expansion (six macro questions)
3. SPECIFY - PRD generation
4. ARCHITECT - Technical design and risk analysis
5. CONFIGURE - Environment setup
6. SEED - Project scaffold generation
"""
)

# Paths
BASE_DIR = Path(__file__).parent.parent
STATE_DIR = BASE_DIR / "state"
PROJECTS_FILE = STATE_DIR / "projects.json"

# Phase definitions
PHASES = ["BRAINDUMP", "CAPTURE", "EXPAND", "SPECIFY", "ARCHITECT", "CONFIGURE", "SEED"]

PHASE_DIRECTIVES = {
    "BRAINDUMP": "Run /braindump to marinate on raw materials. Let ideas simmer without extracting requirements.",
    "CAPTURE": "Run /capture to do a visualization-first walkthrough. Describe the tool as if it exists.",
    "EXPAND": "Run /expand to explore with Socratic dialogue. Answer the six macro questions.",
    "SPECIFY": "Run /specify to generate the PRD from captured artifacts.",
    "ARCHITECT": "Run /architect for technical design and pre-mortem risk analysis.",
    "CONFIGURE": "Run /configure to set up development environment.",
    "SEED": "Run /seed to generate project scaffold and initialize codebase.",
}


# --- State Management ---

class ProjectState(BaseModel):
    """Per-project state"""
    name: str
    slug: str
    notion_page_id: Optional[str] = None
    quick_capture_db_id: Optional[str] = None
    current_phase: str = "BRAINDUMP"
    phase_progress: dict = {}
    pending_captures: list = []
    last_sync: Optional[str] = None
    session_count: int = 0
    created_at: str = ""
    last_active: str = ""


class HatcheryState(BaseModel):
    """Multi-project registry"""
    active_project: Optional[str] = None  # slug of active project
    projects: dict = {}  # slug -> ProjectState


def load_state() -> HatcheryState:
    """Load hatchery state from file"""
    STATE_DIR.mkdir(exist_ok=True)
    if PROJECTS_FILE.exists():
        data = json.loads(PROJECTS_FILE.read_text())
        # Convert project dicts back to ProjectState objects
        if "projects" in data:
            for slug, proj_data in data["projects"].items():
                if isinstance(proj_data, dict):
                    data["projects"][slug] = ProjectState(**proj_data)
        return HatcheryState(**data)
    return HatcheryState()


def save_state(state: HatcheryState):
    """Save hatchery state to file"""
    STATE_DIR.mkdir(exist_ok=True)
    # Convert ProjectState objects to dicts for JSON serialization
    data = {
        "active_project": state.active_project,
        "projects": {slug: proj.model_dump() for slug, proj in state.projects.items()}
    }
    PROJECTS_FILE.write_text(json.dumps(data, indent=2))


def get_active_project(state: HatcheryState) -> Optional[ProjectState]:
    """Get the currently active project"""
    if state.active_project and state.active_project in state.projects:
        return state.projects[state.active_project]
    return None


def slugify(name: str) -> str:
    """Convert project name to slug"""
    return name.lower().replace(" ", "-").replace("_", "-")


# --- Project Management Tools ---

@mcp.tool
def hatchery_list_projects() -> dict:
    """
    List all incubation projects.

    Shows project names, current phase, and last activity.
    Use this to see what projects are available to work on.
    """
    state = load_state()

    if not state.projects:
        return {
            "projects": [],
            "active_project": None,
            "voice_summary": "No projects yet. Say 'create project' followed by a name to start one."
        }

    project_list = []
    for slug, proj in state.projects.items():
        project_list.append({
            "slug": slug,
            "name": proj.name,
            "phase": proj.current_phase,
            "phase_index": PHASES.index(proj.current_phase),
            "last_active": proj.last_active,
            "is_active": slug == state.active_project
        })

    # Sort by last_active, most recent first
    project_list.sort(key=lambda x: x["last_active"], reverse=True)

    active_name = state.projects[state.active_project].name if state.active_project else None

    return {
        "projects": project_list,
        "active_project": state.active_project,
        "active_project_name": active_name,
        "voice_summary": f"{len(project_list)} projects. Currently on {active_name or 'none'}."
    }


@mcp.tool
def hatchery_select(project: str) -> dict:
    """
    Switch to a different incubation project.

    Args:
        project: Project name or slug to switch to
    """
    state = load_state()
    slug = slugify(project)

    # Try exact slug match first
    if slug not in state.projects:
        # Try name match
        for s, p in state.projects.items():
            if p.name.lower() == project.lower():
                slug = s
                break
        else:
            available = [p.name for p in state.projects.values()]
            return {
                "error": f"Project '{project}' not found",
                "available": available,
                "voice_error": f"No project called {project}. Available: {', '.join(available[:3])}"
            }

    proj = state.projects[slug]
    proj.session_count += 1
    proj.last_active = datetime.now().isoformat()
    state.active_project = slug
    save_state(state)

    return {
        "selected": proj.name,
        "slug": slug,
        "phase": proj.current_phase,
        "session_number": proj.session_count,
        "voice_confirm": f"Switched to {proj.name}. Phase {PHASES.index(proj.current_phase)}: {proj.current_phase.lower()}."
    }


@mcp.tool
def hatchery_create(name: str, skip_notion: bool = False) -> dict:
    """
    Create a new incubation project.

    Automatically creates a Design Doc page in Notion if configured.

    Args:
        name: Human-readable project name
        skip_notion: If True, don't create Notion page (local-only mode)
    """
    state = load_state()
    slug = slugify(name)

    if slug in state.projects:
        return {
            "error": f"Project '{name}' already exists",
            "slug": slug,
            "voice_error": f"Project {name} already exists. Say 'select {name}' to work on it."
        }

    now = datetime.now().isoformat()
    notion_page_id = None
    notion_url = None

    # Auto-create Notion page if configured
    if not skip_notion and notion.hub_page_id:
        result = notion.create_project_page(name, slug)
        if result.get("created"):
            notion_page_id = result["page_id"]
            notion_url = result.get("url")

    project = ProjectState(
        name=name,
        slug=slug,
        notion_page_id=notion_page_id,
        created_at=now,
        last_active=now,
        session_count=1
    )

    state.projects[slug] = project
    state.active_project = slug
    save_state(state)

    return {
        "created": name,
        "slug": slug,
        "phase": "BRAINDUMP",
        "notion_page_id": notion_page_id,
        "notion_url": notion_url,
        "voice_confirm": f"Created {name}. Starting in braindump phase. What ideas do you have?"
    }


# --- Status & Navigation Tools ---

@mcp.tool
def hatchery_status() -> dict:
    """
    Get current project status and next action directive.

    Returns the active project, current phase, progress, and a clear
    directive for what to do next. Use this to orient at session start.
    """
    state = load_state()
    proj = get_active_project(state)

    if not proj:
        return {
            "error": "No active project",
            "projects_available": len(state.projects),
            "voice_error": "No project selected. Say 'list projects' or 'create project [name]'."
        }

    gaps = get_phase_gaps(proj)

    return {
        "project": proj.name,
        "slug": proj.slug,
        "current_phase": proj.current_phase,
        "phase_index": PHASES.index(proj.current_phase),
        "total_phases": len(PHASES),
        "phase_progress": proj.phase_progress,
        "next_action": PHASE_DIRECTIVES.get(proj.current_phase, "Unknown phase"),
        "gaps": gaps,
        "pending_captures": len(proj.pending_captures),
        "last_sync": proj.last_sync,
    }


@mcp.tool
def hatchery_capture(idea: str, idea_type: str = "Random") -> dict:
    """
    Quick capture an idea or note for the active project.

    Captures are stored locally and queued for Notion sync.
    Use this for fleeting thoughts during ideation sessions.

    Args:
        idea: The idea or note to capture
        idea_type: Category - one of: Research Question, Resource, Connection, Follow-up, Random
    """
    state = load_state()
    proj = get_active_project(state)

    if not proj:
        return {
            "error": "No active project",
            "voice_error": "No project selected. Say 'select [project]' first."
        }

    valid_types = ["Research Question", "Resource", "Connection", "Follow-up", "Random"]
    if idea_type not in valid_types:
        idea_type = "Random"

    capture = {
        "idea": idea,
        "type": idea_type,
        "captured_at": datetime.now().isoformat(),
        "phase": proj.current_phase,
        "synced": False,
    }

    proj.pending_captures.append(capture)
    proj.last_active = datetime.now().isoformat()
    save_state(state)

    return {
        "captured": idea,
        "type": idea_type,
        "project": proj.name,
        "pending_sync": len(proj.pending_captures),
        "voice_confirm": f"Got it. Captured as {idea_type.lower()}."
    }


@mcp.tool
def hatchery_advance(target_phase: str) -> dict:
    """
    Advance the active project to the next workflow phase.

    Validates that the current phase is complete before allowing
    advancement. Phases must progress sequentially.

    Args:
        target_phase: The phase to advance to (e.g., "CAPTURE", "EXPAND")
    """
    state = load_state()
    proj = get_active_project(state)

    if not proj:
        return {
            "error": "No active project",
            "voice_error": "No project selected."
        }

    target_phase = target_phase.upper()

    if target_phase not in PHASES:
        return {
            "error": f"Invalid phase: {target_phase}",
            "valid_phases": PHASES,
        }

    current_idx = PHASES.index(proj.current_phase)
    target_idx = PHASES.index(target_phase)

    # Must progress sequentially
    if target_idx != current_idx + 1:
        return {
            "error": "Must progress sequentially",
            "current_phase": proj.current_phase,
            "expected_next": PHASES[current_idx + 1] if current_idx + 1 < len(PHASES) else "COMPLETE",
            "requested": target_phase,
        }

    # Check phase completion requirements
    gaps = get_phase_gaps(proj)
    if gaps:
        return {
            "error": f"Phase {proj.current_phase} not complete",
            "gaps": gaps,
            "voice_error": f"Can't advance yet. Still need: {', '.join(gaps)}"
        }

    # Advance
    proj.phase_progress[proj.current_phase] = "complete"
    proj.current_phase = target_phase
    proj.last_active = datetime.now().isoformat()
    save_state(state)

    # Sync status to Notion if page exists
    notion_synced = False
    if proj.notion_page_id:
        result = notion.update_project_status(proj.notion_page_id, target_phase, proj.phase_progress)
        notion_synced = result.get("updated", False)

    return {
        "project": proj.name,
        "advanced_to": target_phase,
        "phase_index": target_idx,
        "next_action": PHASE_DIRECTIVES.get(target_phase),
        "notion_synced": notion_synced,
        "voice_confirm": f"Advanced to {target_phase}. {PHASE_DIRECTIVES.get(target_phase, '')}"
    }


# --- Voice-Optimized Tools ---

@mcp.tool
def hatchery_recap() -> str:
    """
    Get a brief spoken summary of current state.

    Returns 2-3 sentences optimized for voice output.
    Use this at the start of voice sessions.
    """
    state = load_state()
    proj = get_active_project(state)

    if not proj:
        count = len(state.projects)
        if count == 0:
            return "No projects yet. Say 'create project' with a name to start."
        return f"No project selected. You have {count} projects. Say 'list projects' to see them."

    phase = proj.current_phase.lower()
    phase_num = PHASES.index(proj.current_phase)

    lines = [f"Working on {proj.name}."]
    lines.append(f"Phase {phase_num}: {phase}.")

    gaps = get_phase_gaps(proj)
    if gaps:
        lines.append(f"Need to complete: {gaps[0].replace('_', ' ')}.")
    else:
        lines.append("Ready to advance when you are.")

    return " ".join(lines)


@mcp.tool
def hatchery_next() -> str:
    """
    Get the single next action as a directive.

    Returns one imperative sentence telling you exactly what to do.
    Perfect for voice-first interaction.
    """
    state = load_state()
    proj = get_active_project(state)

    if not proj:
        if not state.projects:
            return "Create a project first. Say 'create project [name]'."
        return "Select a project first. Say 'list projects' to see options."

    gaps = get_phase_gaps(proj)
    if gaps:
        return f"First, {gaps[0].replace('_', ' ')}."

    return PHASE_DIRECTIVES.get(proj.current_phase, "Check status for guidance.")


@mcp.tool
def hatchery_gaps() -> dict:
    """
    List what's missing for current phase completion.

    Returns a numbered list of gaps, speakable format.
    """
    state = load_state()
    proj = get_active_project(state)

    if not proj:
        return {
            "error": "No active project",
            "voice_error": "No project selected."
        }

    gaps = get_phase_gaps(proj)

    if not gaps:
        return {
            "project": proj.name,
            "phase": proj.current_phase,
            "gaps": [],
            "voice_summary": f"{proj.current_phase} phase is complete. Ready to advance."
        }

    voice_list = ". ".join([f"{i+1}, {g.replace('_', ' ')}" for i, g in enumerate(gaps)])

    return {
        "project": proj.name,
        "phase": proj.current_phase,
        "gaps": gaps,
        "voice_summary": f"Missing for {proj.current_phase}: {voice_list}."
    }


# --- Helper Functions ---

def get_phase_gaps(proj: ProjectState) -> list:
    """Check what's missing for phase completion"""
    gaps = []
    phase = proj.current_phase

    # Simplified gap checking - real implementation would check Notion/files
    if phase == "BRAINDUMP":
        if proj.phase_progress.get("BRAINDUMP") != "complete":
            if not proj.pending_captures:
                gaps.append("add_source_materials_or_captures")

    elif phase == "CAPTURE":
        if proj.phase_progress.get("CAPTURE") != "complete":
            gaps.append("complete_visualization_walkthrough")

    elif phase == "EXPAND":
        if proj.phase_progress.get("EXPAND") != "complete":
            gaps.append("answer_six_macro_questions")

    elif phase == "SPECIFY":
        if proj.phase_progress.get("SPECIFY") != "complete":
            gaps.append("generate_prd")

    elif phase == "ARCHITECT":
        if proj.phase_progress.get("ARCHITECT") != "complete":
            gaps.append("complete_technical_design")

    elif phase == "CONFIGURE":
        if proj.phase_progress.get("CONFIGURE") != "complete":
            gaps.append("setup_environment")

    elif phase == "SEED":
        if proj.phase_progress.get("SEED") != "complete":
            gaps.append("generate_scaffold")

    return gaps


# --- Notion Sync ---

@mcp.tool
def hatchery_sync() -> dict:
    """
    Sync pending captures to Notion for the active project.

    Pushes any locally captured ideas to Notion's Quick Capture
    database, then updates state.
    """
    state = load_state()
    proj = get_active_project(state)

    if not proj:
        return {
            "error": "No active project",
            "voice_error": "No project selected."
        }

    pending_count = len(proj.pending_captures)

    if not pending_count:
        return {
            "synced_count": 0,
            "project": proj.name,
            "last_sync": proj.last_sync,
            "voice_confirm": "Already in sync. No pending captures."
        }

    if not notion.is_configured:
        return {
            "synced_count": 0,
            "failed_count": pending_count,
            "error": "Notion not configured - captures stored locally only",
            "notion_status": notion.get_status(),
            "voice_confirm": "Notion not configured. Captures saved locally."
        }

    # Sync to Notion
    result = notion.sync_captures(proj.pending_captures)

    if result["synced"] > 0:
        proj.pending_captures = proj.pending_captures[result["synced"]:]
        proj.last_sync = datetime.now().isoformat()
        save_state(state)

    return {
        "project": proj.name,
        "synced_count": result["synced"],
        "failed_count": result["failed"],
        "notion_ids": result.get("notion_ids", []),
        "errors": result.get("errors", []),
        "last_sync": proj.last_sync,
        "voice_confirm": f"Synced {result['synced']} captures to Notion." if result["synced"] else "Sync failed."
    }


@mcp.tool
def hatchery_notion_status() -> dict:
    """
    Check Notion integration status.

    Returns whether Notion is properly configured and connected.
    """
    status = notion.get_status()

    if status["configured"] and status["initialized"]:
        voice = "Notion is connected and ready."
    elif status["configured"]:
        voice = "Notion is configured but not connected. Check API key."
    else:
        voice = "Notion not configured. Set environment variables."

    return {
        **status,
        "voice_summary": voice
    }


# --- Run Server ---

if __name__ == "__main__":
    mcp.run()
