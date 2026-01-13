# Save Session State

Save the current session state to `~/.claude/session-state.md` for persistence across sessions.

## Instructions

Write the current session state using the following template. Include all relevant context from this conversation:

```markdown
# Session State

**Last Updated:** [TODAY'S DATE]

---

## Active Project

[What project/directory you're working in]
[Brief description of the work focus]

---

## Decisions Made

[List key decisions from this session - numbered list]

---

## What We Tried

[Approaches attempted, especially failed ones worth remembering]
[Include why things didn't work if relevant]

---

## Current State

**Just Completed:**
[What was just finished]

**In Progress:**
[Any incomplete work]

**Status Summary:**
[Quick overview of system/project state]

---

## Next Steps

[Numbered list of what should happen next]
[Order by priority]

---

## Blockers/Questions

[Any unresolved issues or questions to address]

---

## Quick Reference

[Any commands, paths, or snippets that are frequently needed]
```

## After Writing

1. Confirm the state was saved
2. Show the path: `~/.claude/session-state.md`
3. Mention this can be loaded with `/load-state` or automatically on next session start
