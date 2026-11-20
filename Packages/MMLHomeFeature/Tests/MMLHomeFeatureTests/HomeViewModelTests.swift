import MMLDomain
import Testing

@testable import MMLHomeFeature

private final class MockMovieRepository: MovieRepository, @unchecked Sendable {
    enum Behavior {
        case success([Movie])
        case failure(Error)
    }

    var behavior: Behavior
    private(set) var callCount = 0

    init(behavior: Behavior) {
        self.behavior = behavior
    }

    func fetchPopularMovies(page: Int) async throws -> [Movie] {
        callCount += 1
        switch behavior {
        case .success(let movies):
            return movies
        case .failure(let error):
            throw error
        }
    }
}

private enum TestError: Error, Equatable {
    case boom
}

private func makeMovies() -> [Movie] {
    [
        Movie(title: "Movie A", originalLanguage: "en", releaseDate: "2024-01-01", posterUrl: "https://example.com/a.jpg"),
        Movie(title: "Movie B", originalLanguage: "pt", releaseDate: "2024-02-02", posterUrl: "https://example.com/b.jpg")
    ]
}

@MainActor
@Test
func loadWithNonEmptySuccessProducesContentState() async {
    let movies = makeMovies()
    let repository = MockMovieRepository(behavior: .success(movies))
    let viewModel = HomeViewModel(getPopularMoviesListUseCase: GetPopularMoviesListUseCase(movieRepository: repository))

    await viewModel.load()

    #expect(viewModel.state == .content(movies))
}

@MainActor
@Test
func loadWithEmptySuccessProducesRetryState() async {
    let repository = MockMovieRepository(behavior: .success([]))
    let viewModel = HomeViewModel(getPopularMoviesListUseCase: GetPopularMoviesListUseCase(movieRepository: repository))

    await viewModel.load()

    #expect(viewModel.state == .retry)
}

@MainActor
@Test
func loadWithRepositoryErrorProducesRetryState() async {
    let repository = MockMovieRepository(behavior: .failure(TestError.boom))
    let viewModel = HomeViewModel(getPopularMoviesListUseCase: GetPopularMoviesListUseCase(movieRepository: repository))

    await viewModel.load()

    #expect(viewModel.state == .retry)
}

@MainActor
@Test
func retryInvokesUseCaseAgain() async {
    let repository = MockMovieRepository(behavior: .success(makeMovies()))
    let viewModel = HomeViewModel(getPopularMoviesListUseCase: GetPopularMoviesListUseCase(movieRepository: repository))

    await viewModel.load()
    await viewModel.retry()

    #expect(repository.callCount == 2)
}
