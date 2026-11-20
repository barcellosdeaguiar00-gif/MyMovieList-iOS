import Testing
import MMLCore
import MMLNetworking
@testable import MMLData

@Suite("MovieRepositoryImpl")
struct MovieRepositoryImplTests {
    @Test("fetches movies and maps the DTO response into domain Movies")
    func fetchesAndMapsMovies() async throws {
        let dto = MovieResponseDTO(
            title: "Dune",
            releaseDate: "2021-10-22",
            originalLanguage: "en",
            posterPath: "/dune.jpg"
        )
        let client = MockAPIClient(result: .success(FetchPopularMoviesResponseDTO(results: [dto])))
        let repository = MovieRepositoryImpl(apiClient: client)

        let movies = try await repository.fetchPopularMovies(page: 1)

        #expect(movies.count == 1)
        #expect(movies[0].title == "Dune")
        #expect(movies[0].posterUrl == "https://image.tmdb.org/t/p/original/dune.jpg")
        #expect(client.receivedPages == [1])
    }

    @Test("propagates AppError thrown by the API client")
    func propagatesAppError() async {
        let client = MockAPIClient(result: .failure(.noConnection))
        let repository = MovieRepositoryImpl(apiClient: client)

        await #expect(throws: AppError.noConnection) {
            try await repository.fetchPopularMovies(page: 1)
        }
    }

    @Test("propagates AppError.http with its message and code")
    func propagatesHTTPError() async {
        let client = MockAPIClient(result: .failure(.http(message: "Not Found", code: 404)))
        let repository = MovieRepositoryImpl(apiClient: client)

        await #expect(throws: AppError.http(message: "Not Found", code: 404)) {
            try await repository.fetchPopularMovies(page: 1)
        }
    }
}
