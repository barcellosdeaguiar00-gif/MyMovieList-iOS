import Foundation
import MMLCore

public protocol APIClient: Sendable {
    func fetchPopularMovies(page: Int) async throws -> FetchPopularMoviesResponseDTO
}

public struct URLSessionAPIClient: APIClient {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    // api_key is appended as a query parameter on every request (mirrors the Ktor
    // ApiKeyPlugin on the Android side), not sent as a header.
    public static func buildRequest(page: Int, baseURL: String = TMDBSecrets.baseURL, apiKey: String = TMDBSecrets.apiKey) -> URLRequest {
        var components = URLComponents(string: baseURL + "popular")
        components?.queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "api_key", value: apiKey)
        ]

        guard let url = components?.url else {
            fatalError("Failed to build TMDB popular movies URL from baseURL: \(baseURL)")
        }

        return URLRequest(url: url)
    }

    public func fetchPopularMovies(page: Int) async throws -> FetchPopularMoviesResponseDTO {
        let request = Self.buildRequest(page: page)

        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await session.data(for: request)
        } catch let urlError as URLError {
            throw Self.mapURLError(urlError)
        } catch {
            throw AppError.generic
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw AppError.generic
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw Self.mapHTTPError(statusCode: httpResponse.statusCode, data: data)
        }

        do {
            return try JSONDecoder().decode(FetchPopularMoviesResponseDTO.self, from: data)
        } catch {
            throw AppError.generic
        }
    }

    public static func mapURLError(_ error: URLError) -> AppError {
        switch error.code {
        case .notConnectedToInternet, .timedOut, .networkConnectionLost, .cannotConnectToHost, .cannotFindHost, .dataNotAllowed, .internationalRoamingOff:
            return .noConnection
        default:
            return .generic
        }
    }

    public static func mapHTTPError(statusCode: Int, data: Data) -> AppError {
        .http(message: extractErrorMessage(from: data), code: statusCode)
    }

    public static func extractErrorMessage(from data: Data) -> String {
        if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            if let message = json["status_message"] as? String {
                return message
            }
            if let message = json["message"] as? String {
                return message
            }
        }
        return "HTTP error"
    }
}
