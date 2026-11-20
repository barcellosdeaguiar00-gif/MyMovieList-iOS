import MMLDomain
import MMLNetworking

public struct MovieMapper: Sendable {
    public init() {}

    private static let basePosterUrl = "https://image.tmdb.org/t/p/original"

    public func toMovieList(_ response: FetchPopularMoviesResponseDTO) -> [Movie] {
        response.results.map(Self.toMovie)
    }

    private static func toMovie(_ dto: MovieResponseDTO) -> Movie {
        Movie(
            title: dto.title,
            originalLanguage: dto.originalLanguage,
            releaseDate: dto.releaseDate,
            posterUrl: buildPosterImageUrl(dto.posterPath)
        )
    }

    private static func buildPosterImageUrl(_ posterPath: String?) -> String {
        guard let posterPath else { return "" }
        return basePosterUrl + posterPath
    }
}
