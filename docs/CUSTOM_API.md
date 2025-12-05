# Custom API Endpoint Configuration

Claude Code supports using custom API endpoints (baseURL) for connecting to proxy servers, self-hosted endpoints, or alternative API providers.

## Configuration Options

### Environment Variables

| Variable | Description | Default |
|----------|-------------|--------|
| `ANTHROPIC_BASE_URL` | Custom base URL for API calls | `https://api.anthropic.com` |
| `ANTHROPIC_API_KEY` | API key sent via authorization header | - |
| `ANTHROPIC_AUTH_TOKEN` | Alternative auth token | - |
| `HTTP_PROXY` | HTTP proxy server URL | - |
| `HTTPS_PROXY` | HTTPS proxy server URL | - |
| `NO_PROXY` | Comma-separated list of hosts to bypass proxy | - |

## Usage Examples

### 1. Using a Custom Base URL (Proxy Server)

```bash
# Set custom API endpoint
export ANTHROPIC_BASE_URL="https://your-proxy-server.com/v1"
export ANTHROPIC_API_KEY="your-api-key"

# Run Claude Code
claude
```

### 2. Using with a Local Proxy

```bash
# For local development/testing
export ANTHROPIC_BASE_URL="http://localhost:3456"
export ANTHROPIC_API_KEY="your-api-key"

claude
```

### 3. Using HTTP/HTTPS Proxy

```bash
# Configure proxy
export HTTP_PROXY="http://127.0.0.1:7890"
export HTTPS_PROXY="http://127.0.0.1:7890"
export NO_PROXY="localhost,127.0.0.1"

claude
```

### 4. Configuration in Shell Profile

Add to your `~/.bashrc`, `~/.zshrc`, or equivalent:

```bash
# Claude Code Custom API Configuration
export ANTHROPIC_BASE_URL="https://your-custom-endpoint.com/v1"
export ANTHROPIC_API_KEY="your-api-key"
```

## Configuration Pattern

The configuration follows a similar pattern to other AI SDKs:

```typescript
// Similar to Google Generative AI SDK pattern:
// baseURL: Use a different URL prefix for API calls (e.g., proxy servers)
// apiKey: API key sent using authorization header

// Claude Code equivalent:
// ANTHROPIC_BASE_URL="https://custom-endpoint.com/v1"
// ANTHROPIC_API_KEY="your-key"
```

## Using with Claude Code Router

For advanced routing capabilities (multiple providers, model switching), consider using [claude-code-router](https://github.com/musistudio/claude-code-router):

```bash
# Install
npm install -g @musistudio/claude-code-router

# Configure and start
ccr code
```

The router sets these environment variables automatically:
- `ANTHROPIC_BASE_URL`: Points to local router (default: `http://127.0.0.1:3456`)
- `ANTHROPIC_AUTH_TOKEN`: Your configured API key

## Provider-Specific Configuration

### AWS Bedrock

```bash
export AWS_REGION="us-east-1"
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
# Optional: Use bearer token
export AWS_BEARER_TOKEN_BEDROCK="your-token"
```

### Google Vertex AI

```bash
export CLOUD_ML_REGION="us-central1"
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/service-account.json"
```

### Microsoft Azure AI Foundry

See [Azure AI Foundry documentation](https://code.claude.com/docs/en/azure-ai-foundry)

## Advanced: API Key Helper

For dynamic API key generation (e.g., STS tokens):

```bash
# Set a script that outputs the API key
export CLAUDE_CODE_API_KEY_HELPER="/path/to/your/key-helper-script.sh"

# TTL for cached keys (in milliseconds)
export CLAUDE_CODE_API_KEY_HELPER_TTL_MS="300000"  # 5 minutes
```

## Troubleshooting

### DNS Resolution

If your proxy handles DNS resolution:

```bash
export CLAUDE_CODE_PROXY_RESOLVES_HOSTS="true"
```

### Disable Telemetry

When using custom endpoints:

```bash
export DISABLE_TELEMETRY="true"
export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC="true"
```

### Debug Mode

```bash
export ANTHROPIC_LOG="debug"
claude --debug
```

## Security Considerations

1. **Never commit API keys** - Use environment variables or secure vaults
2. **Use HTTPS** - Always use secure connections for production
3. **Validate proxy certificates** - Set `NODE_EXTRA_CA_CERTS` for custom CAs
4. **Restrict access** - When running local proxies, bind to `127.0.0.1`

## Related Documentation

- [Official Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code/overview)
- [Claude Code Router](https://github.com/musistudio/claude-code-router)
- [Environment Variables Reference](https://code.claude.com/docs/en/configuration)
