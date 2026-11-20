public struct GetPopularMoviesListUseCase: Sendable {
    private let movieRepository: MovieRepository

    public init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }

    public func execute(page: Int) async throws -> [Movie] {
        try await movieRepository.fetchPopularMovies(page: page)
    }
}
