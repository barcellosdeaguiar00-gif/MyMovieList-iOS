@testable import MMLDomain
import Testing

private struct MockMovieRepository: MovieRepository {
    enum Behavior {
        case success([Movie])
        case failure(Error)
    }

    let behavior: Behavior

    func fetchPopularMovies(page _: Int) async throws -> [Movie] {
        switch behavior {
        case let .success(movies):
            movies
        case let .failure(error):
            throw error
        }
    }
}

private enum TestError: Error, Equatable {
    case boom
}

@Test
func executeReturnsMoviesFromRepositoryOnSuccess() async throws {
    let expected = [
        Movie(title: "Movie A", originalLanguage: "en", releaseDate: "2024-01-01", posterUrl: "https://example.com/a.jpg"),
        Movie(title: "Movie B", originalLanguage: "pt", releaseDate: "2024-02-02", posterUrl: "https://example.com/b.jpg")
    ]
    let useCase = GetPopularMoviesListUseCase(movieRepository: MockMovieRepository(behavior: .success(expected)))

    let result = try await useCase.execute(page: 1)

    #expect(result == expected)
}

@Test
func executePropagatesErrorFromRepository() async {
    let useCase = GetPopularMoviesListUseCase(movieRepository: MockMovieRepository(behavior: .failure(TestError.boom)))

    await #expect(throws: TestError.boom) {
        try await useCase.execute(page: 1)
    }
}
