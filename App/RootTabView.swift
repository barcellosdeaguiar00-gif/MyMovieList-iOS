import MMLHomeFeature
import SwiftUI

struct RootTabView: View {
    let dependencies: AppDependencies

    var body: some View {
        TabView {
            NavigationStack {
                HomeView(viewModel: dependencies.makeHomeViewModel())
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            FavoriteView()
                .tabItem {
                    Label("Favorite", systemImage: "heart")
                }
        }
        .preferredColorScheme(.dark)
    }
}
