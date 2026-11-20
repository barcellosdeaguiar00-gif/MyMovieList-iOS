public protocol MovieRepository: Sendable {
    func fetchPopularMovies(page: Int) async throws -> [Movie]
}
