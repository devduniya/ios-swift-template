# Long / heavy sessions

**When:** the conversation has been going a while — many files read/edited
across Domain/Data/Presentation for one feature, several rounds of review
and fixes, or a release-branch back-and-forth.

## What to do

1. Prefer `/compact` over `/clear` while you're still *inside* one feature
   slice or one task — compacting keeps the goal and decisions made so
   far, just trims the raw file contents/tool output.
2. Before compacting, make sure any decision that isn't obvious from the
   code is either already said out loud in the chat (compact keeps
   decisions, drops noise) or worth stating once more explicitly right
   before compacting.
3. After compacting, do a quick sanity check: ask Claude to state which
   layer (Domain/Data/Presentation) it believes it's currently working in,
   and confirm it matches reality.

## Signs quality is slipping (compact or `/clear` now)

- Claude re-reads a file it already read earlier this session.
- It proposes something that breaks the layering rule (a View calling a
  Repository/UseCase directly, Domain importing SwiftUI) without flagging
  it as an intentional deviation.
- It suggests a naming pattern that doesn't match `<Feature>` /
  `<Feature>Repository` / `Get<Feature>UseCase` / `<Feature>ViewModel`
  without explaining why this case is different.
- It forgets `xcodegen generate` is needed after file additions/renames,
  something it correctly mentioned earlier in the same session.

## Avoid

- Don't let a single session sprawl across multiple unrelated features —
  given this project's small size (~8 files today), that's a sign you
  should have `/clear`'d and started a fresh session per CLAUDE.md's
  Context Management Rules, not compacted through it.
- Don't keep compacting indefinitely on the same session across days —
  if it's stale, see `.claude/reference/resume-old-chat.md` instead.

## Example (this project)

Mid-way through scaffolding + reviewing + fixing a `Settings` feature, the
conversation has 40+ tool calls. Run `/compact`, then confirm: "we're
still on the Settings slice, ViewModel is @MainActor, right?" before
continuing.
