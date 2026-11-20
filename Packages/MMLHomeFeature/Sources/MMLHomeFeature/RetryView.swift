import MMLTheme
import SwiftUI

public struct RetryView: View {
    private let action: () -> Void

    public init(action: @escaping () -> Void) {
        self.action = action
    }

    public var body: some View {
        VStack {
            Spacer()

            Image.mmlErrorDrawable()
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("Ops... Something Went Wrong")
                .mmlBodyLarge()
                .foregroundStyle(Color.mmlOnSurface)

            Spacer()

            Button("Retry", action: action)
                .frame(maxWidth: .infinity)
        }
        .padding(16)
    }
}
