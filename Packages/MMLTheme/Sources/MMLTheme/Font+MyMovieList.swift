import SwiftUI

@available(macOS 10.15, iOS 13.0, *)
public extension Font {
    static let mmlDisplayLarge = Font.custom("Montserrat-Regular", size: 57)
    static let mmlDisplayMedium = Font.custom("Montserrat-Regular", size: 45)
    static let mmlDisplaySmall = Font.custom("Montserrat-Regular", size: 36)

    static let mmlHeadlineLarge = Font.custom("Montserrat-Regular", size: 32)
    static let mmlHeadlineMedium = Font.custom("Montserrat-Regular", size: 28)
    static let mmlHeadlineSmall = Font.custom("Montserrat-Regular", size: 24)

    static let mmlTitleLarge = Font.custom("Montserrat-Regular", size: 22)
    static let mmlTitleMedium = Font.custom("Montserrat-Medium", size: 16)
    static let mmlTitleSmall = Font.custom("Montserrat-Medium", size: 14)

    static let mmlLabelLarge = Font.custom("Montserrat-Medium", size: 14)
    static let mmlLabelMedium = Font.custom("Montserrat-Medium", size: 12)
    static let mmlLabelSmall = Font.custom("Montserrat-Medium", size: 11)

    static let mmlBodyLarge = Font.custom("Montserrat-Regular", size: 16)
    static let mmlBodyMedium = Font.custom("Montserrat-Regular", size: 14)
    static let mmlBodySmall = Font.custom("Montserrat-Regular", size: 12)
}

@available(macOS 10.15, iOS 13.0, *)
public extension Text {
    func mmlDisplayLarge() -> some View {
        self.font(.mmlDisplayLarge)
            .tracking(-0.25)
            .lineSpacing(7)
    }

    func mmlDisplayMedium() -> some View {
        self.font(.mmlDisplayMedium)
            .lineSpacing(7)
    }

    func mmlDisplaySmall() -> some View {
        self.font(.mmlDisplaySmall)
            .lineSpacing(8)
    }

    func mmlHeadlineLarge() -> some View {
        self.font(.mmlHeadlineLarge)
            .lineSpacing(8)
    }

    func mmlHeadlineMedium() -> some View {
        self.font(.mmlHeadlineMedium)
            .lineSpacing(8)
    }

    func mmlHeadlineSmall() -> some View {
        self.font(.mmlHeadlineSmall)
            .lineSpacing(8)
    }

    func mmlTitleLarge() -> some View {
        self.font(.mmlTitleLarge)
            .lineSpacing(6)
    }

    func mmlTitleMedium() -> some View {
        self.font(.mmlTitleMedium)
            .tracking(0.15)
            .lineSpacing(8)
    }

    func mmlTitleSmall() -> some View {
        self.font(.mmlTitleSmall)
            .tracking(0.1)
            .lineSpacing(6)
    }

    func mmlLabelLarge() -> some View {
        self.font(.mmlLabelLarge)
            .tracking(0.1)
            .lineSpacing(6)
    }

    func mmlLabelMedium() -> some View {
        self.font(.mmlLabelMedium)
            .tracking(0.5)
            .lineSpacing(4)
    }

    func mmlLabelSmall() -> some View {
        self.font(.mmlLabelSmall)
            .tracking(0.5)
            .lineSpacing(5)
    }

    func mmlBodyLarge() -> some View {
        self.font(.mmlBodyLarge)
            .tracking(0.5)
            .lineSpacing(8)
    }

    func mmlBodyMedium() -> some View {
        self.font(.mmlBodyMedium)
            .tracking(0.25)
            .lineSpacing(6)
    }

    func mmlBodySmall() -> some View {
        self.font(.mmlBodySmall)
            .tracking(0.4)
            .lineSpacing(4)
    }
}
