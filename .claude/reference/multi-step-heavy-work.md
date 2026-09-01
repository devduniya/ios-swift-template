# Multi-step / heavy work (new feature, refactor)

**When:** adding a real feature (not the Greeting placeholder), or a
refactor that touches multiple layers/files.

## What to do, in order

1. **Explore** (if you're not 100% sure of current state) — confirm
   nothing already exists under the feature's name, and check whether any
   existing pattern needs to be followed beyond the Greeting example.
   Skip this step if you already know the codebase is clean for this name.
2. **feature-scaffolder** — describe the feature in one paragraph: what
   the entity holds, what the repository needs to fetch/do, roughly what
   the View shows. Let it generate the full Domain→Data→Presentation
   slice in the established pattern. This step is sequential, not
   parallel — it needs a clear target before writing files.
3. **code-reviewer** — once scaffolded (or once you've hand-edited the
   generated stub, e.g. wired in a real network call in the
   `RepositoryImpl`), run a review pass for layering violations,
   force-unwraps, naming drift.
4. Apply any fixes the review surfaces (directly in the main session for
   small ones; re-invoke `feature-scaffolder` only if structural pieces
   are missing).
5. If this feature needs to ship, hand off to **release-guardian** when
   you're ready to merge `main → deployment` — that's a separate,
   deliberate step, not something to chain automatically after a review.

## When to parallelize

Real parallelism is rare in this project given its size — most feature
work is inherently sequential (scaffold → review → fix). The one case
worth parallelizing: reviewing two *independent*, already-finished feature
slices at once (two separate `code-reviewer` calls). Don't parallelize
exploration and scaffolding for the *same* feature — scaffolding needs the
exploration result first.

## Avoid

- Don't skip the review step for anything beyond a trivial slice — layering
  violations are easy to introduce silently (e.g. a View importing a
  Repository type by accident) and cheap to catch with `code-reviewer`.
- Don't let `feature-scaffolder` also decide navigation/wiring into
  `App.swift`/`ContentView.swift` — it deliberately leaves that to you (see
  its description) since it's an app-level decision, not a per-feature one.

## Example (this project)

Adding a real `Weather` feature backed by a network call:
1. `Explore` (quick) — confirm no `Weather*` files exist yet.
2. `feature-scaffolder` — "Weather entity: temperature (Double), condition
   (String). Repository fetches from a REST endpoint (stub the call for
   now). ViewModel loads on `.onAppear` like Greeting does."
3. `code-reviewer` — check the generated + hand-edited networking code.
4. Fix anything flagged.
5. When ready to ship: `release-guardian` to merge `main` → `deployment`.
