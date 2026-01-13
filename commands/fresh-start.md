# Fresh Start (Context Reset)

Reset conversation context while preserving session state. Use this when context is getting long but you want to continue the same work.

## Instructions

This is a 3-step process:

### Step 1: Save State
First, save the current session state by writing to `~/.claude/session-state.md` using the save-state template (see /save-state command for format).

### Step 2: Guide User
After saving, tell the user:

```
State saved. To complete the fresh start:

1. Run: /clear
2. Then run: /load-state

This will reset context and reload your saved state so we can continue.
```

### Step 3: Done
The /load-state command will pick up from the saved state and continue working.

## Note

The `/clear` command must be run manually by the user - it cannot be triggered programmatically. This ensures the user has control over when context is cleared.
