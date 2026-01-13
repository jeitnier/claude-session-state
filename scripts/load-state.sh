#!/bin/bash
# load-state.sh - Load session state for Claude Code
# Called at session start to inject previous context
#
# Usage:
#   ./load-state.sh              # Output state for Claude to read
#   ./load-state.sh --check      # Check if state exists (exit 0 if yes)
#   ./load-state.sh --age        # Show age of state file
#
# Returns the contents of session-state.md if it exists.

STATE_DIR="${HOME}/.claude"
STATE_FILE="${STATE_DIR}/session-state.md"

case "${1:-}" in
    --check)
        # Check if state file exists and is non-empty
        if [[ -s "$STATE_FILE" ]]; then
            exit 0
        else
            exit 1
        fi
        ;;
    --age)
        # Show how old the state file is
        if [[ -f "$STATE_FILE" ]]; then
            if [[ "$OSTYPE" == "darwin"* ]]; then
                # macOS
                mod_time=$(stat -f %m "$STATE_FILE")
                now=$(date +%s)
            else
                # Linux
                mod_time=$(stat -c %Y "$STATE_FILE")
                now=$(date +%s)
            fi
            age_seconds=$((now - mod_time))
            age_minutes=$((age_seconds / 60))
            age_hours=$((age_minutes / 60))
            age_days=$((age_hours / 24))

            if [[ $age_days -gt 0 ]]; then
                echo "${age_days} days ago"
            elif [[ $age_hours -gt 0 ]]; then
                echo "${age_hours} hours ago"
            elif [[ $age_minutes -gt 0 ]]; then
                echo "${age_minutes} minutes ago"
            else
                echo "${age_seconds} seconds ago"
            fi
        else
            echo "No state file exists"
            exit 1
        fi
        ;;
    --help|-h)
        echo "Usage: load-state.sh [--check|--age|--help]"
        echo ""
        echo "Options:"
        echo "  (none)     Output current state file contents"
        echo "  --check    Exit 0 if state exists, 1 otherwise"
        echo "  --age      Show age of state file"
        echo "  --help     Show this help"
        ;;
    *)
        # Default: Output state file contents
        if [[ -s "$STATE_FILE" ]]; then
            # Calculate age for display
            AGE=$("$0" --age)

            # Extract key info for user display
            PROJECT=$(grep -A3 "## Active Project" "$STATE_FILE" | grep -v "^#" | grep -v "^$" | grep -v "^---" | head -1 | sed 's/^[[:space:]]*//')
            NEXT_STEP=$(grep -A3 "## Next Steps" "$STATE_FILE" | grep "^1\." | sed 's/^1\. \*\*//' | sed 's/\*\*.*//' | head -1)

            # Visual notification (macOS only - silently skip on Linux)
            if [[ "$OSTYPE" == "darwin"* ]]; then
                NOTIFY_MSG="Project: ${PROJECT:-Unknown}"
                if [[ -n "$NEXT_STEP" ]]; then
                    NOTIFY_MSG="${NOTIFY_MSG}\nNext: ${NEXT_STEP}"
                fi
                osascript -e "display notification \"${NOTIFY_MSG}\" with title \"Session State Loaded\" subtitle \"${AGE}\"" 2>/dev/null &
            fi

            # Full state for Claude context (stdout)
            echo "=== PREVIOUS SESSION STATE ==="
            echo "Last updated: ${AGE}"
            echo ""
            cat "$STATE_FILE"
            echo ""
            echo "=== END SESSION STATE ==="
        else
            echo "No previous session state found." >&2
            echo "No previous session state found."
        fi
        ;;
esac
