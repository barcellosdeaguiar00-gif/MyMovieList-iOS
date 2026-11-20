import MMLDomain

public enum HomeViewState: Equatable {
    case loading
    case content([Movie])
    case retry
}
