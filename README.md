# MyApp

A native iOS app (SwiftUI), organized as MVVM + Clean Architecture, using
[XcodeGen](https://github.com/yonaskolb/XcodeGen) instead of a
hand-maintained `.xcodeproj`.

## Architecture

```
Sources/
  Domain/          entities, repository protocols, use cases — no
                    dependency on SwiftUI or Foundation networking
  Data/             repository implementations
  Presentation/
    ViewModels/      ObservableObject classes — the "VM" in MVVM; call
                      use cases and publish state via @Published
    Views/            SwiftUI views — the "V"; read @Published state and
                       call ViewModel methods, never call use cases or
                       repositories directly
```

The `greeting` feature (Domain/.../Greeting.swift through
Presentation/ViewModels/GreetingViewModel.swift, wired into
ContentView.swift) is a worked example showing the full path: view →
viewmodel → use case → repository. Copy that pattern for new features;
delete it once you've got real features in place.

## First-time setup (macOS + Xcode required)

```
brew install xcodegen
xcodegen generate
open MyApp.xcodeproj
```

Re-run `xcodegen generate` any time you add/remove/rename source files or
change `project.yml` — the generated `.xcodeproj` is not committed to git
(see `.gitignore`), so this step is required after every fresh clone.

## Rename before you start developing

- `project.yml` — `name` and `options.bundleIdPrefix` (and the
  `PRODUCT_BUNDLE_IDENTIFIER` under `settings.base`)
- Re-run `xcodegen generate` after renaming

## Branches

- `main` — the app.
- `deployment` — the only branch with `.github/workflows/`. Pushing here
  builds (Simulator build if no signing secrets are set, or a signed IPA
  if they are), publishes a GitHub Release, and emails the download
  link.

To trigger a build:

```
git checkout deployment
git merge main
git push
```

Never merge `deployment` back into `main` — that would carry the
workflow file with it.

## Required secrets (repo Settings → Secrets and variables → Actions)

Only read on the `deployment` branch. Without these, CI still succeeds —
it just builds for the Simulator instead of a signed device build.

| Secret | Needed for |
|---|---|
| `APPLE_P12_BASE64`, `APPLE_P12_PASSWORD`, `APPLE_PROVISION_BASE64`, `APPLE_TEAM_ID` | Signed device build (archive + export a real IPA). |
| `RESEND_API_KEY` (secret) | Emailing the build link. |
| `MAIL_TO` (secret or variable) | Who receives the build email. |

See [`docs/BRANCH-PROTECTION.md`](docs/BRANCH-PROTECTION.md) for how to
lock `.github/workflows/` to the `deployment` branch only.
