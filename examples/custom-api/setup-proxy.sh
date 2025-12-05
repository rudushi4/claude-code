#!/bin/bash
# Setup script for Claude Code with custom API endpoint
# Usage: source setup-proxy.sh

# ===========================================
# CONFIGURATION - Modify these values
# ===========================================

# Custom base URL for API calls (proxy server)
# Default: https://api.anthropic.com
export ANTHROPIC_BASE_URL="${ANTHROPIC_BASE_URL:-https://api.anthropic.com}"

# API key
export ANTHROPIC_API_KEY="${ANTHROPIC_API_KEY:-}"

# ===========================================
# OPTIONAL: Proxy settings
# ===========================================

# HTTP/HTTPS proxy (uncomment if needed)
# export HTTP_PROXY="http://127.0.0.1:7890"
# export HTTPS_PROXY="http://127.0.0.1:7890"
# export NO_PROXY="localhost,127.0.0.1"

# ===========================================
# OPTIONAL: Debug settings
# ===========================================

# Uncomment to enable debug logging
# export ANTHROPIC_LOG="debug"

# Uncomment to disable telemetry
# export DISABLE_TELEMETRY="true"

# ===========================================
# Validation
# ===========================================

echo "Claude Code Custom API Configuration"
echo "====================================="
echo "Base URL: $ANTHROPIC_BASE_URL"

if [ -z "$ANTHROPIC_API_KEY" ]; then
    echo "⚠️  Warning: ANTHROPIC_API_KEY is not set"
    echo "   Set it with: export ANTHROPIC_API_KEY='your-key'"
else
    echo "API Key: ****${ANTHROPIC_API_KEY: -4}"
fi

if [ -n "$HTTP_PROXY" ]; then
    echo "HTTP Proxy: $HTTP_PROXY"
fi

if [ -n "$HTTPS_PROXY" ]; then
    echo "HTTPS Proxy: $HTTPS_PROXY"
fi

echo ""
echo "Run 'claude' to start Claude Code with these settings."
