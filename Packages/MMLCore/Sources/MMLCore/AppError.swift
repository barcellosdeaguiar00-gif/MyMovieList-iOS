public enum AppError: Error, Equatable, Sendable {
    case noConnection
    case http(message: String, code: Int)
    case generic
}
