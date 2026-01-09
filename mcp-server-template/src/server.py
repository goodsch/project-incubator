"""
Project Incubator MCP Server - Workflow orchestration for voice/CLI ideation

Exposes tools for:
- Status checking and next-action directives
- Quick idea capture with Notion sync
- Phase advancement with validation
- Voice-optimized summaries

Rename 'incubator_' prefix to your project name after copying.
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
    name="incubator",
    instructions="""Project Incubator is a workflow manager for turning ideas into buildable projects.

Use these tools to:
- Check current status and get the next action directive
- Capture ideas quickly (they sync to Notion)
- Advance through workflow phases
- Get voice-friendly summaries for mobile use

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
STATE_FILE = STATE_DIR / "workflow.json"
PROJECT_DIR = BASE_DIR.parent  # Project root

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

PHASE_REQUIREMENTS = {
    "BRAINDUMP": ["has_source_materials"],
    "CAPTURE": ["braindump_complete"],
    "EXPAND": ["capture_complete", "has_system_visual"],
    "SPECIFY": ["expand_complete"],
    "ARCHITECT": ["specify_complete", "has_prd"],
    "CONFIGURE": ["architect_complete"],
    "SEED": ["configure_complete"],
}


# --- State Management ---

class WorkflowState(BaseModel):
    """Persistent workflow state"""
    active_project: Optional[str] = None
    current_phase: str = "BRAINDUMP"
    phase_progress: dict = {}
    pending_captures: list = []
    last_sync: Optional[str] = None
    session_count: int = 0


def load_state() -> WorkflowState:
    """Load workflow state from file"""
    STATE_DIR.mkdir(exist_ok=True)
    if STATE_FILE.exists():
        data = json.loads(STATE_FILE.read_text())
        return WorkflowState(**data)
    return WorkflowState()


def save_state(state: WorkflowState):
    """Save workflow state to file"""
    STATE_DIR.mkdir(exist_ok=True)
    STATE_FILE.write_text(state.model_dump_json(indent=2))


# --- Core Tools ---

@mcp.tool
def incubator_status() -> dict:
    """
    Get current workflow status and next action directive.

    Returns the active project, current phase, progress, and a clear
    directive for what to do next. Use this to orient yourself at the
    start of any session.
    """
    state = load_state()

    # Check for gaps in current phase
    gaps = get_phase_gaps(state.current_phase)

    return {
        "active_project": state.active_project or "(none set)",
        "current_phase": state.current_phase,
        "phase_index": PHASES.index(state.current_phase),
        "total_phases": len(PHASES),
        "phase_progress": state.phase_progress,
        "next_action": PHASE_DIRECTIVES.get(state.current_phase, "Unknown phase"),
        "gaps": gaps,
        "pending_captures": len(state.pending_captures),
        "last_sync": state.last_sync,
    }


@mcp.tool
def incubator_capture(idea: str, idea_type: str = "Random") -> dict:
    """
    Quick capture an idea or note.

    Captures are stored locally and queued for Notion sync.
    Use this for fleeting thoughts during ideation sessions.

    Args:
        idea: The idea or note to capture
        idea_type: Category - one of: Research Question, Resource, Connection, Follow-up, Random
    """
    state = load_state()

    valid_types = ["Research Question", "Resource", "Connection", "Follow-up", "Random"]
    if idea_type not in valid_types:
        idea_type = "Random"

    capture = {
        "idea": idea,
        "type": idea_type,
        "captured_at": datetime.now().isoformat(),
        "phase": state.current_phase,
        "project": state.active_project,
        "synced": False,
    }

    state.pending_captures.append(capture)
    save_state(state)

    return {
        "captured": idea,
        "type": idea_type,
        "pending_sync": len(state.pending_captures),
        "voice_confirm": f"Got it. Captured as {idea_type.lower()}."
    }


@mcp.tool
def incubator_advance(target_phase: str) -> dict:
    """
    Advance to the next workflow phase.

    Validates that the current phase is complete before allowing
    advancement. Phases must progress sequentially.

    Args:
        target_phase: The phase to advance to (e.g., "CAPTURE", "EXPAND")
    """
    state = load_state()
    target_phase = target_phase.upper()

    if target_phase not in PHASES:
        return {
            "error": f"Invalid phase: {target_phase}",
            "valid_phases": PHASES,
        }

    current_idx = PHASES.index(state.current_phase)
    target_idx = PHASES.index(target_phase)

    # Must progress sequentially
    if target_idx != current_idx + 1:
        return {
            "error": "Must progress sequentially",
            "current_phase": state.current_phase,
            "expected_next": PHASES[current_idx + 1] if current_idx + 1 < len(PHASES) else "COMPLETE",
            "requested": target_phase,
        }

    # Check phase completion requirements
    gaps = get_phase_gaps(state.current_phase)
    if gaps:
        return {
            "error": f"Phase {state.current_phase} not complete",
            "gaps": gaps,
            "voice_error": f"Can't advance yet. Still need: {', '.join(gaps)}"
        }

    # Advance
    state.phase_progress[state.current_phase] = "complete"
    state.current_phase = target_phase
    save_state(state)

    return {
        "advanced_to": target_phase,
        "phase_index": target_idx,
        "next_action": PHASE_DIRECTIVES.get(target_phase),
        "voice_confirm": f"Advanced to {target_phase}. {PHASE_DIRECTIVES.get(target_phase, '')}"
    }


@mcp.tool
def incubator_set_project(project_name: str) -> dict:
    """
    Set the active project for this workflow.

    Args:
        project_name: Name of the project being incubated
    """
    state = load_state()
    state.active_project = project_name
    state.session_count += 1
    save_state(state)

    return {
        "project_set": project_name,
        "session_number": state.session_count,
        "current_phase": state.current_phase,
        "voice_confirm": f"Working on {project_name}. You're in {state.current_phase} phase."
    }


# --- Voice-Optimized Tools ---

@mcp.tool
def incubator_recap() -> str:
    """
    Get a brief spoken summary of current state.

    Returns 2-3 sentences optimized for voice output.
    Use this at the start of voice sessions.
    """
    state = load_state()

    project = state.active_project or "no project"
    phase = state.current_phase.lower()
    phase_num = PHASES.index(state.current_phase)

    # Build voice-friendly summary
    lines = []
    lines.append(f"Working on {project}.")
    lines.append(f"Phase {phase_num}: {phase}.")

    gaps = get_phase_gaps(state.current_phase)
    if gaps:
        lines.append(f"Need to complete: {gaps[0]}.")
    else:
        lines.append("Ready to advance when you are.")

    return " ".join(lines)


@mcp.tool
def incubator_next() -> str:
    """
    Get the single next action as a directive.

    Returns one imperative sentence telling you exactly what to do.
    Perfect for voice-first interaction.
    """
    state = load_state()

    gaps = get_phase_gaps(state.current_phase)
    if gaps:
        return f"First, {gaps[0].replace('_', ' ')}."

    return PHASE_DIRECTIVES.get(state.current_phase, "Check status for guidance.")


@mcp.tool
def incubator_gaps() -> dict:
    """
    List what's missing for current phase completion.

    Returns a numbered list of gaps, speakable format.
    """
    state = load_state()
    gaps = get_phase_gaps(state.current_phase)

    if not gaps:
        return {
            "phase": state.current_phase,
            "gaps": [],
            "voice_summary": f"{state.current_phase} phase is complete. Ready to advance."
        }

    voice_list = ". ".join([f"{i+1}, {g.replace('_', ' ')}" for i, g in enumerate(gaps)])

    return {
        "phase": state.current_phase,
        "gaps": gaps,
        "voice_summary": f"Missing for {state.current_phase}: {voice_list}."
    }


# --- Helper Functions ---

def get_phase_gaps(phase: str) -> list:
    """Check what's missing for phase completion"""
    state = load_state()
    gaps = []

    requirements = PHASE_REQUIREMENTS.get(phase, [])

    for req in requirements:
        if req == "has_source_materials":
            source_dir = PROJECT_DIR / "braindump" / "source-materials"
            if not source_dir.exists() or not list(source_dir.glob("*.md")):
                gaps.append("add_source_materials")

        elif req == "braindump_complete":
            if state.phase_progress.get("BRAINDUMP") != "complete":
                gaps.append("complete_braindump")

        elif req == "capture_complete":
            if state.phase_progress.get("CAPTURE") != "complete":
                gaps.append("complete_capture")

        elif req == "has_system_visual":
            # Check for mermaid diagram in captures or docs
            gaps.append("create_system_visual")  # Simplified check

        elif req == "expand_complete":
            if state.phase_progress.get("EXPAND") != "complete":
                gaps.append("complete_expand")

        elif req == "specify_complete":
            if state.phase_progress.get("SPECIFY") != "complete":
                gaps.append("complete_specify")

        elif req == "has_prd":
            prd_file = PROJECT_DIR / "docs" / "prd.md"
            if not prd_file.exists():
                gaps.append("generate_prd")

        elif req == "architect_complete":
            if state.phase_progress.get("ARCHITECT") != "complete":
                gaps.append("complete_architect")

        elif req == "configure_complete":
            if state.phase_progress.get("CONFIGURE") != "complete":
                gaps.append("complete_configure")

    return gaps


# --- Notion Sync ---

@mcp.tool
def incubator_sync() -> dict:
    """
    Sync pending captures to Notion and refresh state.

    Pushes any locally captured ideas to Notion's Quick Capture
    database, then pulls latest project state.
    """
    state = load_state()
    pending_count = len(state.pending_captures)

    if not pending_count:
        return {
            "synced_count": 0,
            "last_sync": state.last_sync,
            "notion_configured": notion.is_configured,
            "voice_confirm": "Already in sync. No pending captures."
        }

    if not notion.is_configured:
        # Fall back to local-only mode
        for capture in state.pending_captures:
            capture["synced"] = False
        return {
            "synced_count": 0,
            "failed_count": pending_count,
            "error": "Notion not configured - captures stored locally only",
            "notion_status": notion.get_status(),
            "voice_confirm": "Notion not configured. Captures saved locally."
        }

    # Sync to Notion
    result = notion.sync_captures(state.pending_captures)

    if result["synced"] > 0:
        # Remove successfully synced captures
        state.pending_captures = state.pending_captures[result["synced"]:]
        state.last_sync = datetime.now().isoformat()
        save_state(state)

    return {
        "synced_count": result["synced"],
        "failed_count": result["failed"],
        "notion_ids": result.get("notion_ids", []),
        "errors": result.get("errors", []),
        "last_sync": state.last_sync,
        "voice_confirm": f"Synced {result['synced']} captures to Notion." if result["synced"] else "Sync failed. Check Notion config."
    }


@mcp.tool
def incubator_notion_status() -> dict:
    """
    Check Notion integration status.

    Returns whether Notion is properly configured and connected.
    Use this to troubleshoot sync issues.
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
