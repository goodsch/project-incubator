#!/bin/bash
# Project Incubator Setup Script
# Run this after cloning the template

set -e

echo "🚀 Setting up Project Incubator..."

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
    echo "📝 Creating .env from example..."
    cp .env.example .env
    echo "  ✅ .env created - update with your API keys"
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Update .env with your Notion API key (optional)"
echo "  2. Run 'claude' to start"
echo "  3. Run '/init your-project-name' to initialize"
