import MMLDomain
import MMLTheme
import SwiftUI

struct PosterCard: View {
    /// The Android grid cell has no direct 1:1 equivalent in a LazyHGrid (which sizes
    /// columns by the GridItem spec, not by content), so a fixed width stands in for
    /// the Android `fillMaxWidth` behavior inside its own grid cell.
    private static let width: CGFloat = 140

    let movie: Movie

    var body: some View {
        AsyncImage(url: URL(string: movie.posterUrl)) { phase in
            switch phase {
            case let .success(image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            default:
                placeholder
            }
        }
        .frame(width: Self.width)
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: MMLCornerRadius.small)
                .fill(Color.mmlSurface)
        )
        .clipShape(RoundedRectangle(cornerRadius: MMLCornerRadius.small))
        .shadow(radius: 8)
    }

    private var placeholder: some View {
        ZStack {
            Image.mmlIconFilm()
                .resizable()
                .aspectRatio(contentMode: .fit)
            ProgressView()
        }
    }
}
