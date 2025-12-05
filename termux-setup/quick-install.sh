#!/data/data/com.termux/files/usr/bin/bash
# Quick install: curl -fsSL URL | bash -s -- YOUR_API_KEY

GEMINI_KEY="${1:-YOUR_GOOGLE_API_KEY}"

pkg update -y && pkg install -y nodejs-lts git curl
npm install -g @anthropic-ai/claude-code @musistudio/claude-code-router

mkdir -p ~/.claude-code-router
cat > ~/.claude-code-router/config.json << EOF
{"LOG":true,"API_TIMEOUT_MS":600000,"Providers":[{"name":"gemini","api_base_url":"https://generativelanguage.googleapis.com/v1beta/models/","api_key":"$GEMINI_KEY","models":["gemini-2.5-flash","gemini-2.5-pro","gemini-2.0-flash"],"transformer":{"use":["gemini"]}}],"Router":{"default":"gemini,gemini-2.0-flash","think":"gemini,gemini-2.5-pro"}}
EOF

echo 'alias ccg="ccr code"' >> ~/.bashrc
echo "✅ Done! Run: ccr code"
