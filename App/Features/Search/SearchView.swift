import MMLTheme
import SwiftUI

struct SearchView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image.mmlErrorDrawable()
                .resizable()
                .scaledToFit()

            Text("Under construction")
                .mmlBodyMedium()
                .foregroundStyle(Color.mmlOnSurface)
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mmlBackground)
    }
}
