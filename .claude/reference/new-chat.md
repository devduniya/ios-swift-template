# Starting a new chat

**When:** you're beginning a new piece of work — a new feature, a bug, a
review, a release push — and the previous session (if any) isn't relevant.

## What to do

1. Run `/clear` if a previous unrelated session is still open.
2. State the goal in one concrete sentence, naming the feature/file if
   known. Don't make Claude re-derive what "the project" is — CLAUDE.md
   already covers architecture/conventions, so you don't need to restate
   those.
3. Let Claude pick the agent/model per `CLAUDE.md`'s "Model & Agent Usage
   Rules" table — you don't need to name one. If you already know which
   fits, naming it is fine too (see the table for the four agents:
   `Explore`, `feature-scaffolder`, `code-reviewer`, `release-guardian`).

### Good first-message shapes

- "Add a `Profile` feature slice — entity has `name` and `avatarURL`,
  ViewModel loads it on appear." → triggers `feature-scaffolder`.
- "Where is the greeting message actually generated?" → triggers `Explore`.
- "Review the Profile slice I just added for layering issues." →
  triggers `code-reviewer`.
- "Merge main into deployment and push." → triggers `release-guardian`.

## Avoid

- Don't open with "which agent should I use?" — that's Claude's job per
  CLAUDE.md's usage rules. Only ask back if genuinely ambiguous.
- Don't paste large chunks of file content Claude can just read itself —
  name the file/path instead.

## Example (this project)

> "Add a `Settings` feature: a single toggle for dark-mode preference,
> persisted nowhere yet (just in-memory), following the Greeting pattern."

Claude should route this to `feature-scaffolder` without being told to.
