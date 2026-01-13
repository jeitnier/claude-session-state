# Claude Session State Plugin

Auto-persist session context across Claude Code sessions. Never lose your work context again.

## Features

- **Auto-load on start**: Previous session context loads automatically when you start Claude Code
- **Auto-save reminders**: Get prompted to save state before compaction or session end
- **Manual commands**: `/save-state`, `/load-state`, `/fresh-start` for full control
- **Cross-platform**: Works on macOS and Linux
- **Desktop notifications**: macOS users get a notification when state loads

## Installation

### From GitHub

```bash
# Add the marketplace
/plugin marketplace add jeitnier/claude-session-state

# Install
/plugin install session-state
```

### Local Development

```bash
# Clone and test locally
git clone https://github.com/jeitnier/claude-session-state.git
cd claude-session-state
claude --plugin-dir .
```

## Usage

### Automatic (via Hooks)

The plugin automatically:
- **SessionStart**: Loads your saved state and displays it in context
- **PreCompact**: Reminds you to save state before context compaction
- **Stop**: Reminds you to save state before ending the session

### Manual Commands

| Command | Description |
|---------|-------------|
| `/save-state` | Save current session state to `~/.claude/session-state.md` |
| `/load-state` | Load and display saved state, offer to continue |
| `/fresh-start` | Save state → guide through `/clear` → reload state |

## State File Format

State is saved to `~/.claude/session-state.md`:

```markdown
# Session State

**Last Updated:** 2025-01-13

---

## Active Project
Working in `/path/to/project` - brief description

---

## Decisions Made
1. Decision one with context
2. Decision two with context

---

## What We Tried
- Approach A: Didn't work because X
- Approach B: Worked, implemented

---

## Current State
**Just Completed:** Feature X
**In Progress:** Feature Y

---

## Next Steps
1. First priority task
2. Second priority task

---

## Blockers/Questions
- Any unresolved issues

---

## Quick Reference
```bash
# Useful commands for this project
```
```

## How It Works

1. **SessionStart hook** runs `load-state.sh` which outputs your saved state
2. Claude sees this state in context and knows where you left off
3. **PreCompact/Stop hooks** run `save-state.sh` which prompts Claude to save
4. Claude writes the current state using the Write tool
5. Next session, step 1 repeats

## File Locations

| File | Purpose |
|------|---------|
| `~/.claude/session-state.md` | Your persisted state (the actual data) |
| Plugin scripts | Installed to Claude's plugin cache |

## Tips

- **Save often**: Use `/save-state` after completing major tasks
- **Be specific**: Include file paths, command examples, and specific decisions
- **Update Next Steps**: Keep the priority list current for seamless handoffs
- **Use Quick Reference**: Store frequently-used commands and paths

## Troubleshooting

### State not loading on start?
- Check `~/.claude/session-state.md` exists and has content
- Run `~/.claude/scripts/load-state.sh --check` to verify

### Notifications not showing? (macOS)
- Ensure "Claude Code" has notification permissions in System Settings

### Commands not found?
- Verify plugin is installed: `/plugin list`
- Reinstall if needed: `/plugin install session-state`

## License

MIT
