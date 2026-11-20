import Foundation

public enum TMDBSecrets {
    public static var apiKey: String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: "TMDB_API_KEY") as? String,
              !value.isEmpty
        else {
            fatalError(
                "TMDB_API_KEY is missing from Info.plist. "
                    + "Make sure Secrets.xcconfig is configured and the app target's Info.plist exposes TMDB_API_KEY."
            )
        }
        return value
    }

    public static var baseURL: String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: "TMDB_API_URL") as? String,
              !value.isEmpty
        else {
            fatalError(
                "TMDB_API_URL is missing from Info.plist. "
                    + "Make sure Secrets.xcconfig is configured and the app target's Info.plist exposes TMDB_API_URL."
            )
        }
        return value
    }
}
