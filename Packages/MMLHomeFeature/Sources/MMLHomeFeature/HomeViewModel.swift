import MMLDomain
import Observation

@Observable
@MainActor
public final class HomeViewModel {
    private let getPopularMoviesListUseCase: GetPopularMoviesListUseCase
    private let page = 1

    public private(set) var state: HomeViewState = .loading

    public init(getPopularMoviesListUseCase: GetPopularMoviesListUseCase) {
        self.getPopularMoviesListUseCase = getPopularMoviesListUseCase
    }

    // Fetch is not triggered here (unlike the Android ViewModel's init + viewModelScope);
    // SwiftUI's idiomatic equivalent is calling load() from a view's .task modifier.
    public func load() async {
        state = .loading
        do {
            let movies = try await getPopularMoviesListUseCase.execute(page: page)
            state = movies.isEmpty ? .retry : .content(movies)
        } catch {
            state = .retry
        }
    }

    public func retry() async {
        await load()
    }
}
