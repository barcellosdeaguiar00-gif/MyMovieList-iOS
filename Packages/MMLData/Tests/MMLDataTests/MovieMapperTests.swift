@testable import MMLData
import MMLNetworking
import Testing

@Suite("MovieMapper")
struct MovieMapperTests {
    @Test("maps DTO fields to Movie fields and builds the poster URL when posterPath is present")
    func mapsFieldsWithPosterPath() {
        let dto = MovieResponseDTO(
            title: "Inception",
            releaseDate: "2010-07-16",
            originalLanguage: "en",
            posterPath: "/abc123.jpg"
        )
        let response = FetchPopularMoviesResponseDTO(results: [dto])

        let movies = MovieMapper().toMovieList(response)

        #expect(movies.count == 1)
        #expect(movies[0].title == "Inception")
        #expect(movies[0].releaseDate == "2010-07-16")
        #expect(movies[0].originalLanguage == "en")
        #expect(movies[0].posterUrl == "https://image.tmdb.org/t/p/original/abc123.jpg")
    }

    @Test("maps a nil posterPath to an empty poster URL")
    func mapsNilPosterPathToEmptyString() {
        let dto = MovieResponseDTO(
            title: "Untitled",
            releaseDate: "2024-01-01",
            originalLanguage: "fr",
            posterPath: nil
        )
        let response = FetchPopularMoviesResponseDTO(results: [dto])

        let movies = MovieMapper().toMovieList(response)

        #expect(movies[0].posterUrl == "")
    }

    @Test("maps an empty results list to an empty movie list")
    func mapsEmptyResults() {
        let response = FetchPopularMoviesResponseDTO(results: [])
        let movies = MovieMapper().toMovieList(response)
        #expect(movies.isEmpty)
    }
}
