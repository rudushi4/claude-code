#!/data/data/com.termux/files/usr/bin/bash
# ============================================
# Claude Code + Gemini Setup for Termux
# ============================================
# Usage: curl -fsSL https://raw.githubusercontent.com/rudushi4/claude-code/main/termux-setup/install.sh | bash

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}"
echo "╔════════════════════════════════════════════╗"
echo "║  Claude Code + Gemini Setup for Termux     ║"
echo "╚════════════════════════════════════════════╝"
echo -e "${NC}"

# Step 1: Update packages
echo -e "${GREEN}[1/6] Updating packages...${NC}"
pkg update -y && pkg upgrade -y

# Step 2: Install Node.js
echo -e "${GREEN}[2/6] Installing Node.js...${NC}"
pkg install -y nodejs-lts || pkg install -y nodejs
echo "Node.js version: $(node -v)"

# Step 3: Install dependencies
echo -e "${GREEN}[3/6] Installing dependencies...${NC}"
pkg install -y git curl

# Step 4: Install Claude Code
echo -e "${GREEN}[4/6] Installing Claude Code...${NC}"
npm install -g @anthropic-ai/claude-code

# Step 5: Install Claude Code Router
echo -e "${GREEN}[5/6] Installing Claude Code Router...${NC}"
npm install -g @musistudio/claude-code-router

# Step 6: Configure for Gemini
echo -e "${GREEN}[6/6] Configuring for Google Gemini...${NC}"

mkdir -p ~/.claude-code-router

echo ""
echo -e "${YELLOW}Enter your Google Gemini API Key:${NC}"
echo "(Get one at: https://aistudio.google.com/app/apikey)"
read -r GEMINI_API_KEY

if [ -z "$GEMINI_API_KEY" ]; then
    GEMINI_API_KEY="YOUR_GOOGLE_API_KEY"
fi

cat > ~/.claude-code-router/config.json << EOF
{
  "LOG": true,
  "API_TIMEOUT_MS": 600000,
  "Providers": [
    {
      "name": "gemini",
      "api_base_url": "https://generativelanguage.googleapis.com/v1beta/models/",
      "api_key": "$GEMINI_API_KEY",
      "models": ["gemini-2.5-flash", "gemini-2.5-pro", "gemini-2.0-flash"],
      "transformer": {"use": ["gemini"]}
    }
  ],
  "Router": {
    "default": "gemini,gemini-2.0-flash",
    "think": "gemini,gemini-2.5-pro",
    "longContext": "gemini,gemini-2.5-pro"
  }
}
EOF

echo 'alias ccg="ccr code"' >> ~/.bashrc
echo 'alias claude-gemini="ccr code"' >> ~/.bashrc

echo ""
echo -e "${GREEN}✅ Installation Complete!${NC}"
echo ""
echo "To start: ccr code"
echo "Shortcuts: ccg or claude-gemini"
echo ""
echo "Switch models: /model gemini,gemini-2.5-pro"
