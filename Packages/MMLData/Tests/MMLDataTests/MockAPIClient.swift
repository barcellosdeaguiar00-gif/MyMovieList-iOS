import MMLCore
import MMLNetworking

final class MockAPIClient: APIClient, @unchecked Sendable {
    var result: Result<FetchPopularMoviesResponseDTO, AppError>
    private(set) var receivedPages: [Int] = []

    init(result: Result<FetchPopularMoviesResponseDTO, AppError>) {
        self.result = result
    }

    func fetchPopularMovies(page: Int) async throws -> FetchPopularMoviesResponseDTO {
        receivedPages.append(page)
        return try result.get()
    }
}
