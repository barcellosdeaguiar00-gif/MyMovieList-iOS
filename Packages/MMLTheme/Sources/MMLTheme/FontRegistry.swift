import CoreText
import Foundation

public func registerMMLFonts() {
    let fontNames = [
        "montserrat_regular.ttf",
        "montserrat_medium.ttf",
        "montserrat_semibold.ttf"
    ]

    for fontName in fontNames {
        guard let fontURL = Bundle.module.url(forResource: fontName, withExtension: nil) else {
            continue
        }

        var error: Unmanaged<CFError>?
        CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, &error)

        if error != nil {
            print("Failed to register font \(fontName)")
        }
    }
}
