# MyMovieList-iOS

Native SwiftUI mirror of [MyMovieList](https://github.com/arthuraguiar/MyMovieList),
a Kotlin Multiplatform app that lists TMDB's popular movies. This project
re-implements the same features using idiomatic, current iOS development
practices instead of sharing code with the Android app.

> Status: under construction — see the project board / commit history for progress.

## Stack

- Swift 6, SwiftUI, iOS 17+
- MVVM + Clean Architecture, split into local Swift Package Manager modules
- `async`/`await` networking against the TMDB API
- Swift Testing for unit tests
- [XcodeGen](https://github.com/yonaskolb/XcodeGen) generates the `.xcodeproj` from `project.yml`
- SwiftLint + SwiftFormat for code quality
- GitHub Actions CI for automated lint, format, test, and build checks

## Architecture

The app is organized into six local Swift Package Manager modules, each with clear separation of concerns:

- **MMLCore** — Shared utilities, extensions, and foundation types
- **MMLDomain** — Domain models and use cases (business logic)
- **MMLNetworking** — HTTP client and API request/response handling
- **MMLData** — Repository implementations and data sources
- **MMLTheme** — Design tokens, colors, typography, and shared UI components
- **MMLHomeFeature** — Feature module for the Home screen with MVVM structure

Each package (except MMLTheme) includes comprehensive unit tests via Swift Testing.

## Setup

1. Install the toolchain: `brew install xcodegen swiftlint swiftformat`
2. Copy `Secrets.xcconfig.sample` to `Secrets.xcconfig` and fill in your TMDB API key
3. `xcodegen generate`
4. Open the generated `.xcodeproj` in Xcode and run the `MyMovieList` scheme

## Development

Before submitting a pull request, ensure:
- `swiftlint lint` passes with 0 violations
- `swiftformat --lint .` shows no formatting issues
- All tests pass: `xcodebuild test -scheme <PackageName>`
- The app builds: `xcodebuild build -scheme MyMovieList`

The GitHub Actions workflow in `.github/workflows/build_test.yml` automatically checks these on every pull request to `master`.

## Scope

Mirrors the current Android app exactly: a fully working Home screen (popular
movies from TMDB), and placeholder "under construction" Search and Favorite
screens — matching the Android app's current feature set.

The bottom tab bar uses icons + text labels (unlike the icon-only Material
bottom nav on Android) to follow iOS Human Interface Guidelines.
