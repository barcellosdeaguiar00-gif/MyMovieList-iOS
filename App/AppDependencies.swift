import MMLData
import MMLDomain
import MMLHomeFeature
import MMLNetworking

struct AppDependencies {
    private let movieRepository: MovieRepository

    init() {
        let apiClient = URLSessionAPIClient()
        movieRepository = MovieRepositoryImpl(apiClient: apiClient)
    }

    @MainActor
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(getPopularMoviesListUseCase: GetPopularMoviesListUseCase(movieRepository: movieRepository))
    }
}
