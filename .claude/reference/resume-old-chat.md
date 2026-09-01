# Resuming a stale/old session

**When:** you're coming back to a session that's hours/days old, or was
left mid-task.

## What to do

1. Ask Claude for a one-line status first: "where did we leave off?" — if
   the summary matches your memory of the state and the task is still
   in-progress (e.g. mid-way through a feature scaffold, mid-review), just
   continue in the same session.
2. Before trusting anything the session claims about file state, have it
   check reality — `git status` / `git diff` / re-read the specific file —
   since the codebase may have changed since (especially if you edited
   files outside Claude Code, e.g. in Xcode, between sessions).
3. Re-state anything that changed since the session went stale: new
   requirements, a decision you made elsewhere, a file you touched by hand.
   Don't assume the old context is still accurate.

## When fresh `/clear` is better than resuming

- The old session was about a *different* feature/branch than what you
  need now — this project's sessions are meant to be single-topic (see
  CLAUDE.md's Context Management Rules), so don't drag Greeting-feature
  context into a Settings-feature task.
- You've made manual changes in Xcode (renamed files, changed
  `project.yml`, ran `xcodegen generate`) since the session paused — the
  session's mental model of file layout may be stale; a fresh session that
  re-reads the current tree is safer than patching an outdated one.
- The old session was already long/compacted and mid-task confusion had
  started (see signs in `.claude/reference/long-heavy-session.md`).

## Avoid

- Don't resume a session and immediately ask for something unrelated to
  what it was doing — `/clear` first.
- Don't assume a resumed session remembers a decision you made in a
  *different* chat window — decisions don't cross sessions unless written
  into CLAUDE.md, a memory, or restated here.

## Example (this project)

You paused mid-way through `feature-scaffolder` building a `Settings`
slice, came back the next day, and separately renamed a file in Xcode.
Say: "Continue the Settings scaffold — but first re-check the current
file list, I renamed something in Xcode since we last talked."
