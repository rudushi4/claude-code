# Claude Code + Gemini for Termux

Run Claude Code on Android using Google Gemini API.

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/rudushi4/claude-code/main/termux-setup/install.sh | bash
```

## With API Key

```bash
curl -fsSL https://raw.githubusercontent.com/rudushi4/claude-code/main/termux-setup/quick-install.sh | bash -s -- YOUR_API_KEY
```

## Usage

```bash
ccr code      # Start Claude Code
ccg           # Shortcut
```

## Switch Models

```
/model gemini,gemini-2.5-pro    # Pro (smarter)
/model gemini,gemini-2.0-flash  # Flash (faster)
```

## Get API Key

https://aistudio.google.com/app/apikey

## Edit Config

```bash
nano ~/.claude-code-router/config.json
```

## Troubleshooting

```bash
ccr restart   # Restart router
pkg upgrade   # Update packages
```
