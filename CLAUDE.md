# MyApp — Claude Code project guide

Native iOS app (SwiftUI), organized as MVVM + Clean Architecture, built via
XcodeGen instead of a hand-maintained `.xcodeproj`. Currently a template/
skeleton: one worked example feature (`Greeting`, threaded from
`Domain/Entities` through `Presentation/Views/ContentView.swift`) that
demonstrates the pattern to copy for real features. No test target exists
yet. CI (`.github/workflows/`) lives only on the `deployment` branch, never
on `main` — see `docs/BRANCH-PROTECTION.md`.

## Coding conventions (detected from the codebase)

- Strict layering, one direction only: `Presentation → Domain ← Data`.
  - `Domain/` (Entities, Repositories protocols, UseCases): plain Swift only.
    No `import SwiftUI`, no `import Foundation` networking. Domain never
    imports Data or Presentation.
  - `Data/`: repository *implementations* of Domain protocols. Networking/
    persistence code is confined here.
  - `Presentation/ViewModels/`: `@MainActor final class ... : ObservableObject`,
    state exposed via `@Published`, owns a UseCase (constructor-injected
    with a default concrete value), never touches a repository directly.
  - `Presentation/Views/`: SwiftUI `View` structs. Read `@Published` state
    and call ViewModel methods only — never call a UseCase or Repository
    directly.
- One triple-doc-comment (`///`) block per type explaining its role/layer
  boundary — mirror this style for new types, don't over-comment beyond it.
- Naming: `<Feature>`, `<Feature>Repository` (protocol), `<Feature>RepositoryImpl`
  (Data), `Get<Feature>UseCase`, `<Feature>ViewModel`.
- Re-run `xcodegen generate` after adding/removing/renaming source files or
  editing `project.yml` — the `.xcodeproj` is gitignored, not committed.

## Model & Agent Usage Rules

Decide the model/agent by task shape — don't ask the user each time, and
don't default to a bigger model "to be safe."

| Task | Use | Why |
|---|---|---|
| Locate a file/symbol, "where is X", "which view uses Y" | `Explore` agent (haiku) | Mechanical search, no reasoning needed |
| New feature scaffold (Domain→Data→Presentation slice) | `feature-scaffolder` agent (sonnet) | Repeat, pattern-following, needs write access |
| Review a diff / new feature for layering violations, force-unwraps, naming | `code-reviewer` agent (sonnet, read-only) | Normal-depth review, no architecture redesign |
| Prep/merge/push to the `deployment` branch | `release-guardian` agent (sonnet, git-only tools) | Hard-to-reverse (spends signing secrets), narrow git-safety checklist |
| Quick one-line fix, typo, single-file question | Main session directly, no subagent | Subagent overhead not worth it — see `.claude/reference/quick-task.md` |
| Rethinking the Clean Architecture layering itself, adding a major new architectural concern (e.g. persistence layer, DI container, multi-module split) | You (main session), reasoning carefully; escalate model only if truly stuck | Rare, deep-reasoning work — this project is small enough that Sonnet in the main session is normally sufficient; don't reach for Opus by default |

Rules:
- Never default to the `general-purpose` agent for simple search/lookup —
  use `Explore` or a scoped agent above.
- Before creating any new subagent, confirm the task genuinely repeats in
  this project. If it doesn't, don't create one.
- Match model to task complexity. Haiku for mechanical/search, Sonnet for
  normal coding/review/scaffolding. This project's small size means Opus is
  rarely warranted — reserve it for genuine architecture-level reasoning.
- If unsure which agent fits, ask the user in one line rather than guessing.

## Context Management Rules

This is a small codebase (~8 Swift files today), so sessions are usually
short and single-feature.

- **`/clear`** between unrelated tasks (a new feature vs. yesterday's bug
  fix vs. a deployment-branch merge). There's rarely a reason to carry
  context across unrelated work here.
- **`/compact`** only when you're deep into *one* feature slice — you've
  read/edited several files across Domain/Data/Presentation for the same
  feature and the conversation is long, but you're not done yet.
- Signs quality is slipping: Claude re-reads a file it already read this
  session, forgets which layer a type belongs to (e.g. proposes a View
  calling a Repository directly), or starts suggesting patterns that
  contradict the `Greeting` example without a stated reason. Treat any of
  these as a cue to `/compact` or `/clear` and restate the goal.
- See `.claude/reference/` for situation-specific playbooks — check
  `.claude/reference/README.md` first.
