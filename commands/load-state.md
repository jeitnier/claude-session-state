# Load Session State

Load the previous session state and continue working on pending tasks.

## Instructions

1. Read the session state file at `~/.claude/session-state.md`
2. Display a brief summary of:
   - Active project
   - Current state
   - Next steps
3. Ask: "Ready to continue from where we left off?"

## After Loading

If the user confirms, begin working on the first item in "Next Steps" unless they specify otherwise.

If the state file doesn't exist or is empty, inform the user and ask what they'd like to work on.
