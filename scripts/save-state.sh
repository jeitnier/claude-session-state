#!/bin/bash
# save-state.sh - Save session state for Claude Code
# Called by hooks or manually via /save-state
#
# Usage:
#   ./save-state.sh                    # Interactive - prompts Claude to save state
#   ./save-state.sh --from-stdin       # Read state from stdin (for programmatic use)
#   ./save-state.sh --show             # Show current state file
#
# This script manages the session-state.md file that persists context across sessions.

STATE_DIR="${HOME}/.claude"
STATE_FILE="${STATE_DIR}/session-state.md"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

mkdir -p "$STATE_DIR"

case "${1:-}" in
    --from-stdin)
        # Read state content from stdin and save
        cat > "$STATE_FILE"
        echo "State saved to $STATE_FILE at $TIMESTAMP"
        ;;
    --show)
        # Display current state
        if [[ -f "$STATE_FILE" ]]; then
            cat "$STATE_FILE"
        else
            echo "No session state file found at $STATE_FILE"
        fi
        ;;
    --help|-h)
        echo "Usage: save-state.sh [--from-stdin|--show|--help]"
        echo ""
        echo "Options:"
        echo "  --from-stdin  Read state from stdin"
        echo "  --show        Display current state file"
        echo "  --help        Show this help"
        echo ""
        echo "Called without arguments, outputs a reminder for Claude to save state."
        ;;
    *)
        # Default: Output reminder message for Claude
        echo ""
        echo "=== SESSION STATE SAVE REMINDER ==="
        echo ""
        echo "Please save the current session state to: $STATE_FILE"
        echo ""
        echo "Include these sections:"
        echo "1. **Active Project** - What project/area we're working on"
        echo "2. **Decisions Made** - Key decisions from this session"
        echo "3. **What We Tried** - Approaches attempted (especially failed ones)"
        echo "4. **Current State** - Where things stand right now"
        echo "5. **Next Steps** - What should happen next session"
        echo "6. **Blockers/Questions** - Any unresolved issues"
        echo ""
        echo "Use the Write tool to save directly to: $STATE_FILE"
        echo "=================================="
        ;;
esac
