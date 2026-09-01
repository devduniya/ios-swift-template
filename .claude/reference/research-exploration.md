# Research / exploration in the codebase

**When:** you need to find or understand something — "where does X
happen", "what calls Y", "list everything in the Greeting slice" — before
deciding what to change.

## What to do

1. Call the `Explore` agent (or let Claude route to it automatically per
   CLAUDE.md). It's read-only and cheap (haiku) — safe to call liberally.
2. State the search breadth so it doesn't over- or under-search:
   - **"quick"** — a single targeted lookup ("where is `GreetingRepository`
     defined?").
   - **"medium"** — moderate exploration ("show me everything involved in
     the Greeting feature").
   - **"very thorough"** — only if the codebase has grown past the
     current ~8-file template and naming may be inconsistent across
     features.
3. Given this project's current size, "quick" or "medium" covers almost
   everything — reserve "very thorough" for once real features have
   accumulated.

## Avoid

- Don't use `general-purpose` for a search task — it's slower and more
  expensive than `Explore` for no added benefit here.
- Don't ask `Explore` to judge code quality or suggest fixes — it only
  locates and reports (see its own description). Follow up with
  `code-reviewer` if you need judgment.

## Example (this project)

> "Explore (quick): where is the greeting message string actually set?"

Expected answer: `Sources/Data/Repositories/GreetingRepositoryImpl.swift`,
the `getGreeting()` method's return value.
