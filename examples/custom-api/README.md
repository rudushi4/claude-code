# Custom API Endpoint Examples

This directory contains examples for configuring Claude Code with custom API endpoints.

## Quick Start

### 1. Copy the environment file

```bash
cp .env.example .env
```

### 2. Edit the configuration

```bash
# Open .env and set your values
nano .env
```

### 3. Load and run

```bash
# Load environment variables
source .env

# Or use dotenv
export $(cat .env | xargs)

# Run Claude Code
claude
```

## Configuration Patterns

### Pattern 1: Simple Proxy

```bash
export ANTHROPIC_BASE_URL="https://proxy.example.com/v1"
export ANTHROPIC_API_KEY="sk-xxx"
claude
```

### Pattern 2: Local Development Proxy

```bash
# Start your local proxy first (e.g., claude-code-router)
export ANTHROPIC_BASE_URL="http://127.0.0.1:3456"
export ANTHROPIC_API_KEY="any-key"
export NO_PROXY="127.0.0.1"
claude
```

### Pattern 3: Corporate Proxy

```bash
export HTTPS_PROXY="http://corporate-proxy:8080"
export ANTHROPIC_API_KEY="sk-xxx"
claude
```

## Using with Claude Code Router

For advanced multi-provider routing:

```bash
# Install router
npm install -g @musistudio/claude-code-router

# Start with router (auto-configures ANTHROPIC_BASE_URL)
ccr code

# Or activate environment and use claude directly
eval "$(ccr activate)"
claude
```

## Comparison with Other SDKs

| SDK | Base URL Config | API Key Config |
|-----|-----------------|----------------|
| **Claude Code** | `ANTHROPIC_BASE_URL` | `ANTHROPIC_API_KEY` |
| Google Generative AI | `baseURL` parameter | `apiKey` parameter |
| OpenAI SDK | `OPENAI_BASE_URL` | `OPENAI_API_KEY` |

## Files

- `.env.example` - Example environment configuration
- `README.md` - This documentation

## Related

- [Custom API Documentation](../../docs/CUSTOM_API.md)
- [Claude Code Router](https://github.com/musistudio/claude-code-router)
