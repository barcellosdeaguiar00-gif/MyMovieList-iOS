public struct MovieSection: Sendable, Equatable, Identifiable {
    public let title: String
    public let movies: [Movie]

    public var id: String { title }

    public init(title: String, movies: [Movie]) {
        self.title = title
        self.movies = movies
    }
}
