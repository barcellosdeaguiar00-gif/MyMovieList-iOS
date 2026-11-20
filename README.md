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
- SwiftLint + SwiftFormat

## Setup

1. Install the toolchain: `brew install xcodegen swiftlint swiftformat`
2. Copy `Secrets.xcconfig.sample` to `Secrets.xcconfig` and fill in your TMDB API key
3. `xcodegen generate`
4. Open the generated `.xcodeproj` in Xcode and run the `MyMovieList` scheme

## Scope

Mirrors the current Android app exactly: a fully working Home screen (popular
movies from TMDB), and placeholder "under construction" Search and Favorite
screens — matching the Android app's current feature set.

The bottom tab bar uses icons + text labels (unlike the icon-only Material
bottom nav on Android) to follow iOS Human Interface Guidelines.
