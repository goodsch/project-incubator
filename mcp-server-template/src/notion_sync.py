"""
Notion integration for Hatchery MCP Server

Provides visibility and observability via Notion:
- Hub Page: Dashboard showing all projects
- Project Pages: Design Doc for each project (child of hub)
- Quick Capture: Database for rapid idea capture
- State Sync: Phase progress visible in Notion

Environment Variables:
- NOTION_API_KEY: Notion integration token
- NOTION_HUB_PAGE_ID: Parent page ID for all projects
- NOTION_IDEAS_DB_ID: Quick Capture database ID
"""

import os
from datetime import datetime
from typing import Optional
from notion_client import Client
from notion_client.errors import APIResponseError


# Map capture types to Notion select options
CAPTURE_TYPE_MAP = {
    "Research Question": "❓ Question",
    "Resource": "📝 Note",
    "Connection": "💡 Idea",
    "Follow-up": "✨ Feature",
    "Random": "💡 Idea",
    "💡 Idea": "💡 Idea",
    "🐛 Issue": "🐛 Issue",
    "✨ Feature": "✨ Feature",
    "❓ Question": "❓ Question",
    "📝 Note": "📝 Note",
}

# Phase emoji mapping for visual status
PHASE_EMOJI = {
    "INCUBATE": "🧠",
    "CAPTURE": "📸",
    "EXPAND": "🔍",
    "SPECIFY": "📋",
    "ARCHITECT": "🏗️",
    "CONFIGURE": "⚙️",
    "SEED": "🌱",
}


class NotionSync:
    """Handles all Notion API interactions for Hatchery"""

    def __init__(self):
        self.api_key = os.environ.get("NOTION_API_KEY")
        self.hub_page_id = os.environ.get("NOTION_HUB_PAGE_ID")
        self.ideas_db_id = os.environ.get("NOTION_IDEAS_DB_ID")

        self._client = None
        self._initialized = False
        self._init_error = None

    @property
    def client(self) -> Optional[Client]:
        """Lazy initialization of Notion client"""
        if self._client is None and self.api_key:
            try:
                self._client = Client(auth=self.api_key)
                self._initialized = True
            except Exception as e:
                self._init_error = str(e)
        return self._client

    @property
    def is_configured(self) -> bool:
        """Check if Notion is properly configured"""
        return bool(self.api_key and (self.hub_page_id or self.ideas_db_id))

    def get_status(self) -> dict:
        """Get Notion connection status"""
        return {
            "configured": self.is_configured,
            "api_key_set": bool(self.api_key),
            "hub_page_set": bool(self.hub_page_id),
            "hub_page_id": self.hub_page_id,
            "ideas_db_set": bool(self.ideas_db_id),
            "ideas_db_id": self.ideas_db_id,
            "initialized": self._initialized,
            "error": self._init_error,
        }

    # --- Project Page Management ---

    def create_project_page(self, name: str, slug: str) -> dict:
        """
        Create a Design Doc page for a new project under the hub.

        Args:
            name: Human-readable project name
            slug: URL-safe project identifier

        Returns:
            Dict with page_id if successful, error otherwise
        """
        if not self.hub_page_id:
            return {"error": "Hub page not configured", "created": False}

        if not self.client:
            return {"error": self._init_error or "Notion client failed", "created": False}

        try:
            # Create the project page with Design Doc structure
            response = self.client.pages.create(
                parent={"page_id": self.hub_page_id},
                properties={
                    "title": [{"text": {"content": name}}]
                },
                children=self._build_design_doc_template(name, slug)
            )

            return {
                "page_id": response["id"],
                "url": response.get("url"),
                "created": True,
            }

        except APIResponseError as e:
            return {"error": f"Notion API error: {e.message}", "created": False}
        except Exception as e:
            return {"error": f"Create failed: {str(e)}", "created": False}

    def _build_design_doc_template(self, name: str, slug: str) -> list:
        """Build the Design Doc page content blocks"""
        now = datetime.now().strftime("%Y-%m-%d")

        return [
            # Status header
            {
                "type": "callout",
                "callout": {
                    "icon": {"emoji": "🧠"},
                    "color": "blue_background",
                    "rich_text": [{"text": {"content": f"Phase: INCUBATE | Created: {now}"}}]
                }
            },
            # Overview section
            {"type": "heading_2", "heading_2": {"rich_text": [{"text": {"content": "Overview"}}]}},
            {"type": "paragraph", "paragraph": {"rich_text": [{"text": {"content": "What is this project about? (Fill in during CAPTURE phase)"}}]}},
            # The Idea section
            {"type": "heading_2", "heading_2": {"rich_text": [{"text": {"content": "The Idea"}}]}},
            {"type": "paragraph", "paragraph": {"rich_text": [{"text": {"content": "Core insight in one sentence..."}}]}},
            # Braindump section
            {"type": "heading_2", "heading_2": {"rich_text": [{"text": {"content": "Braindump"}}]}},
            {"type": "paragraph", "paragraph": {"rich_text": [{"text": {"content": "Raw thoughts, references, inspirations..."}}]}},
            {"type": "bulleted_list_item", "bulleted_list_item": {"rich_text": [{"text": {"content": "(Add ideas here)"}}]}},
            # Captures section
            {"type": "heading_2", "heading_2": {"rich_text": [{"text": {"content": "Captures"}}]}},
            {"type": "paragraph", "paragraph": {"rich_text": [{"text": {"content": "Ideas captured via voice/MCP sync here..."}}]}},
            # Open Questions
            {"type": "heading_2", "heading_2": {"rich_text": [{"text": {"content": "Open Questions"}}]}},
            {"type": "to_do", "to_do": {"rich_text": [{"text": {"content": "What needs to be answered?"}}], "checked": False}},
            # Divider before later phases
            {"type": "divider", "divider": {}},
            # PRD section (Phase 3)
            {"type": "heading_2", "heading_2": {"rich_text": [{"text": {"content": "📋 PRD (Phase 3: SPECIFY)"}}]}},
            {"type": "paragraph", "paragraph": {"rich_text": [{"text": {"content": "(Generated after EXPAND phase)"}}]}},
            # Architecture section (Phase 4)
            {"type": "heading_2", "heading_2": {"rich_text": [{"text": {"content": "🏗️ Architecture (Phase 4: ARCHITECT)"}}]}},
            {"type": "paragraph", "paragraph": {"rich_text": [{"text": {"content": "(Generated after SPECIFY phase)"}}]}},
        ]

    def update_project_status(self, page_id: str, phase: str, progress: dict) -> dict:
        """
        Update project status in Notion (callout block at top).

        Args:
            page_id: Notion page ID
            phase: Current phase name
            progress: Dict of phase -> status

        Returns:
            Result dict
        """
        if not self.client:
            return {"error": "Notion client not initialized", "updated": False}

        try:
            # Get the page blocks to find the status callout
            blocks = self.client.blocks.children.list(block_id=page_id)

            # Find and update the callout block (first one)
            for block in blocks.get("results", []):
                if block.get("type") == "callout":
                    emoji = PHASE_EMOJI.get(phase, "📝")
                    completed = [p for p, s in progress.items() if s == "complete"]
                    progress_str = f" | Completed: {', '.join(completed)}" if completed else ""

                    self.client.blocks.update(
                        block_id=block["id"],
                        callout={
                            "icon": {"emoji": emoji},
                            "color": "blue_background",
                            "rich_text": [{"text": {"content": f"Phase: {phase}{progress_str}"}}]
                        }
                    )
                    return {"updated": True, "phase": phase}

            return {"error": "Status callout not found", "updated": False}

        except Exception as e:
            return {"error": str(e), "updated": False}

    def append_capture_to_page(self, page_id: str, capture: dict) -> dict:
        """
        Append a capture to the project's Captures section.

        Args:
            page_id: Project page ID
            capture: Capture dict with idea, type, captured_at

        Returns:
            Result dict
        """
        if not self.client:
            return {"error": "Notion client not initialized", "appended": False}

        try:
            idea = capture.get("idea", "")
            cap_type = capture.get("type", "Random")
            timestamp = capture.get("captured_at", datetime.now().isoformat())[:10]

            # Append as bullet under Captures
            self.client.blocks.children.append(
                block_id=page_id,
                children=[{
                    "type": "bulleted_list_item",
                    "bulleted_list_item": {
                        "rich_text": [
                            {"text": {"content": f"[{cap_type}] "}, "annotations": {"bold": True}},
                            {"text": {"content": idea}},
                            {"text": {"content": f" ({timestamp})"}, "annotations": {"color": "gray"}}
                        ]
                    }
                }]
            )
            return {"appended": True}

        except Exception as e:
            return {"error": str(e), "appended": False}

    def list_project_pages(self) -> list:
        """
        List all project pages under the hub.

        Returns:
            List of project dicts with id, name, url
        """
        if not self.hub_page_id or not self.client:
            return []

        try:
            response = self.client.blocks.children.list(block_id=self.hub_page_id)

            projects = []
            for block in response.get("results", []):
                if block.get("type") == "child_page":
                    projects.append({
                        "page_id": block["id"],
                        "name": block.get("child_page", {}).get("title", "Untitled"),
                    })

            return projects

        except Exception:
            return []

    # --- Quick Capture Database ---

    def create_capture(self, capture: dict) -> dict:
        """
        Create a capture in the Quick Capture database.

        Args:
            capture: Dict with keys: idea, type, captured_at, phase

        Returns:
            Dict with notion_id if successful
        """
        if not self.ideas_db_id:
            return {"error": "Quick Capture DB not configured", "synced": False}

        if not self.client:
            return {"error": self._init_error or "Notion client failed", "synced": False}

        try:
            capture_type = capture.get("type", "Random")
            notion_type = CAPTURE_TYPE_MAP.get(capture_type, "💡 Idea")
            idea_text = capture["idea"]

            properties = {
                "Capture": {"title": [{"text": {"content": idea_text[:2000]}}]},
                "Type": {"select": {"name": notion_type}},
                "Processed": {"checkbox": False},
            }

            response = self.client.pages.create(
                parent={"database_id": self.ideas_db_id},
                properties=properties
            )

            return {
                "notion_id": response["id"],
                "url": response.get("url"),
                "synced": True,
            }

        except APIResponseError as e:
            return {"error": f"Notion API error: {e.message}", "synced": False}
        except Exception as e:
            return {"error": f"Sync failed: {str(e)}", "synced": False}

    def sync_captures(self, captures: list) -> dict:
        """
        Sync multiple captures to Notion.

        Args:
            captures: List of capture dicts

        Returns:
            Summary of sync results
        """
        if not captures:
            return {"synced": 0, "failed": 0, "errors": []}

        if not self.is_configured:
            return {"synced": 0, "failed": len(captures), "errors": ["Notion not configured"]}

        results = {"synced": 0, "failed": 0, "errors": [], "notion_ids": []}

        for capture in captures:
            result = self.create_capture(capture)
            if result.get("synced"):
                results["synced"] += 1
                results["notion_ids"].append(result.get("notion_id"))
            else:
                results["failed"] += 1
                results["errors"].append(result.get("error"))

        return results

    def get_unprocessed_captures(self, limit: int = 10) -> list:
        """Get unprocessed captures from Quick Capture database."""
        if not self.ideas_db_id or not self.client:
            return []

        try:
            response = self.client.databases.query(
                database_id=self.ideas_db_id,
                filter={"property": "Processed", "checkbox": {"equals": False}},
                sorts=[{"timestamp": "created_time", "direction": "descending"}],
                page_size=limit
            )

            captures = []
            for page in response.get("results", []):
                props = page.get("properties", {})
                captures.append({
                    "notion_id": page["id"],
                    "idea": self._get_title(props.get("Capture", {})),
                    "type": self._get_select(props.get("Type", {})),
                    "created_at": page.get("created_time", ""),
                })

            return captures

        except Exception:
            return []

    # --- Helper methods ---

    def _get_title(self, prop: dict) -> str:
        title_list = prop.get("title", [])
        return title_list[0].get("text", {}).get("content", "") if title_list else ""

    def _get_select(self, prop: dict) -> str:
        select = prop.get("select")
        return select.get("name", "") if select else ""


# Singleton instance
notion = NotionSync()
