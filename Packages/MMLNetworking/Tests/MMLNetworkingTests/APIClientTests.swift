import Foundation
import Testing
import MMLCore
@testable import MMLNetworking

@Suite("URLSessionAPIClient.buildRequest")
struct BuildRequestTests {
    @Test("includes page and api_key query items with correct values")
    func includesExpectedQueryItems() {
        let request = URLSessionAPIClient.buildRequest(page: 2, baseURL: "https://api.themoviedb.org/3/movie/", apiKey: "test-key")

        guard let url = request.url, let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            Issue.record("Request has no valid URL")
            return
        }

        let queryItems = components.queryItems ?? []
        #expect(queryItems.contains(URLQueryItem(name: "page", value: "2")))
        #expect(queryItems.contains(URLQueryItem(name: "api_key", value: "test-key")))
    }

    @Test("appends popular path to the base URL")
    func appendsPopularPath() {
        let request = URLSessionAPIClient.buildRequest(page: 1, baseURL: "https://api.themoviedb.org/3/movie/", apiKey: "test-key")

        #expect(request.url?.path == "/3/movie/popular")
    }
}

@Suite("URLSessionAPIClient error mapping")
struct ErrorMappingTests {
    @Test("maps notConnectedToInternet to AppError.noConnection")
    func mapsNoConnection() {
        let error = URLError(.notConnectedToInternet)
        #expect(URLSessionAPIClient.mapURLError(error) == .noConnection)
    }

    @Test("maps timedOut to AppError.noConnection")
    func mapsTimeout() {
        let error = URLError(.timedOut)
        #expect(URLSessionAPIClient.mapURLError(error) == .noConnection)
    }

    @Test("maps unrelated URLError codes to AppError.generic")
    func mapsGeneric() {
        let error = URLError(.badURL)
        #expect(URLSessionAPIClient.mapURLError(error) == .generic)
    }

    @Test("extracts status_message from a simple JSON error body")
    func extractsStatusMessage() {
        let data = Data(#"{"status_message": "Invalid API key", "status_code": 7}"#.utf8)
        #expect(URLSessionAPIClient.extractErrorMessage(from: data) == "Invalid API key")
    }

    @Test("falls back to a generic message when body is not JSON")
    func fallsBackToGenericMessage() {
        let data = Data("not json".utf8)
        #expect(URLSessionAPIClient.extractErrorMessage(from: data) == "HTTP error")
    }

    @Test("maps a 404 status code to AppError.http with code 404")
    func maps404() {
        let data = Data(#"{"status_message": "Resource not found"}"#.utf8)
        #expect(URLSessionAPIClient.mapHTTPError(statusCode: 404, data: data) == .http(message: "Resource not found", code: 404))
    }

    @Test("maps a 500 status code to AppError.http with code 500")
    func maps500() {
        let data = Data("".utf8)
        #expect(URLSessionAPIClient.mapHTTPError(statusCode: 500, data: data) == .http(message: "HTTP error", code: 500))
    }
}
