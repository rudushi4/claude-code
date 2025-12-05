#!/data/data/com.termux/files/usr/bin/bash
# ============================================
# Claude Code + Multi-Provider Setup for Termux
# ============================================
# Usage: curl -fsSL https://raw.githubusercontent.com/rudushi4/claude-code/main/termux-setup/install.sh | bash

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${BLUE}"
echo "╔════════════════════════════════════════════╗"
echo "║  Claude Code Multi-Provider Setup          ║"
echo "║  for Termux                                ║"
echo "╚════════════════════════════════════════════╝"
echo -e "${NC}"

# Check if running in Termux
if [ ! -d "/data/data/com.termux" ]; then
    echo -e "${YELLOW}Warning: Not running in Termux. Script may not work correctly.${NC}"
fi

# ============================================
# Step 1: Update packages
# ============================================
echo -e "${GREEN}[1/6] Updating packages...${NC}"
pkg update -y && pkg upgrade -y

# ============================================
# Step 2: Install Node.js
# ============================================
echo -e "${GREEN}[2/6] Installing Node.js...${NC}"
pkg install -y nodejs-lts

NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
echo "Node.js version: $(node -v)"

if [ "$NODE_VERSION" -lt 20 ]; then
    echo -e "${YELLOW}Warning: Node.js 20+ recommended. Installing latest...${NC}"
    pkg install -y nodejs
fi

# ============================================
# Step 3: Install dependencies
# ============================================
echo -e "${GREEN}[3/6] Installing dependencies...${NC}"
pkg install -y git curl

# ============================================
# Step 4: Install Claude Code
# ============================================
echo -e "${GREEN}[4/6] Installing Claude Code...${NC}"
npm install -g @anthropic-ai/claude-code

# ============================================
# Step 5: Install Claude Code Router
# ============================================
echo -e "${GREEN}[5/6] Installing Claude Code Router...${NC}"
npm install -g @musistudio/claude-code-router

# ============================================
# Step 6: Configure API Provider
# ============================================
echo -e "${GREEN}[6/6] Configuring API Provider...${NC}"

mkdir -p ~/.claude-code-router

echo ""
echo -e "${CYAN}Select your API provider:${NC}"
echo ""
echo "  1) Google Gemini (gemini-2.5-flash, gemini-2.5-pro)"
echo "  2) OpenAI (gpt-4o, gpt-4-turbo)"
echo "  3) DeepSeek (deepseek-chat, deepseek-coder)"
echo "  4) Codestral/Mistral (codestral-latest)"
echo "  5) OpenRouter (any model)"
echo "  6) Ollama (local models)"
echo "  7) Custom endpoint"
echo ""
read -p "Enter choice [1-7]: " PROVIDER_CHOICE

case $PROVIDER_CHOICE in
    1)
        PROVIDER="gemini"
        API_URL="https://generativelanguage.googleapis.com/v1beta/models/"
        MODELS='["gemini-2.5-flash", "gemini-2.5-pro", "gemini-2.0-flash"]'
        DEFAULT_MODEL="gemini,gemini-2.0-flash"
        THINK_MODEL="gemini,gemini-2.5-pro"
        TRANSFORMER='{"use": ["gemini"]}'
        echo -e "${YELLOW}Get API key: https://aistudio.google.com/app/apikey${NC}"
        ;;
    2)
        PROVIDER="openai"
        API_URL="https://api.openai.com/v1"
        MODELS='["gpt-4o", "gpt-4-turbo", "gpt-4o-mini"]'
        DEFAULT_MODEL="openai,gpt-4o-mini"
        THINK_MODEL="openai,gpt-4o"
        TRANSFORMER='{}'
        echo -e "${YELLOW}Get API key: https://platform.openai.com/api-keys${NC}"
        ;;
    3)
        PROVIDER="deepseek"
        API_URL="https://api.deepseek.com/v1"
        MODELS='["deepseek-chat", "deepseek-coder", "deepseek-reasoner"]'
        DEFAULT_MODEL="deepseek,deepseek-chat"
        THINK_MODEL="deepseek,deepseek-reasoner"
        TRANSFORMER='{"use": ["deepseek"]}'
        echo -e "${YELLOW}Get API key: https://platform.deepseek.com/api_keys${NC}"
        ;;
    4)
        PROVIDER="codestral"
        API_URL="https://codestral.mistral.ai/v1/chat/completions"
        MODELS='["codestral-latest", "codestral-2501"]'
        DEFAULT_MODEL="codestral,codestral-latest"
        THINK_MODEL="codestral,codestral-latest"
        TRANSFORMER='{}'
        echo -e "${YELLOW}Get API key: https://console.mistral.ai/api-keys${NC}"
        ;;
    5)
        PROVIDER="openrouter"
        API_URL="https://openrouter.ai/api/v1"
        MODELS='["anthropic/claude-3.5-sonnet", "openai/gpt-4o", "google/gemini-pro-1.5"]'
        DEFAULT_MODEL="openrouter,anthropic/claude-3.5-sonnet"
        THINK_MODEL="openrouter,anthropic/claude-3.5-sonnet"
        TRANSFORMER='{"use": ["openrouter"]}'
        echo -e "${YELLOW}Get API key: https://openrouter.ai/keys${NC}"
        ;;
    6)
        PROVIDER="ollama"
        API_URL="http://localhost:11434/v1"
        MODELS='["llama3.2", "codellama", "deepseek-coder-v2"]'
        DEFAULT_MODEL="ollama,llama3.2"
        THINK_MODEL="ollama,llama3.2"
        TRANSFORMER='{}'
        echo -e "${YELLOW}Make sure Ollama is running: ollama serve${NC}"
        ;;
    7)
        PROVIDER="custom"
        echo -e "${YELLOW}Enter custom API base URL:${NC}"
        read -r API_URL
        echo -e "${YELLOW}Enter model name:${NC}"
        read -r MODEL_NAME
        MODELS="[\"$MODEL_NAME\"]"
        DEFAULT_MODEL="custom,$MODEL_NAME"
        THINK_MODEL="custom,$MODEL_NAME"
        TRANSFORMER='{}'
        ;;
    *)
        echo -e "${RED}Invalid choice. Using Gemini as default.${NC}"
        PROVIDER="gemini"
        API_URL="https://generativelanguage.googleapis.com/v1beta/models/"
        MODELS='["gemini-2.5-flash", "gemini-2.5-pro", "gemini-2.0-flash"]'
        DEFAULT_MODEL="gemini,gemini-2.0-flash"
        THINK_MODEL="gemini,gemini-2.5-pro"
        TRANSFORMER='{"use": ["gemini"]}'
        ;;
esac

echo ""
echo -e "${YELLOW}Enter your API Key:${NC}"
read -r API_KEY

if [ -z "$API_KEY" ]; then
    echo -e "${RED}No API key provided. Using placeholder.${NC}"
    API_KEY="YOUR_API_KEY"
fi

# Create config file
cat > ~/.claude-code-router/config.json << EOF
{
  "LOG": true,
  "API_TIMEOUT_MS": 600000,
  "Providers": [
    {
      "name": "$PROVIDER",
      "api_base_url": "$API_URL",
      "api_key": "$API_KEY",
      "models": $MODELS,
      "transformer": $TRANSFORMER
    }
  ],
  "Router": {
    "default": "$DEFAULT_MODEL",
    "think": "$THINK_MODEL",
    "longContext": "$THINK_MODEL",
    "longContextThreshold": 60000
  }
}
EOF

# Create launcher script
cat > ~/claude-code << 'LAUNCHER'
#!/data/data/com.termux/files/usr/bin/bash
ccr code "$@"
LAUNCHER
chmod +x ~/claude-code

# Add aliases to bashrc
if ! grep -q "alias cc=" ~/.bashrc 2>/dev/null; then
    echo 'alias cc="ccr code"' >> ~/.bashrc
    echo 'alias claude="ccr code"' >> ~/.bashrc
fi

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  Installation Complete!                     ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════╝${NC}"
echo ""
echo -e "Provider: ${CYAN}$PROVIDER${NC}"
echo -e "Config: ${BLUE}~/.claude-code-router/config.json${NC}"
echo ""
echo -e "${YELLOW}To start Claude Code:${NC}"
echo "  ccr code"
echo "  cc        (alias)"
echo "  claude    (alias)"
echo ""
echo -e "${YELLOW}Switch models:${NC}"
echo "  /model $DEFAULT_MODEL"
echo ""

source ~/.bashrc 2>/dev/null || true
echo -e "${GREEN}Run 'ccr code' to start!${NC}"
