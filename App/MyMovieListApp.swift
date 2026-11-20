import MMLTheme
import SwiftUI

@main
struct MyMovieListApp: App {
    init() {
        MMLTheme.initialize()
    }

    var body: some Scene {
        WindowGroup {
            RootTabView(dependencies: AppDependencies())
        }
    }
}
