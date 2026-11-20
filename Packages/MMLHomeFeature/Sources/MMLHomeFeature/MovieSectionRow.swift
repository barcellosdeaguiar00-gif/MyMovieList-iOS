import MMLDomain
import SwiftUI

struct MovieSectionRow: View {
    private static let rowHeight: CGFloat = 196

    let movies: [Movie]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(
                rows: [
                    GridItem(.fixed(Self.rowHeight)),
                    GridItem(.fixed(Self.rowHeight))
                ],
                spacing: 8
            ) {
                ForEach(movies) { movie in
                    PosterCard(movie: movie)
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 400)
    }
}
