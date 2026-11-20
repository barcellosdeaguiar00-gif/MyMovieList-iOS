import MMLDomain
import MMLNetworking

public struct MovieRepositoryImpl: MovieRepository {
    private let apiClient: APIClient
    private let mapper: MovieMapper

    public init(apiClient: APIClient, mapper: MovieMapper = MovieMapper()) {
        self.apiClient = apiClient
        self.mapper = mapper
    }

    public func fetchPopularMovies(page: Int) async throws -> [Movie] {
        let response = try await apiClient.fetchPopularMovies(page: page)
        return mapper.toMovieList(response)
    }
}
