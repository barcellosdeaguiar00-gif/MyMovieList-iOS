import SwiftUI

#if canImport(UIKit)
import UIKit

public extension Image {
    static func mmlErrorDrawable() -> Image {
        loadBundledImage(named: "error_drawable", extension: "png", systemFallback: "exclamationmark.triangle")
    }

    static func mmlIconFilm() -> Image {
        loadBundledImage(named: "icon_film", extension: "webp", systemFallback: "film")
    }

    private static func loadBundledImage(named name: String, extension ext: String, systemFallback: String) -> Image {
        guard let path = Bundle.module.path(forResource: name, ofType: ext),
              let uiImage = UIImage(contentsOfFile: path) else {
            return Image(systemName: systemFallback)
        }
        return Image(uiImage: uiImage)
    }
}
#endif
