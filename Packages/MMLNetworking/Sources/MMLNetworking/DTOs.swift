import Foundation

public struct MovieResponseDTO: Decodable, Sendable, Equatable {
    public let title: String
    public let releaseDate: String
    public let originalLanguage: String
    public let posterPath: String?

    private enum CodingKeys: String, CodingKey {
        case title
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case posterPath = "poster_path"
    }

    public init(title: String, releaseDate: String, originalLanguage: String, posterPath: String?) {
        self.title = title
        self.releaseDate = releaseDate
        self.originalLanguage = originalLanguage
        self.posterPath = posterPath
    }
}

public struct FetchPopularMoviesResponseDTO: Decodable, Sendable, Equatable {
    public let results: [MovieResponseDTO]

    private enum CodingKeys: String, CodingKey {
        case results
    }

    public init(results: [MovieResponseDTO]) {
        self.results = results
    }
}
