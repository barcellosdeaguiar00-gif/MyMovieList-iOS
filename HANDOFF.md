# Handoff notes

Written at the end of the initial build-out session (2026-11-20), for whoever
(human or AI) picks this up next. Read this before touching the code.

## Current state (verified working, not just "should work")

- All 6 local SPM packages build and test clean: `MMLCore`, `MMLDomain`,
  `MMLNetworking`, `MMLData`, `MMLTheme` (no tests), `MMLHomeFeature`.
- The `MyMovieList` app target builds via XcodeGen (`project.yml`), was
  installed and launched on an iOS 26.5 simulator, and **actually loads real
  TMDB data** — confirmed visually (screenshot) and via Maestro flow
  (`.maestro/home_loads_popular_movies.yaml`, `.maestro/tab_navigation.yaml`),
  both passing against a real simulator.
- SwiftLint/SwiftFormat/GitHub Actions CI are set up and passing locally
  (CI itself has not yet run on GitHub — no PR has been opened against it).
- Scope mirrors the Android app (`/Users/arthur/Documents/MyMovieList`)
  exactly: Home is fully functional, Search/Favorite are literal "under
  construction" placeholders, same as Android today.

## How to pick this up and verify it still works

```bash
cd /Users/arthur/Documents/MyMovieList-iOS
brew install xcodegen swiftlint swiftformat   # if not already installed
# Secrets.xcconfig should already exist locally (git-ignored) with a real
# TMDB key. If missing/empty, see "TMDB key" below.
xcodegen generate
xcodebuild build -scheme MyMovieList -destination 'generic/platform=iOS Simulator'
swiftlint lint
swiftformat --lint .

# Per-package tests (MMLTheme/MMLHomeFeature depend on UIKit-only APIs in
# MMLTheme, so plain `swift build`/`swift test` fails for them — use
# xcodebuild against the Simulator SDK for every package, not just these two):
for pkg in MMLCore MMLDomain MMLNetworking MMLData MMLHomeFeature; do
  (cd "Packages/$pkg" && xcodebuild test -scheme "$pkg" -destination 'platform=iOS Simulator,name=iPhone 17')
done

# End-to-end smoke test (Maestro CLI must be installed, see below):
xcrun simctl boot "iPhone 17" 2>/dev/null; xcrun simctl bootstatus "iPhone 17" -b
xcodebuild build -scheme MyMovieList -destination 'platform=iOS Simulator,name=iPhone 17' -derivedDataPath /tmp/mml-build
xcrun simctl install "iPhone 17" /tmp/mml-build/Build/Products/Debug-iphonesimulator/MyMovieList.app
UDID=$(xcrun simctl list devices | grep "iPhone 17 (" | grep -oE '[0-9A-F-]{36}')
maestro --udid "$UDID" test .maestro/home_loads_popular_movies.yaml
maestro --udid "$UDID" test .maestro/tab_navigation.yaml
```

## TMDB key

The real key lives only in two gitignored places, never in this repo's
history: `Secrets.xcconfig` here, and `local.properties` in the Android
project (`/Users/arthur/Documents/MyMovieList/local.properties`, key
`API_KEY`). If `Secrets.xcconfig` is missing or its `TMDB_API_KEY` is empty,
copy the value from that Android `local.properties` file (same TMDB account,
same key — don't generate a new one unless the user says the key was
rotated).

**Known footgun**: don't run `cp Secrets.xcconfig.sample Secrets.xcconfig`
locally once a real `Secrets.xcconfig` exists — it silently wipes the real
key with the empty template. This is literally the CI workflow's setup step;
it only runs destructively if you re-run it locally over an already-configured
file. This bit us once during the original build-out (caught by the final
simulator smoke test, not by any automated build/test — `xcodebuild build`
doesn't catch it because the empty-key check is a runtime `fatalError`, not a
compile error).

Also: `.xcconfig` files treat `//` anywhere on a line as a comment start, so
`TMDB_API_URL` is written as `https:/$()/api.themoviedb.org/3/movie/` (the
empty `$()` macro splits the slashes so they survive parsing, then
disappears during build-setting expansion). Don't "simplify" this back to a
plain `https://` — it will silently truncate the URL to `https:` again.

## Maestro

CLI is installed at `~/.maestro/bin/maestro` (your shell's PATH may not pick
it up without a new shell session). An MCP server is registered at **user
scope** (`claude mcp list` should show `maestro: ... - ✔ Connected`), so a
fresh Claude Code session should have Maestro tools available directly
without needing the CLI commands above.

Flows exist in both repos:
- `/Users/arthur/Documents/MyMovieList-iOS/.maestro/` — pushed, verified passing.
- `/Users/arthur/Documents/MyMovieList/.maestro/` — committed locally on
  branch `app/kmp-migration`, **not pushed** (pending user decision — ask
  before pushing, that repo had other uncommitted work in progress,
  `Interview.kt`, that is not related to this project and must not be
  touched/committed). Also not yet run against a real Android emulator (none
  was available in the session that wrote them) — only the iOS side has been
  actually executed.

## What's NOT done yet (real gaps, not just "nice to have")

- **Search**: still the "under construction" placeholder, same as Android.
  Real search would need a new TMDB endpoint call, not present in any layer
  yet (would touch `MMLNetworking`, a new use case in `MMLDomain`, and a new
  feature package).
- **Favorite**: same — placeholder only, no persistence layer exists at all
  (no SwiftData/local storage anywhere in this codebase).
- **Pagination**: `HomeViewModel` always fetches page 1, matching the
  Android app today — no infinite scroll / load-more.
- **The three Home sections (Popular/Action/Animation) are fake**: they're
  all built from the *same* popular-movies API response (reversed / sorted
  differently), carried over verbatim from the Android app's own
  `// TODO map other api endpoints` comment (preserved in
  `HomeView.swift`). Wiring real distinct endpoints is Android-and-iOS work,
  not an iOS-only gap.
- **No app icon**, default Xcode launch screen only.
- **No `Localizable.xcstrings`**: all UI strings ("Retry", "Ops... Something
  Went Wrong", "Under construction", tab titles) are hardcoded string
  literals in the SwiftUI views, not extracted for localization.
- **CI has never actually run on GitHub** — the workflow file was validated
  by running each of its steps locally, but no PR has been opened to confirm
  it passes in GitHub's macOS runners (runner image/Xcode version drift is
  possible).
- **TMDB key rotation**: during final verification, the real key was briefly
  printed to a background subagent's own tool output (never committed, never
  shown to the user in chat) while debugging the Info.plist wiring. Low risk,
  but the user was told and has not yet decided whether to rotate it.

## Architecture quick-reference

Six local SPM packages under `Packages/`, one app target under `App/`,
`project.yml` (XcodeGen) ties them together. Each package was built and
verified independently before being wired into the next — see commit history
for the exact order (`Core/Domain` → `Networking/Data` → `Theme` → `HomeFeature`
→ App shell → tooling/CI). MVVM + Clean Architecture, mirroring the layering
of the Android `core:*` Gradle modules. No DI framework — `App/AppDependencies.swift`
wires everything by hand. No third-party dependencies anywhere.
