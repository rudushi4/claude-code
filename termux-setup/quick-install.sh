#!/data/data/com.termux/files/usr/bin/bash
# Quick one-liner install for Termux
# Usage: curl -fsSL URL | bash -s -- PROVIDER API_KEY
# Example: curl -fsSL URL | bash -s -- gemini YOUR_API_KEY
#          curl -fsSL URL | bash -s -- codestral YOUR_API_KEY

PROVIDER="${1:-gemini}"
API_KEY="${2:-YOUR_API_KEY}"

pkg update -y && pkg install -y nodejs-lts git curl
npm install -g @anthropic-ai/claude-code @musistudio/claude-code-router

mkdir -p ~/.claude-code-router

case $PROVIDER in
    gemini)
        API_URL="https://generativelanguage.googleapis.com/v1beta/models/"
        MODELS='["gemini-2.5-flash", "gemini-2.5-pro", "gemini-2.0-flash"]'
        DEFAULT="gemini,gemini-2.0-flash"
        THINK="gemini,gemini-2.5-pro"
        TRANSFORMER='{"use": ["gemini"]}'
        ;;
    openai)
        API_URL="https://api.openai.com/v1"
        MODELS='["gpt-4o", "gpt-4-turbo", "gpt-4o-mini"]'
        DEFAULT="openai,gpt-4o-mini"
        THINK="openai,gpt-4o"
        TRANSFORMER='{}'
        ;;
    deepseek)
        API_URL="https://api.deepseek.com/v1"
        MODELS='["deepseek-chat", "deepseek-coder", "deepseek-reasoner"]'
        DEFAULT="deepseek,deepseek-chat"
        THINK="deepseek,deepseek-reasoner"
        TRANSFORMER='{"use": ["deepseek"]}'
        ;;
    codestral|mistral)
        API_URL="https://codestral.mistral.ai/v1/chat/completions"
        MODELS='["codestral-latest", "codestral-2501"]'
        DEFAULT="codestral,codestral-latest"
        THINK="codestral,codestral-latest"
        TRANSFORMER='{}'
        ;;
    openrouter)
        API_URL="https://openrouter.ai/api/v1"
        MODELS='["anthropic/claude-3.5-sonnet", "openai/gpt-4o"]'
        DEFAULT="openrouter,anthropic/claude-3.5-sonnet"
        THINK="openrouter,anthropic/claude-3.5-sonnet"
        TRANSFORMER='{"use": ["openrouter"]}'
        ;;
    ollama)
        API_URL="http://localhost:11434/v1"
        MODELS='["llama3.2", "codellama"]'
        DEFAULT="ollama,llama3.2"
        THINK="ollama,llama3.2"
        TRANSFORMER='{}'
        ;;
    *)
        echo "Unknown provider: $PROVIDER"
        echo "Supported: gemini, openai, deepseek, codestral, mistral, openrouter, ollama"
        exit 1
        ;;
esac

cat > ~/.claude-code-router/config.json << EOF
{
  "LOG": true,
  "API_TIMEOUT_MS": 600000,
  "Providers": [{
    "name": "$PROVIDER",
    "api_base_url": "$API_URL",
    "api_key": "$API_KEY",
    "models": $MODELS,
    "transformer": $TRANSFORMER
  }],
  "Router": {
    "default": "$DEFAULT",
    "think": "$THINK"
  }
}
EOF

echo 'alias cc="ccr code"' >> ~/.bashrc
echo 'alias claude="ccr code"' >> ~/.bashrc
echo "Done! Run: ccr code"
