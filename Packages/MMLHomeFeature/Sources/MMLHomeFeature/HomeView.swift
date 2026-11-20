import MMLDomain
import MMLTheme
import SwiftUI

public struct HomeView: View {
    private let viewModel: HomeViewModel

    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        content
            .task { await viewModel.load() }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .retry:
            RetryView(action: { Task { await viewModel.retry() } })
        case let .content(movies):
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(makeMovieSections(movies)) { section in
                        HomeSection(title: section.title) {
                            MovieSectionRow(movies: section.movies)
                        }
                    }
                }
            }
        }
    }

    // TODO: map other api endpoints
    private func makeMovieSections(_ movies: [Movie]) -> [MovieSection] {
        [
            MovieSection(title: "Popular", movies: movies),
            MovieSection(title: "Action", movies: movies.reversed()),
            MovieSection(title: "Animation", movies: movies.sorted { $0.title < $1.title })
        ]
    }
}

private struct HomeSection<Content: View>: View {
    let title: String
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .mmlBodyLarge()
                .foregroundStyle(Color.mmlOnSurface)
                .padding(.top, 40)
                .padding(.bottom, 16)
                .padding(.horizontal, 16)

            content()
        }
    }
}
