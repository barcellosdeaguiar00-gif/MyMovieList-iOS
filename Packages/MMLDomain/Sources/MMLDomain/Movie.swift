public struct Movie: Sendable, Equatable, Identifiable {
    public let title: String
    public let originalLanguage: String
    public let releaseDate: String
    public let posterUrl: String

    // No stable backend id is available on this model; derive one deterministically
    // from title+releaseDate so Identifiable is stable across re-fetches of the same data.
    public var id: String { "\(title)-\(releaseDate)" }

    public init(title: String, originalLanguage: String, releaseDate: String, posterUrl: String) {
        self.title = title
        self.originalLanguage = originalLanguage
        self.releaseDate = releaseDate
        self.posterUrl = posterUrl
    }
}
