# Quick fixes / small questions

**When:** a single-file edit, a typo, a one-line question about existing
code, a small tweak to an existing feature.

## What to do

1. Just ask in the main session — no subagent, no `/clear` needed first
   unless the previous topic was unrelated.
2. Name the file/line if you already know it (`GreetingViewModel.swift`
   refresh() should also clear an error state) — this skips a search step
   entirely.

## Why no subagent here

Spinning up `Explore` or `code-reviewer` for a one-file, one-change task
costs a round-trip and tokens for no benefit — the main session model can
read the one file and make the edit directly. Subagents pay off when the
work spans multiple files/layers (scaffolding) or needs a distinct
read-only pass (review, search across the whole tree).

## Avoid

- Don't invoke `feature-scaffolder` for a change confined to one existing
  file — that's what it explicitly says not to do in its own description.
- Don't ask "should I use an agent for this?" for something this small —
  just ask directly.

## Example (this project)

> "In `ContentView.swift`, change the button label from 'Refresh' to
> 'Reload'."

No agent, no search — just the edit, directly in the main session.
