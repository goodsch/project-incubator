#!/bin/bash
# Project Incubator Setup Script
# Run this after cloning the template

set -e

echo "🚀 Setting up Project Incubator..."
echo ""

# Install Claude Code plugins
echo "📦 Installing Claude Code plugins..."

if command -v claude &> /dev/null; then
    claude plugins install claude-mem@thedotmack 2>/dev/null || echo "  ⚠️  claude-mem may already be installed"
    claude plugins install prompt-improver@severity1-marketplace 2>/dev/null || echo "  ⚠️  prompt-improver may already be installed"
    echo "  ✅ Plugins configured"
else
    echo "  ⚠️  Claude CLI not found - install plugins manually:"
    echo "     claude plugins install claude-mem@thedotmack"
    echo "     claude plugins install prompt-improver@severity1-marketplace"
fi

# Install hook dependencies
if [ -f ".claude/hooks/package.json" ]; then
    echo "📦 Installing hook dependencies..."
    cd .claude/hooks && npm install && cd ../..
    echo "  ✅ Hook dependencies installed"
fi

# Create .env from example if it doesn't exist
if [ ! -f ".env" ] && [ -f ".env.example" ]; then
    cp .env.example .env
fi

echo ""
echo "🔑 Configure API keys (optional - press Enter to skip)"
echo ""

# Prompt for Notion API key
read -p "Notion API Key (https://notion.so/my-integrations): " notion_key
if [ -n "$notion_key" ]; then
    sed -i "s|^NOTION_API_KEY=.*|NOTION_API_KEY=${notion_key}|" .env
    echo "  ✅ Notion API key configured"
fi

# Prompt for Firecrawl API URL
read -p "Firecrawl API URL (https://firecrawl.dev): " firecrawl_url
if [ -n "$firecrawl_url" ]; then
    sed -i "s|^FIRECRAWL_API_URL=.*|FIRECRAWL_API_URL=${firecrawl_url}|" .env
    echo "  ✅ Firecrawl API URL configured"
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Run 'claude' to start"
echo "  2. Run '/init your-project-name' to initialize"
echo ""
