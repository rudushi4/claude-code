# Claude Code Multi-Provider Setup for Termux

Run Claude Code on Android using various AI providers (Gemini, OpenAI, DeepSeek, Codestral, OpenRouter, Ollama).

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/rudushi4/claude-code/main/termux-setup/install.sh | bash
```

## One-Line Install (with provider)

```bash
# Gemini
curl -fsSL https://raw.githubusercontent.com/rudushi4/claude-code/main/termux-setup/quick-install.sh | bash -s -- gemini YOUR_API_KEY

# Codestral (Mistral)
curl -fsSL https://raw.githubusercontent.com/rudushi4/claude-code/main/termux-setup/quick-install.sh | bash -s -- codestral YOUR_API_KEY

# OpenAI
curl -fsSL https://raw.githubusercontent.com/rudushi4/claude-code/main/termux-setup/quick-install.sh | bash -s -- openai YOUR_API_KEY

# DeepSeek
curl -fsSL https://raw.githubusercontent.com/rudushi4/claude-code/main/termux-setup/quick-install.sh | bash -s -- deepseek YOUR_API_KEY
```

## Supported Providers

| Provider | Models | API Key URL |
|----------|--------|-------------|
| **Gemini** | gemini-2.5-flash, gemini-2.5-pro | [aistudio.google.com](https://aistudio.google.com/app/apikey) |
| **Codestral** | codestral-latest, codestral-2501 | [console.mistral.ai](https://console.mistral.ai/api-keys) |
| **OpenAI** | gpt-4o, gpt-4-turbo, gpt-4o-mini | [platform.openai.com](https://platform.openai.com/api-keys) |
| **DeepSeek** | deepseek-chat, deepseek-coder | [platform.deepseek.com](https://platform.deepseek.com/api_keys) |
| **OpenRouter** | Any model | [openrouter.ai](https://openrouter.ai/keys) |
| **Ollama** | Local models | N/A (local) |

## Manual Installation

### Step 1: Install Termux
Download from F-Droid: https://f-droid.org/packages/com.termux/

### Step 2: Setup Storage
```bash
termux-setup-storage
```

### Step 3: Run Installer
```bash
pkg update && pkg install -y curl
curl -fsSL https://raw.githubusercontent.com/rudushi4/claude-code/main/termux-setup/install.sh | bash
```

## Usage

Start Claude Code:
```bash
ccr code
```

Shortcuts:
```bash
cc       # Short alias
claude   # Full alias
```

## Switch Models

Inside Claude Code, use `/model` command:

```
# Gemini
/model gemini,gemini-2.5-pro
/model gemini,gemini-2.5-flash

# Codestral
/model codestral,codestral-latest

# OpenAI
/model openai,gpt-4o

# DeepSeek  
/model deepseek,deepseek-reasoner
```

## Configuration

Edit config:
```bash
nano ~/.claude-code-router/config.json
```

## Codestral Endpoints

Codestral uses these endpoints:
- **Chat**: `https://codestral.mistral.ai/v1/chat/completions`
- **Completion**: `https://codestral.mistral.ai/v1/fim/completions`

## Troubleshooting

### "Missing model in request body"
```bash
ccr restart
```

### Node.js version error
```bash
pkg install -y nodejs
```

### Update packages
```bash
pkg update && pkg upgrade
npm update -g @anthropic-ai/claude-code @musistudio/claude-code-router
```

## Uninstall

```bash
npm uninstall -g @anthropic-ai/claude-code @musistudio/claude-code-router
rm -rf ~/.claude-code-router
```

## Links

- [Claude Code](https://github.com/anthropics/claude-code)
- [Claude Code Router](https://github.com/musistudio/claude-code-router)
- [Google AI Studio](https://aistudio.google.com/)
- [Mistral Console](https://console.mistral.ai/)
